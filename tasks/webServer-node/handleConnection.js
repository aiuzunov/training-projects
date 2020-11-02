const requestHandler = require("./requestHandler.js");
var path = require('path');

function handleConnection(socket,accessLogger,errorLogger,agentLogger){
  socket.once('readable', function() {
    let reqBuffer = new Buffer('');
    let buf;
    let reqHeader;
    while(true) {
      buf = socket.read();
      if (buf === null) break;

      reqBuffer = Buffer.concat([reqBuffer, buf]);

      let marker = reqBuffer.indexOf('\r\n\r\n')
      if (marker !== -1) {
        let post_data = reqBuffer.slice(marker + 4).toString();
        reqHeader = reqBuffer.slice(0, marker).toString();
        socket.unshift(post_data);
        break;
      }
    }
    if(reqHeader==undefined){
      return;
    }
    const reqHeaders = reqHeader.split('\r\n');

    const reqLine = reqHeaders.shift().split(' ');
    const headers = reqHeaders.reduce((acc, currentHeader) => {
      const [key, value] = currentHeader.split(':');
      if(key=='User-Agent'){
        agentLogger.trace("User with IP: "+socket.remoteAddress+":"+socket.remotePort+" has sent a request using the following agent: "+value)
      }
      return {
        ...acc,
        [key.trim().toLowerCase()]: value.trim()
      };
    }, {});
    const request = {
      method: reqLine[0],
      url: reqLine[1],
      httpVersion: reqLine[2].split('/')[1],
      headers,
      socket
    };

    let status = 200, statusText = 'OK', headersSent = false, isChunked = false;
    const responseHeaders = {
      server: 'alex.uz server'
    };
    function setHeader(key, value) {
      responseHeaders[key.toLowerCase()] = value;
    }
    function sendHeaders() {
      if (!headersSent) {
        headersSent = true;
        setHeader('date', new Date().toGMTString());
        socket.write(`HTTP/1.0 ${status} ${statusText}\r\n`);
        Object.keys(responseHeaders).forEach(headerKey => {
          socket.write(`${headerKey}: ${responseHeaders[headerKey]}\r\n`);
        });
        socket.write('\r\n');
      }
    }
    const response = {
      write(chunk) {
        if (!headersSent) {
          if (!responseHeaders['content-length']) {
            isChunked = true;
            var extname = path.extname(request.url.split("?")[0]);
            var contentType;
            switch (extname) {
                case '.pl':
                    contentType = 'text/html';
                    break;
                case '.html':
                    contentType = 'text/html';
                    break;
                case '.cgi':
                    contentType = 'text/html';
                    break;
                case '.js':
                    contentType = 'text/javascript';
                    break;
                case '.css':
                    contentType = 'text/css';
                    break;
                case '.json':
                    contentType = 'application/json';
                    break;
                case '.png':
                    contentType = 'image/png';
                    break;
                case '.jpg':
                    contentType = 'image/jpg';
                    break;
                case '.wav':
                    contentType = 'audio/wav';
                    break;
            }
            if(contentType){
              setHeader('Content-type', contentType);

            }

            // setHeader('transfer-encoding', 'chunked');
          }
          sendHeaders();
        }
        if (isChunked) {
          // const size = chunk.length.toString(16);
          // socket.write(`${size}\r\n`);
          socket.write(chunk);
          // socket.write('\r\n');
        }
        else {
          socket.write(chunk);
        }
      },
      end(chunk) {
        if (!headersSent) {
          if (!responseHeaders['content-length']) {
            setHeader('content-length', chunk ? chunk.length : 0);
          }
          sendHeaders();
        }
        if (isChunked) {
          if (chunk) {
            // const size = (chunk.length).toString(16);
            // socket.write(`${size}\r\n`);
            socket.write(chunk);
            // socket.write('\r\n');
          }
          socket.end();
        }
        else {
          socket.end(chunk);
        }
      },
      setHeader,
      setStatus(newStatus, newStatusText) { status = newStatus, statusText = newStatusText }
    };
    requestHandler.requestHandler(request, response, accessLogger,errorLogger);
  });
}

module.exports = {handleConnection};
