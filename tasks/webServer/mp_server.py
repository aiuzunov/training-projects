import multiprocessing as mp
import logging
import socket
import time
import signal
import errno
import os
import subprocess
import sys

from datetime import datetime
from collections import namedtuple
from pathlib import Path

SERVER_ADDRESS = (HOST, PORT) = '', 9100
REQUEST_QUEUE_SIZE = 1024

logger = mp.log_to_stderr(logging.DEBUG)

def _handle_timeout(signum, frame):
    raise TimeoutError
def get_date():
    now = datetime.now()
    curr_date = now.strftime("%c") + ' (GMT+3)'
    return curr_date



META = namedtuple('META', [
    'method',
    'path',
    'query_string',
    'http_version',
    'headers',
    'user_agent',
])

def chunks(f):
    while True:
        data = f.read(8192)
        if not data:
            break
        yield data



class RESP_METH:
    request_methods = [b'GET', b'HEAD', b'POST', b'PUT', b'DELETE',
                      b'CONNECT', b'OPTIONS', b'TRACE']
    response_phrases = {
        b'200': b'OK',
        b'400': b'Bad Request',
        b'404': b'Not Found',
        b'408': b'Request Timeout',
        b'500': b'Internal Server Error',
        b'502': b'Bad Gateway',
        b'503': b'Service Unavailable',
    }

def set_environment(*args, **kwargs):
    try:
        SERVER_PROTOCOL = kwargs['protocol']
        os.environ['SERVER_PORT'] = kwargs.get('server_port', '')
        os.environ['REQUEST_METHOD'] = kwargs.get('protocol','')
        os.environ['QUERY_STRING'] = kwargs.get('arguments', '')
        os.environ['SCRIPT_NAME'] = kwargs.get('path', '')
        os.environ['CONTENT_TYPE'] = kwargs.get('headers').get(b'Content-Type',b'').decode('utf-8')
        os.environ['CONTENT_LENGTH'] = kwargs.get('headers').get(b'Content-Length',b'').decode('utf-8')
        os.environ['REMOTE_ADDR'] = kwargs.get('client_address', '')
        os.environ['HTTP_ACCEPT'] = kwargs.get('headers').get(b'Accept',b'').decode('utf-8')
    except Exception as e:
        print(e)
        # exc_type, exc_obj, exc_tb = sys.exc_info()
        # fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
        # logging.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))


def parse_http_request(request):
    try:
        assert len(request) == 2,"Bad request"
        split_response = request
        start_line_and_headers = split_response[0].split(b'\r\n')
        assert len(start_line_and_headers) > 0,"Bad length for start_line_and_headers"
        request_line = start_line_and_headers[0]
        start_line_parts = request_line.split(b' ')
        assert len(start_line_parts) == 3
        method = start_line_parts[0]
        path = start_line_parts[1].decode()
        assert isinstance(path, str)
        if '?' in path:
            target_query_part = path.split('?', 1)[1]
            if len(target_query_part) > 0:
                query_string = target_query_part
            else:
                query_string = ''
        else:
            query_string = ''
        headers = {}
        for header_field in start_line_and_headers[1:]:
            header_field_split = header_field.split(b':', 1)
            field_name = header_field_split[0]
            field_value = header_field_split[1].strip()
            headers[field_name] = field_value
        if method == b'POST':
            body = split_response[1]

        else:
            body = b''
        if 'User-Agent' in headers:
            user_agent = headers['User-Agent']
        else:
            user_agent = None
        result = META(
            method=method,
            path=path.split('?', 1)[0],
            headers=headers,
            query_string=query_string,
            http_version=start_line_parts[2],
            user_agent=user_agent,
        )

        return [result,body]
    except Exception as e:
        print(e)
        # exc_type, exc_obj, exc_tb = sys.exc_info()
        # fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
        # print(e, fname, exc_tb.tb_lineno)
        return None

def gen_res(status_code, headers={}, body=b''):
    result = (b'HTTP/1.0 ' + status_code + b' ' +
              RESP_METH.response_phrases[status_code])
    assert len(headers)>0
    for field_name, field_value in headers.items():
        if field_name != b'Connection':
            result += (b'\r\n' + field_name + b': ' + field_value)

    result += (b'\r\n\r\n' + body)
    return result

def recvall(sock):
    try:
        BUFF_SIZE = 8192
        while True:
            part = sock.recv(BUFF_SIZE)
            if len(part) < BUFF_SIZE:
                headers = part.split(b'\r\n\r\n', 1)[0]
                body =  part.split(b'\r\n\r\n', 1)[1]
                return [headers,body]
            else:
                return 1
    except Exception as e:
        return -1


def handle_request(client_connection,client_address):
    client_connection.settimeout(10)
    request = recvall(client_connection)
    assert request!=None
    if request == -1:
        return
    parsed_request = parse_http_request(request)
    if request == 1 and parsed_request[0].method==b'GET':
        big_headers = b"HTTP/1.0 413 Entity Too Large\r\n"+b"\r\n\r\nError 413 \r\nEntity Too Large"
        client_connection.sendall(big_headers)
        return
    res = gen_res(b'200',parsed_request[0].headers,parsed_request[1])
    assert isinstance(res,(bytes, bytearray))
    try:
        path =  Path("./{path}".format(path=parsed_request[0].path))
        assert isinstance(path,Path)
        ext = Path("./{path}".format(path=parsed_request[0].path)).suffix
        assert isinstance(ext,str)
    except Exception as e:
        print(e)
        # exc_type, exc_obj, exc_tb = sys.exc_info()
        # fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
        # logging.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))

    if path.exists():
        if path.is_dir():
            try:
                chunk = None
                client_connection.send(res)
                if parsed_request[0].method==b'GET':
                    with open("./index.html", "rb") as f:
                        for chunk in chunks(f):
                            client_connection.send(chunk)
                        if chunk == None:
                            print("WHAT!!")
                            server_error = b"HTTP/1.0 501 Internal Server Error\r\n"+b"\r\n\r\nError 501 \r\nInternal Server Error"
                            client_connection.sendall(server_error)
                        #else:
                            #logging.debug("Client: {}, User-Agent: {}".format(client_address[0],parsed_request[0].headers[b'User-Agent'].decode('utf-8')))
                            #logging.info("Client IP Address: {}, File Extension: {}, Method: {}, Path: {}".format(client_address[0],ext,parsed_request[0].method.decode('utf-8'),parsed_request[0].path))
            except Exception as e:
                print(e)
                # exc_type, exc_obj, exc_tb = sys.exc_info()
                # fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
                # logging.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))
        if path.is_file():
            if str(path).startswith("cgi-bin") and ext == '.py':
                executable = sys.executable
                assert isinstance(executable,str)
                if executable:
                    try:
                        assert len(parsed_request) == 2
                        assert isinstance(parsed_request[0].headers,dict)
                        assert len(client_address) == 2
                        set_environment(headers = parsed_request[0].headers,
                        arguments = parsed_request[0].query_string,
                        path=str(path),
                        protocol=parsed_request[0].http_version.decode('utf-8'),
                        client_address=client_address[0],
                        server_port='9100'
                        )
                    except Exception as e:
                        print(e)
                        # exc_type, exc_obj, exc_tb = sys.exc_info()
                        # fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
                        # logging.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))
                    script_args = [executable,str(path)]
                    process = subprocess.Popen(script_args, stdin=subprocess.PIPE,
                                                stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                    try:
                        signal.signal(signal.SIGALRM, _handle_timeout)
                        signal.alarm(5)
                        if parsed_request[0].method == b'POST':
                            if parsed_request[1] != b'':
                                process.stdin.write(parsed_request[1])
                                process.stdin.flush()
                                if request == 1:
                                    while True:
                                        part = client_connection.recv(8192)
                                        if len(part) < 8192:
                                            break
                                        process.stdin.write(part)
                                        process.stdin.flush()
                            process.stdin.close()
                            line = None
                            data = 'HTTP/1.0 200 OK\rDate: {}\rConnection: keep-alive\r'.format(get_date()).encode()
                            client_connection.send(data)
                            while True:
                                next_line = process.stdout.readline()
                                if not next_line:
                                    break
                                process.stdout.flush()
                                client_connection.send(next_line)
                            # for line in process.stdout:
                            #     client_connection.send(line)
                            # if line == None:
                            #     return
                            #else:
                                #logging.debug("Client: {}, User-Agent: {}".format(client_address[0],parsed_request[0].headers[b'User-Agent'].decode('utf-8')))
                                #ogging.info("Client IP Address: {}, File Extension: {}, Method: {}, Path: {}, Body: {}".format(client_address[0],ext,parsed_request[0].method.decode('utf-8'),parsed_request[0].path,parsed_request[1]))

                        elif parsed_request[0].method == b'GET':
                            line = None
                            data = 'HTTP/1.0 200 OK\rDate: {}\rConnection: keep-alive\r'.format(get_date()).encode()
                            client_connection.send(data)
                            while True:
                                next_line = process.stdout.readline()
                                if not next_line:
                                    break
                                process.stdout.flush()
                                client_connection.send(next_line)
                            if line == None:
                                return
                            else:
                                pass
                                #logging.info("Client IP Address: {}, File Extension: {}, Method: {}, Path: {}, Query: {}".format(client_address[0],ext,parsed_request[0].method.decode('utf-8'),parsed_request[0].path,parsed_request[0].query_string))
                                #logging.debug("Client: {}, User-Agent: {}".format(client_address[0],parsed_request[0].headers[b'User-Agent'].decode('utf-8')))
                        else:
                            return
                    except TimeoutError:
                            timed_out = b"HTTP/1.0 408 Timed Out\r\n"+b"\r\n\r\nError 408 \r\nTimed Out"
                            client_connection.sendall(timed_out)
                            return
                    finally:
                        signal.alarm(0)

                        # exc_type, exc_obj, exc_tb = sys.exc_info()
                        # fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
                        # logging.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))
            else:
                chunk = None
                try:
                    client_connection.send(res)
                    with open("."+parsed_request[0].path, "rb") as f:
                        for chunk in chunks(f):
                            client_connection.send(chunk)
                        #if chunk != None:
                            #logging.debug("Client: {}, User-Agent: {}".format(client_address[0],parsed_request[0].headers[b'User-Agent'].decode('utf-8')))
                            #logging.info("Client IP Address: {}, File Extension: {}, Method: {}, Path: {}".format(client_address[0],ext,parsed_request[0].method.decode('utf-8'),parsed_request[0].path))
                except Exception as e:
                    print(e)
                    return
                    # exc_type, exc_obj, exc_tb = sys.exc_info()
                    # fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
                    # logging.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))
    else:
        try:
            doesnt_exist = b"HTTP/1.0 404 Not Found\r\n"+b"\r\n\r\nError 404 \r\nResource not found"
            client_connection.sendall(doesnt_exist)
            #logging.warning("Client: {} Requested Non Existent File\Path: {}".format(client_address[0],parsed_request[0].path))
        except Exception as e:
            print(e)
            # exc_type, exc_obj, exc_tb = sys.exc_info()
            # fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
            # logging.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))

def worker(socket):
    while True:
        client_connection, client_address = socket.accept()
        logger.debug("{u} connected".format(u=client_address))
        handle_request(client_connection,client_address)
        #client_connection.send(b"OK")
        client_connection.close()



def serve_forever():
    serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    serversocket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    serversocket.bind(SERVER_ADDRESS)
    serversocket.listen(REQUEST_QUEUE_SIZE)
    workers_cnt = 5

    workers = [mp.Process(target=worker, args=(serversocket,)) for i in
            range(workers_cnt)]

    for p in workers:
        p.daemon = True
        p.start()

    while True:
        try:
            time.sleep(10)
        except:
            break


if __name__ == '__main__':
    serve_forever()
