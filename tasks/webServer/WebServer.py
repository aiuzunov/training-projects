import errno
import os
import signal
import socket
import requests as req
import urllib.parse
from collections import namedtuple
import json


SERVER_ADDRESS = (HOST, PORT) = '', 5000
REQUEST_QUEUE_SIZE = 2048


def grim_reaper(signum, frame):
    while True:
        try:
            pid, status = os.waitpid(
                -1,
                 os.WNOHANG
            )
        except OSError:
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


def parse_http_request(request):
    split_response = request.split(b'\r\n\r\n', 1)
    assert len(split_response) == 2
    start_line_and_headers = split_response[0].split(b'\r\n')
    request_line = start_line_and_headers[0]
    start_line_parts = request_line.split(b' ')
    assert len(start_line_parts) == 3
    method = start_line_parts[0]
    assert method in RESP_METH.request_methods
    path = urllib.parse.unquote(start_line_parts[1].decode())
    if '?' in path:
        target_query_part = path.split('?', 1)[1]
        if len(target_query_part) > 0:
            query_string = target_query_part
        else:
            query_string = None
    else:
        query_string = None
    headers = {}

    for header_field in start_line_and_headers[1:]:
        header_field_split = header_field.split(b':', 1)
        assert len(header_field_split[0]) == len(
            header_field_split[0].strip()
        )
        field_name = header_field_split[0]
        field_value = header_field_split[1].strip()
        headers[field_name] = field_value

    body = split_response[1]
    user_agent = headers['User-Agent'] if 'User-Agent' in headers else None

    result = META(
        method=method,
        path=path,
        headers=headers,
        query_string=query_string,
        http_version=start_line_parts[2],
        user_agent=user_agent,
    )

    return [result,body]


def gen_res(status_code, headers={}, body=b''):
    assert type(status_code) is bytes
    assert type(headers) is dict
    assert type(body) is bytes
    assert status_code in RESP_METH.response_phrases
    if body!=b'':
        y = json.loads(body)
        body_result = '{"result":"' + str(float(y["first"]) + float(y["second"])) + '"}'
        body=body_result.encode('latin-1')

    result = (b'HTTP/1.0 ' + status_code + b' ' +
              RESP_METH.response_phrases[status_code])
    for field_name, field_value in headers.items():
        if field_name == b'Content-Length':
            result += (b'\r\n' + field_name + b': ' + str(len(body)).encode('latin-1'))
        else:
            result += (b'\r\n' + field_name + b': ' + field_value)


    result += (b'\r\n\r\n' + body)

    return result

def handle_request(client_connection):

    request = client_connection.recv(1024)
    test = parse_http_request(request)
    headers = gen_res(b'200',test[0].headers,test[1])
    data = ""
    if test[0].path == '/':
        f = open("./index.html", "r")
        data += headers.decode('latin-1')
        if test[0].method==b'GET':
            data += f.read()
        data += "\r\n\r\n"
        client_connection.sendall(data.encode())
    else:
        data += headers.decode('latin-1')
        client_connection.send(data.encode())
        with open("."+test[0].path, "rb") as f:
            for chunk in chunks(f):
                client_connection.send(chunk)
        client_connection.send(b"\r\n\r\n")
    print("Request Completed")


def serve_forever():
    listen_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    listen_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    listen_socket.bind(SERVER_ADDRESS)
    listen_socket.listen(REQUEST_QUEUE_SIZE)

    print('Serving HTTP on port {port} ...'.format(port=PORT))

    signal.signal(signal.SIGCHLD, grim_reaper)

    while True:
        try:
            client_connection, client_address = listen_socket.accept()
        except IOError as e:
            code, msg = e.args
            if code == errno.EINTR:
                continue
            else:
                raise

        pid = os.fork()
        if pid == 0:
            listen_socket.close()
            handle_request(client_connection)
            client_connection.close()
            os._exit(0)
        else:
            client_connection.close()

if __name__ == '__main__':
    serve_forever()
