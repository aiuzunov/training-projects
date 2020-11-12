import errno
import os
import signal
import socket
import subprocess
import sys
import time

from datetime import datetime
from functools import wraps
from multiprocessing import Pool
from collections import namedtuple
from pathlib import Path

#logging.basicConfig(filename='example.log', level=logging.DEBUG)

MaxProcesses = 20
Processes = []
SERVER_ADDRESS = (HOST, PORT) = '', 9101
REQUEST_QUEUE_SIZE = 1024
#
# class TimeoutError(Exception):
#     def __init__(self, value = "Timed Out"):
#         self.value = value
#     def __str__(self):
#         return repr(self.value)
#
# def timeout(seconds=5, error_message=os.strerror(errno.ETIME)):
#     def decorator(func):
#         def _handle_timeout(signum, frame):
#             raise TimeoutError(error_message)
#
#         def wrapper(*args, **kwargs):
#             signal.signal(signal.SIGALRM, _handle_timeout)
#             signal.alarm(seconds)
#             try:
#                 result = func(*args, **kwargs)
#             finally:
#                 signal.alarm(0)
#             return result
#
#         return wraps(func)(wrapper)
#
#     return decorator
def _handle_timeout(signum, frame):
    raise TimeoutError
def get_date():
    now = datetime.now()
    curr_date = now.strftime("%c") + ' (GMT+3)'
    return curr_date


# def grim_reaper(signum, frame):
#     while True:
#         try:
#             pid, status = os.waitpid(
#                 -1,
#                  os.WNOHANG
#             )
#         except OSError as e:
#             return
#
#         if pid == 0:
#             return


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
        data = f.read(65536)
        if not data:
            break
        yield data



class RESP_METH:
    response_phrases = {
        b'200': b'OK',
        b'400': b'Bad Request',
        b'404': b'Not Found',
        b'408': b'Request Timeout',
        b'500': b'Internal Server Error',
        b'502': b'Bad Gateway',
        b'503': b'Service Unavailable',
        b'413': b'Request Entity Too Large',
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
            if b'\r\n\r\n' in part:
                headers = part.split(b'\r\n\r\n', 1)[0]
                body =  part.split(b'\r\n\r\n', 1)[1]
                return [headers,body]
            else:
                return 1
    except Exception as e:
        return -1

        # if len(data) > 8192:
        #     headers = data.split(b'\r\n\r\n', 1)[0]
        #     body =  data.split(b'\r\n\r\n', 1)[1]
        #     if len(headers)>8192:
        #         return -1
        #     break
#
# def send_body(process,sock):
#     BUFF_SIZE = 4096
#     while True:
#         try:
#             part = sock.recv(BUFF_SIZE)
#         except socket.error as e:
#             break
#         process.stdin.write(part)

def CheckRunning():
   global Processes

   for p in reversed(range(len(Processes))):
      if Processes[p].poll() is not None:
         del Processes[p]

#@timeout(10, os.strerror(errno.ETIMEDOUT))
def handle_request(client_connection,client_address):
    global Processes
    client_connection.settimeout(5)
    request = recvall(client_connection)
    assert isinstance(request,(list,int))
    if request == -1:
        return
    elif request == 1:
        code_response(b'413',client_connection)
        return
    parsed_request = parse_http_request(request)
    if parsed_request == None:
        try:
            code_response(b'501',client_connection)
            #if len(client_writer.get_extra_info('peername')[0])>0:
                #logger.warning("Client: {} Error with request".format(client_writer.get_extra_info('peername')[0]))
            return
        except Exception as e:
            print(e)
            #logger.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))
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
                if parsed_request[0].method==b'GET':
                    try:
                        send_file(res,"/index.html",client_connection)
                    except Exception as e:
                        print(e)
                        code_response(b'501',client_connection)
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
                    while (len(Processes) >= MaxProcesses):
                        CheckRunning()

                    process = subprocess.Popen(script_args, stdin=subprocess.PIPE,
                                                stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                    Processes.append(process)
                    try:
                        signal.signal(signal.SIGALRM, _handle_timeout)
                        signal.alarm(5)
                        if parsed_request[0].method == b'POST':
                            if parsed_request[1] != b'':
                                process.stdin.write(parsed_request[1])
                            if int(parsed_request[0].headers[b'Content-Length'].decode('utf-8')) - len(request[1]) > 0:
                                while True:
                                    part = client_connection.read(8192)
                                    if len(part) < 8192:
                                        break
                                    process.stdin.write(part)
                                    process.stdin.flush()
                            line = None
                            data = 'HTTP/1.0 200 OK\rDate: {}\rConnection: keep-alive\r'.format(get_date()).encode()
                            client_connection.send(data)
                            try:
                                stdout, stderr = process.communicate(timeout = 15)
                            except TimeoutExpired:
                                process.kill()
                                outs, errs = process.communicate()
                            client_connection.send(stdout)
                            client_connection.close()
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
                            try:
                                stdout, stderr = process.communicate(timeout = 15)
                            except TimeoutExpired:
                                process.kill()
                                outs, errs = process.communicate()
                            client_connection.send(stdout)
                            client_connection.close()
                            if line == None:
                                return
                            else:
                                pass
                                #logging.info("Client IP Address: {}, File Extension: {}, Method: {}, Path: {}, Query: {}".format(client_address[0],ext,parsed_request[0].method.decode('utf-8'),parsed_request[0].path,parsed_request[0].query_string))
                                #logging.debug("Client: {}, User-Agent: {}".format(client_address[0],parsed_request[0].headers[b'User-Agent'].decode('utf-8')))
                        else:
                            return
                    except TimeoutError:
                            code_response(b'408',client_connection)
                            return
                    finally:
                        signal.alarm(0)
            else:
                try:
                    send_file(res,parsed_request[0].path,client_connection)
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
            code_response(b'404',client_connection)
            #logging.warning("Client: {} Requested Non Existent File\Path: {}".format(client_address[0],parsed_request[0].path))
        except Exception as e:
            print(e)
            # exc_type, exc_obj, exc_tb = sys.exc_info()
            # fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
            # logging.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))

def code_response(status_code,client_connection):
    response = "HTTP/1.0 {0} {1}\r\n".format(status_code.decode('utf-8'),RESP_METH.response_phrases[status_code].decode())+"\r\n\r\nError {0} \r\n{1}".format(status_code.decode('utf-8'),RESP_METH.response_phrases[status_code].decode())
    client_connection.sendall(response.encode())
    client_connection.close()


def send_file(res,path,client_connection):
    client_connection.send(res)
    with open("."+path, "rb") as f:
        for chunk in chunks(f):
            client_connection.send(chunk)
    client_connection.close()


def serve_forever():
    listen_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    listen_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    listen_socket.bind(SERVER_ADDRESS)
    listen_socket.listen(REQUEST_QUEUE_SIZE)

    for i in range(5):
        pid = os.fork()

        if pid == 0:
            childpid = os.getpid()
            print("Child {} listening on localhost:{}".format(childpid,PORT))
            try:
                while 1:
                    conn, addr = listen_socket.accept()
                    handle_request(conn, addr)
                    conn.close()
            except KeyboardInterrupt as e:
                sys.exit()
    try:
        os.waitpid(-1, 0)
    except KeyboardInterrupt:
        print("\nbailing")
        sys.exit()

if __name__ == '__main__':
    serve_forever()
