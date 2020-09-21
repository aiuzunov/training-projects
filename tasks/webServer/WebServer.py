import errno
import os
import signal
import sys
import socket
import subprocess
import requests as req
import urllib.parse
from collections import namedtuple
import json
import select
from pathlib import Path



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
    'headers2'
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
        os.environ['REQUEST_METHOD'] = 'HTTP/1.0'
        os.environ['QUERY_STRING'] = kwargs.get('arguments', '')
        print(kwargs['arguments'])
        os.environ['SCRIPT_NAME'] = kwargs.get('path', '')
        os.environ['CONTENT_TYPE'] = 'text/plain'
        os.environ['CONTENT_LENGTH'] = '70'
        os.environ['REMOTE_ADDR'] = kwargs.get('client_address', '')
    except Exception as e:
        print(1)
        print(e)


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
    headers2 = str(headers)
    #mydict = {k: unicode(v).encode("utf-8") for k,v in mydict.iteritems()}
    #headers2[key.encode('utf-8')] = headers[key].encode('utf-8')
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
        headers2=headers2,
    )

    return [result,body]


def gen_res(status_code, headers={}, body=b''):
    # if body!=b'':
    #     y = json.loads(body)
    #     body_result = '{"result":"' + str(float(y["first"]) + float(y["second"])) + '"}'
    #     body=body_result.encode('utf-8')

    result = (b'HTTP/1.0 ' + status_code + b' ' +
              RESP_METH.response_phrases[status_code])
    for field_name, field_value in headers.items():
        #if field_name == b'Content-Length':
        #    result += (b'\r\n' + field_name + b': ' + str(len(body)).encode('utf-8'))
        #else:
        result += (b'\r\n' + field_name + b': ' + field_value)

    result += (b'\r\n\r\n' + body)
    return result

def recvall(sock):
    BUFF_SIZE = 4096 # 4 KiB
    data = b''
    while True:
        part = sock.recv(BUFF_SIZE)
        data += part
        if len(part) < BUFF_SIZE:
            # either 0 or end of data
            break
    return data

def handle_request(client_connection,client_address):
    request = recvall(client_connection)


    # while not data:
    #     try:
    #         data =  client_connection.recv(200)
    #         if not data:
    #             break
    #         request += data
    #     except:
    #         break

    parsed_request = parse_http_request(request)
    res = gen_res(b'200',parsed_request[0].headers,parsed_request[1])
    data = ""
    try:
        path =  Path("./{path}".format(path=parsed_request[0].path))
    except e:
        print(e)
    if path.exists():
        if path.is_dir():
            f = open("./index.html", "r")
            data += res.decode('utf-8')
            if parsed_request[0].method==b'GET':
                data += f.read()
            client_connection.sendall(data.encode())
        if path.is_file():
            if str(path).startswith("cgi-bin"):
                executable = sys.executable
                if executable:
                    try:
                        set_environment(headers = parsed_request[0].headers,
                        arguments = parsed_request[0].query_string,
                        path=str(path),
                        protocol=parsed_request[0].http_version.decode('utf-8'),
                        client_address=client_address[0],
                        server_port='5000'
                        )
                    except Exception as e:
                        print(e)
                        print(1)
                        # print(parsed_request[0].headers2)
                        # print(parsed_request[0])
                        # print(str(path))
                        # print(client_address[0])
                    script_args = [executable,str(path)]
                    proc = subprocess.Popen(script_args, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                    try:
                        print(1)
                        request_headers = b''
                        if parsed_request[0].method == b'POST':
                            if parsed_request[1] != b'':
                                proc.strdin.write(parsed_request[1])
                            else:
                                print(1)
                            bytes_read = len(parsed_request[1])
                            prev_content_length = len(parsed_request[1])
                            if(int(parsed_request[0].headers[b'Content-Length'].decode('utf-8')) > bytes_read):
                                while True:
                                    ready = select.select([client_connection], [], [], 3)
                                    if ready[0]:
                                        post_data = recvall(client_connection)
                                        if not post_data:
                                            break
                                        bytes_read+=len(post_data)
                                        try:
                                            proc.stdin.write(post_data)
                                        except BrokenPipeError as e:
                                            raise OSError
                                        if(int(parsed_request[0].headers[b'Content-Length'].decode('utf-8')) <= bytes_read):
                                            break
                                    else:
                                        break
                                if prev_content_length == bytes_read:
                                    raise TimeoutError
                            proc.stdin.close()
                            line = None
                            print(1)
                            data = b''
                            data += b'HTTP/1.1 200 OK Date: Mon, 21 Sep 2020 16:57:59 GMT Content-Type: text/html Transfer-Encoding: chunked Connection: keep-alive'
                            client_connection.send(data)
                            for line in proc.stdout:
                                client_connection.send(line)
                            if line == None:
                                return
                        elif parsed_request[0].method == b'GET':
                            line = None
                            i=0
                            data = b''
                            data += b'HTTP/1.1 200 OK Date: Mon, 21 Sep 2020 16:57:59 GMT Content-Type: text/html Transfer-Encoding: chunked Connection: keep-alive'
                            client_connection.send(data)
                            for line in proc.stdout:
                                i+=1
                                try:
                                    client_connection.send(line)
                                except Exception as e:
                                    print(e)

                                print(i)
                            print(data)
                            if line == None:
                                return
                        else:
                            return
                    except:
                        pass
            else:
                data += res.decode('utf-8')
                client_connection.send(data.encode())
                with open("."+parsed_request[0].path, "rb") as f:
                    for chunk in chunks(f):
                        client_connection.send(chunk)
    else:
        doesnt_exist = b"HTTP/1.0 404 Not Found\r\n"+b"\r\n\r\nError 404 \r\nResource not found"
        client_connection.sendall(doesnt_exist)


def serve_forever():
    try:
        listen_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        listen_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        listen_socket.bind(SERVER_ADDRESS)
        listen_socket.listen(REQUEST_QUEUE_SIZE)
    except:
        pass
    print('The HTTP server is listening on PORT {port}'.format(port=PORT))
    try:
        signal.signal(signal.SIGCHLD, grim_reaper)
    except:
        pass
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
            pid = os.fork()
            if pid == 0:
                listen_socket.close()
                handle_request(client_connection,client_address)
                client_connection.close()
                os._exit(0)
            else:
                client_connection.close()
        except:
            pass

if __name__ == '__main__':
    serve_forever()
