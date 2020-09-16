import errno
import os
import signal
import socket
import requests as req
import urllib.parse
from collections import namedtuple


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


RequestMeta = namedtuple('RequestMeta', [
    'method',
    'path',
    'query_string',
    'http_version',
    'headers',
    'user_agent',
])


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
    if len(split_response) != 2:
        return None
    request_line_and_headers = split_response[0].split(b'\r\n')
    request_line = request_line_and_headers[0]
    req_line_tokens = request_line.split(b' ')

    if len(req_line_tokens) != 3:
        return None
    method = req_line_tokens[0]

    if method not in RESP_METH.request_methods:
        return None

    path = urllib.parse.unquote(req_line_tokens[1].decode())

    if '?' in path:
        target_query_part = path.split('?', 1)[1]
        if len(target_query_part) > 0:
            query_string = target_query_part
        else:
            query_string = None
    else:
        query_string = None
    headers = {}

    for header_field in request_line_and_headers[1:]:
        header_field_split = header_field.split(b':', 1)
        if len(header_field_split[0]) != len(
            header_field_split[0].strip()
        ):
            return None
        field_name = header_field_split[0]
        field_value = header_field_split[1].strip()
        headers[field_name] = field_value

    body = split_response[1]
    user_agent = headers['User-Agent'] if 'User-Agent' in headers else None

    result = RequestMeta(
        method=method,
        path=path,
        query_string=query_string,
        http_version=req_line_tokens[2],
        headers=headers,
        user_agent=user_agent,
    )

    return result


def gen_res(status_code, headers={}, body=b''):
    assert type(status_code) is bytes
    assert type(headers) is dict
    assert type(body) is bytes
    assert status_code in RESP_METH.response_phrases

    result = (b'HTTP/1.0 ' + status_code + b' ' +
              RESP_METH.response_phrases[status_code])

    for field_name, field_value in headers.items():
        result += (b'\r\n' + field_name + b': ' + field_value)

    result += (b'\r\n\r\n' + body)

    return result

def handle_request(client_connection):

    request = client_connection.recv(1024)
    test = parse_http_request(request)
    headers = gen_res(b'200',test.headers)
    data = "HTTP/1.0 200 OK\r\n"
    if test.path == '/':
        f = open("./index.html", "r")
        data += headers.decode('latin-1')
        data += f.read()+"\r\n\r\n"
        client_connection.sendall(data.encode())
    else:
        print(test.headers[b'Accept'])
        with open("."+test.path, "rb") as f:
            image_data = f.read()
        data += headers.decode('latin-1')
        client_connection.send(data.encode())
        client_connection.send(image_data)
        print("Reqest \n")
        client_connection.send(b"\r\n\r\n")


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
