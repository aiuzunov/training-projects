import errno
import os
import sys
import socket
import time
import asyncio
import subprocess
import uvloop


from aiologger import Logger

logger = Logger.with_default_handlers(name='my-logger')



from aiologger.utils import get_running_loop
from aiologger.filters import StdoutFilter
from aiologger.levels import LogLevel
from aiologger.logger import Logger
from aiologger.records import LogRecord
from aiologger.handlers.files import AsyncFileHandler
from tempfile import NamedTemporaryFile
from signal import signal, SIGINT
from datetime import datetime
from collections import namedtuple
from pathlib import Path

#from Logs import LogInit
#
# try:
#     logger = logging.getLogger('Web Server Logger')
#     logger.setLevel(logging.DEBUG)
#
#     formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
#
#     LogInit(logger,logging.WARNING,'./logs/warning.log',formatter).initialize()
#     LogInit(logger,logging.ERROR,'./logs/error.log',formatter).initialize()
#     LogInit(logger,logging.INFO,'./logs/info.log',formatter).initialize()
#     LogInit(logger,logging.DEBUG,'./logs/debug.log',formatter).initialize()
# except Exception as e:
#     exc_type, exc_obj, exc_tb = sys.exc_info()
#     fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
#     print(e,exc_type, fname, exc_tb.tb_lineno)



SERVER_ADDRESS = (HOST, PORT) = '', 9100
REQUEST_QUEUE_SIZE = 2048

async def get_date():
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
        exc_type, exc_obj, exc_tb = sys.exc_info()
        fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
        #logger.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))


def parse_http_request(request):
    try:
        assert len(request) == 2
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
    for field_name, field_value in headers.items():
        result += (b'\r\n' + field_name + b': ' + field_value)

    result += (b'\r\n\r\n' + body)
    return result

async def recvall(sock):
    try:
        HEADERS_LIMIT = 8192
        part = await sock.read(HEADERS_LIMIT)
        if b'\r\n\r\n' in part:
            headers = part.split(b'\r\n\r\n', 1)[0]
            body =  part.split(b'\r\n\r\n', 1)[1]
            return [headers,body]

        else:
            return 1


    except Exception as e:
        print(e)
        return -1



async def handle_request(client_reader, client_writer):

    # request = await recvall(client_reader)
    # parsed_request = parse_http_request(request)
    request = await recvall(client_reader)
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
                #await logger.warning("Client: {} Error with request".format(client_writer.get_extra_info('peername')[0]))
            return
        except Exception as e:
            #await logger.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))
            client_writer.close()
            return
    res = gen_res(b'200',parsed_request[0].headers,parsed_request[1])
    assert isinstance(res,(bytes, bytearray))
    try:
        path =  Path("./{path}".format(path=parsed_request[0].path))
        ext = Path("./{path}".format(path=parsed_request[0].path)).suffix
    except Exception as e:
        exc_type, exc_obj, exc_tb = sys.exc_info()
        fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
        #await logger.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))
        return
    if path.exists():
        if path.is_dir():
            try:
                send_file(res,"/index.html",client_writer)
            except Exception as e:
                print(e)
                code_response(b'501',client_writer)
                        #if chunk != None:
                            #await logger.debug("Client: {}, User-Agent: {}".format(client_writer.get_extra_info('peername')[0],parsed_request[0].headers[b'User-Agent'].decode('utf-8')))
                        #    await logger.info("Client IP Address: {}, File Extension: {}, Method: {}, Path: {}".format(client_writer.get_extra_info('peername')[0],ext,parsed_request[0].method.decode('utf-8'),parsed_request[0].path))
            except Exception as e:
                exc_type, exc_obj, exc_tb = sys.exc_info()
                fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
                #await logger.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))
        if path.is_file():
            if str(path).startswith("cgi-bin") and ext == '.py':
                executable = sys.executable
                if executable:
                    try:
                        set_environment(headers = parsed_request[0].headers,
                        arguments = parsed_request[0].query_string,
                        path=str(path),
                        protocol=parsed_request[0].http_version.decode('utf-8'),
                        client_address=client_writer.get_extra_info('peername')[0],
                        server_port='9100'
                        )
                    except Exception as e:
                        exc_type, exc_obj, exc_tb = sys.exc_info()
                        fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
                    #    await logger.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))
                    process =  await asyncio.create_subprocess_exec(executable,str(path), stdin=subprocess.PIPE,
                                                              stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                    try:
                        request_headers = b''
                        if parsed_request[0].method == b'POST':
                            if parsed_request[1] != b'':
                                process.stdin.write(parsed_request[1])
                            if int(parsed_request[0].headers[b'Content-Length'].decode('utf-8')) - len(request[1]) > 0:
                                while True:
                                    part = await client_reader.read(8192)
                                    if len(part) < 8192:
                                        break
                                    process.stdin.write(part)
                                    process.stdin.flush()
                            line = None
                            data = 'HTTP/1.0 200 OK\rDate: {}\rConnection: keep-alive\r'.format(await get_date()).encode()
                            client_writer.write(data)
                            try:
                                future = asyncio.ensure_future(process.communicate())
                                done, pending = await asyncio.wait([future], timeout=5)
                                if pending:
                                    if process.returncode is None:
                                        try:
                                            process.kill()
                                            code_response(b'408',client_connection)
                                            return
                                        except ProcessLookupError:
                                            pass
                                output, err = await future
                                client_writer.write(output)
                                client_writer.close()
                                # while True:
                                # #chunk = await process.stdout.read(4096)
                                #     chunk = await asyncio.wait_for(process.stdout.read(4096),timeout = 0.1)
                                #     if not chunk:
                                #         break
                                #     client_writer.write(chunk)
                                # client_writer.close()
                            except asyncio.TimeoutError as e:
                                code_response(b'408',client_connection)
                                return
                            #if line!=None:
                                #await logger.debug("Client: {}, User-Agent: {}".format(client_writer.get_extra_info('peername')[0],parsed_request[0].headers[b'User-Agent'].decode('utf-8')))
                            #    await logger.info("Client IP Address: {}, File Extension: {}, Method: {}, Path: {}, Body: {}".format(client_writer.get_extra_info('peername')[0],ext,parsed_request[0].method.decode('utf-8'),parsed_request[0].path,parsed_request[1]))

                        elif parsed_request[0].method == b'GET':
                            line = None
                            data = 'HTTP/1.0 200 OK\rDate: {}\rConnection: keep-alive\r'.format(await get_date()).encode()
                            client_writer.write(data)
                            try:
                                future = asyncio.ensure_future(process.communicate())
                                done, pending = await asyncio.wait([future], timeout=2)
                                if pending:
                                    if process.returncode is None:
                                        try:
                                            process.kill()
                                        except ProcessLookupError:
                                            pass
                                output, err = await future
                                client_writer.write(output)
                                client_writer.close()
                            except asyncio.TimeoutError as e:
                                code_response(b'408',client_connection)
                                return
                            #if line !=None:
                            #    await logger.info("Client IP Address: {}, File Extension: {}, Method: {}, Path: {}, Query: {}".format(client_writer.get_extra_info('peername')[0],ext,parsed_request[0].method.decode('utf-8'),parsed_request[0].path,parsed_request[0].query_string))
                            #    await logger.debug("Client: {}, User-Agent: {}".format(client_writer.get_extra_info('peername')[0],parsed_request[0].headers[b'User-Agent'].decode('utf-8')))
                    except Exception as e:
                        exc_type, exc_obj, exc_tb = sys.exc_info()
                        fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
                        #await logger.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))
            else:
                try:
                    send_file(res,parsed_request[0].path,client_writer)
                except Exception as e:
                    exc_type, exc_obj, exc_tb = sys.exc_info()
                    fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
                    #await logger.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))
    else:
        try:
            code_response(b'404',client_connection)
        except Exception as e:
            exc_type, exc_obj, exc_tb = sys.exc_info()
            fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
            #await logger.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))

def code_response(status_code,client_writer):
    response = "HTTP/1.0 {0} {1}\r\n".format(status_code.decode('utf-8'),RESP_METH.response_phrases[status_code].decode())+"\r\n\r\nError {0} \r\n{1}".format(status_code.decode('utf-8'),RESP_METH.response_phrases[status_code].decode())
    client_writer.write(response.encode())
    client_writer.close()

def send_file(res,path,client_writer):
    client_writer.write(res)
    with open("."+path, "rb") as f:
        for chunk in chunks(f):
            client_writer.write(chunk)
    client_writer.close()



def serve_forever():
    try:
        asyncio.set_event_loop(uvloop.new_event_loop())
        socket_server = asyncio.start_server(handle_request, host=os.environ.get('SERVER_NAME', 'localhost'),
                                            port=9100, backlog=REQUEST_QUEUE_SIZE,
                                            family=socket.AF_INET, reuse_address=True
                                            )
        print('The HTTP server is listening on PORT {port}'.format(port=PORT))
        loop = asyncio.get_event_loop()
        task = asyncio.ensure_future(socket_server)
        signal(SIGINT, lambda s, f: loop.stop())
        try:
            loop.run_forever()
        except:
            loop.stop()
        #loop.add_signal_handler(signal.SIGCHLD, grim_reaper)
    except Exception as e:
        print(e)
        exc_type, exc_obj, exc_tb = sys.exc_info()
        fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
        #await logger.error("{} {} {} ".format(e, fname, exc_tb.tb_lineno))


if __name__ == '__main__':
    serve_forever()
