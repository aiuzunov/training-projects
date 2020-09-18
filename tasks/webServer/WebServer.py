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
    start_line_and_headers = split_response[0].split(b'\r\n')
    request_line = start_line_and_headers[0]
    start_line_parts = request_line.split(b' ')
    method = start_line_parts[0]
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
    parsed_request = parse_http_request(request)
    res = gen_res(b'200',parsed_request[0].headers,parsed_request[1])
    data = ""
    if parsed_request[0].path == '/':
        f = open("./index.html", "r")
        data += res.decode('latin-1')
        if parsed_request[0].method==b'GET':
            data += f.read()
        client_connection.sendall(data.encode())
    else:
        data += res.decode('latin-1')
        client_connection.send(data.encode())
        with open("."+parsed_request[0].path, "rb") as f:
            for chunk in chunks(f):
                client_connection.send(chunk)


def serve_forever():
    listen_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    listen_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    listen_socket.bind(SERVER_ADDRESS)
    listen_socket.listen(REQUEST_QUEUE_SIZE)

    print('The HTTP server is listening on PORT {port}'.format(port=PORT))

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
            print("%d(child) created by %d(parent) is completing its task" % (os.getpid(), os.getppid()))
            handle_request(client_connection)
            client_connection.close()
            os._exit(0)
        else:
            print("%d (parent) just created %d." % (os.getpid(), pid))
            client_connection.close()

if __name__ == '__main__':
    serve_forever()
