const net = require('net');
const handleConnection = require('./handleConnection.js');
const port = 8080;

const server = net.createServer();

server.listen(port, function() {
    console.log(`Server listening for connection requests on socket localhost:${port}`);
});

server.on('connection', function(socket) {
    handleConnection.handleConnection(socket);

    socket.on('end', function() {
      return;
    });

    socket.on('error', function(err) {
        console.log(`Error: ${err}`);
    });
});
