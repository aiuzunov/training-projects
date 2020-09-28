import errno
import os
import signal
import sys
import socket
import subprocess
import requests as req
import urllib.parse
import json
import logging
import threading


from _thread import *
from datetime import datetime
from collections import namedtuple
from pathlib import Path
from Logs import LogInit

print_lock = threading.Lock()


try:
    logger = logging.getLogger('Web Server Logger')
    logger.setLevel(logging.DEBUG)

    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

    LogInit(logger,logging.WARNING,'./logs/warning.log',formatter).initialize()
    LogInit(logger,logging.ERROR,'./logs/error.log',formatter).initialize()
    LogInit(logger,logging.INFO,'./logs/info.log',formatter).initialize()
    LogInit(logger,logging.DEBUG,'./logs/debug.log',formatter).initialize()
except Exception as e:
    exc_type, exc_obj, exc_tb = sys.exc_info()
    fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
    print(e,exc_type, fname, exc_tb.tb_lineno)




SERVER_ADDRESS = (HOST, PORT) = '', 9100
REQUEST_QUEUE_SIZE = 2048

def get_date():
    now = datetime.now()
    curr_date = now.strftime("%c") + ' (GMT+3)'
    return curr_date


def grim_reaper(signum, frame):
    while True:
        try:
            pid, status = os.waitpid(
                -1,
                 os.WNOHANG
            )
        except OSError as e:
            return

        if pid == 0:
            return


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
        exc_type, exc_obj, exc_tb = sys.exc_info()
        fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
        logger.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))


def parse_http_request(request):
    split_response = request.split(b'\r\n\r\n', 1)
    start_line_and_headers = split_response[0].split(b'\r\n')
    request_line = start_line_and_headers[0]
    start_line_parts = request_line.split(b' ')
    method = start_line_parts[0]
    path = ''
    try:
        path = urllib.parse.unquote(start_line_parts[1].decode())


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
    except Exception as e:
        exc_type, exc_obj, exc_tb = sys.exc_info()
        fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
        logger.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))

    return [result,body]


def gen_res(status_code, headers={}, body=b''):
    result = (b'HTTP/1.0 ' + status_code + b' ' +
              RESP_METH.response_phrases[status_code])
    for field_name, field_value in headers.items():
        result += (b'\r\n' + field_name + b': ' + field_value)

    result += (b'\r\n\r\n' + body)
    return result

def recvall(sock):
    BUFF_SIZE = 8192
    data = b''
    while True:
        part = sock.recv(BUFF_SIZE)
        data += part
        if len(part) < BUFF_SIZE:
            break
    return data

def handle_request(client_connection,client_address):
    request = recvall(client_connection)
    print_lock.release()
    parsed_request = parse_http_request(request)
    res = gen_res(b'200',parsed_request[0].headers,parsed_request[1])
    data = ""
    try:
        path =  Path("./{path}".format(path=parsed_request[0].path))
        ext = Path("./{path}".format(path=parsed_request[0].path)).suffix
    except Exception as e:
        exc_type, exc_obj, exc_tb = sys.exc_info()
        fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
        logger.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))

    if path.exists():
        if path.is_dir():
            try:
                chunk = None
                data += res.decode('utf-8')
                client_connection.send(data.encode())
                if parsed_request[0].method==b'GET':
                    with open("./index.html", "rb") as f:
                        for chunk in chunks(f):
                            client_connection.send(chunk)
                        client_connection.close()
                        if chunk != None:
                            logger.debug("Client: {}, User-Agent: {}".format(client_address[0],parsed_request[0].headers[b'User-Agent'].decode('utf-8')))
                            logger.info("Client IP Address: {}, File Extension: {}, Method: {}, Path: {}".format(client_address[0],ext,parsed_request[0].method.decode('utf-8'),parsed_request[0].path))
            except Exception as e:
                exc_type, exc_obj, exc_tb = sys.exc_info()
                fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
                logger.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))
        if path.is_file():
            if str(path).startswith("cgi-bin") and ext == '.py':
                executable = sys.executable
                if executable:
                    try:
                        set_environment(headers = parsed_request[0].headers,
                        arguments = parsed_request[0].query_string,
                        path=str(path),
                        protocol=parsed_request[0].http_version.decode('utf-8'),
                        client_address=client_address[0],
                        server_port='9100'
                        )
                    except Exception as e:
                        exc_type, exc_obj, exc_tb = sys.exc_info()
                        fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
                        logger.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))
                    script_args = [executable,str(path)]
                    process = subprocess.Popen(script_args, stdin=subprocess.PIPE,
                                                stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                    try:
                        request_headers = b''
                        if parsed_request[0].method == b'POST':
                            if parsed_request[1] != b'':
                                process.stdin.write(parsed_request[1])
                            bytes_read = len(parsed_request[1])
                            process.stdin.close()
                            line = None
                            data = 'HTTP/1.0 200 OK\rDate: {}\rConnection: keep-alive\r'.format(get_date()).encode()
                            client_connection.send(data)
                            for line in process.stdout:
                                client_connection.send(line)
                            client_connection.close()
                            if line == None:
                                return
                            else:
                                logger.debug("Client: {}, User-Agent: {}".format(client_address[0],parsed_request[0].headers[b'User-Agent'].decode('utf-8')))
                                logger.info("Client IP Address: {}, File Extension: {}, Method: {}, Path: {}, Body: {}".format(client_address[0],ext,parsed_request[0].method.decode('utf-8'),parsed_request[0].path,parsed_request[1]))

                        elif parsed_request[0].method == b'GET':
                            line = None
                            data = 'HTTP/1.0 200 OK\rDate: {}\rConnection: keep-alive\r'.format(get_date()).encode()
                            client_connection.send(data)
                            for line in process.stdout:
                                try:
                                    client_connection.send(line)
                                except Exception as e:
                                    exc_type, exc_obj, exc_tb = sys.exc_info()
                                    fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
                                    logger.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))
                            client_connection.close()
                            if line == None:
                                return
                            else:
                                logger.info("Client IP Address: {}, File Extension: {}, Method: {}, Path: {}, Query: {}".format(client_address[0],ext,parsed_request[0].method.decode('utf-8'),parsed_request[0].path,parsed_request[0].query_string))
                                logger.debug("Client: {}, User-Agent: {}".format(client_address[0],parsed_request[0].headers[b'User-Agent'].decode('utf-8')))
                        else:
                            return
                    except Exception as e:
                        exc_type, exc_obj, exc_tb = sys.exc_info()
                        fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
                        logger.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))
            else:
                data += res.decode('utf-8')
                chunk = None
                try:
                    client_connection.send(data.encode())
                    with open("."+parsed_request[0].path, "rb") as f:
                        for chunk in chunks(f):
                            client_connection.send(chunk)
                        client_connection.close()
                        if chunk != None:
                            logger.debug("Client: {}, User-Agent: {}".format(client_address[0],parsed_request[0].headers[b'User-Agent'].decode('utf-8')))
                            logger.info("Client IP Address: {}, File Extension: {}, Method: {}, Path: {}".format(client_address[0],ext,parsed_request[0].method.decode('utf-8'),parsed_request[0].path))
                except Exception as e:
                    exc_type, exc_obj, exc_tb = sys.exc_info()
                    fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
                    logger.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))
    else:
        try:
            doesnt_exist = b"HTTP/1.0 404 Not Found\r\n"+b"\r\n\r\nError 404 \r\nResource not found"
            client_connection.sendall(doesnt_exist)
            logger.warning("Client: {} Requested Non Existent File\Path: {}".format(client_address[0],parsed_request[0].path))
        except Exception as e:
            exc_type, exc_obj, exc_tb = sys.exc_info()
            fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
            logger.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))

def serve_forever():
    try:
        listen_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        listen_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        listen_socket.bind(SERVER_ADDRESS)
        listen_socket.listen(REQUEST_QUEUE_SIZE)
        print('The HTTP server is listening on PORT {port}'.format(port=PORT))
    except Exception as e:
        exc_type, exc_obj, exc_tb = sys.exc_info()
        fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
        logger.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))
    try:
        signal.signal(signal.SIGCHLD, grim_reaper)
    except Exception as e:
        exc_type, exc_obj, exc_tb = sys.exc_info()
        fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
        logger.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))
    while True:
        try:
            client_connection, client_address = listen_socket.accept()
        except IOError as e:
            code, msg = e.args
            if code == errno.EINTR:
                continue
            else:
                raise

        try:
            print_lock.acquire()
            start_new_thread(handle_request, (client_connection, client_address, ))
        except Exception as e:
            exc_type, exc_obj, exc_tb = sys.exc_info()
            fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
            logger.error("1{} {} {} ".format(e, fname, exc_tb.tb_lineno))
    listen_socket.close()


if __name__ == '__main__':
    serve_forever()
