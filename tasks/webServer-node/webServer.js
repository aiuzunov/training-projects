const net = require('net');
const log4js = require("log4js");

const handleConnection = require('./handleConnection.js');

log4js.configure({
  appenders: {
    error: { type: 'file', filename: './logs/error.log', maxLogSize: 10485760, backups: 3, compress: true },
    access: { type: 'file', filename: './logs/access.log', maxLogSize: 10485760, backups: 3, compress: true },
    agent: { type: 'file', filename: './logs/agent.log', maxLogSize: 10485760, backups: 3, compress: true }
  },
  categories: {
    default: { appenders: [ 'error' ], level: 'error'},
    access: { appenders: [ 'access' ], level: 'info'},
    agent: { appenders: [ 'agent' ], level: 'trace'}
  }
});

const errorLogger = log4js.getLogger('error');
const accessLogger = log4js.getLogger('access');
const agentLogger = log4js.getLogger('agent');



const port = 8080;

const server = net.createServer();

server.listen(port, function() {
    console.log(`Server listening for connection requests on socket localhost:${port}`);
});

server.on('connection', function(socket) {
    accessLogger.info("New connection from "+socket.remoteAddress+":"+socket.remotePort)
    handleConnection.handleConnection(socket,accessLogger,errorLogger,agentLogger);

    socket.on('end', function() {
      return;
    });

    socket.on('error', function(err) {
        console.log(`Error: ${err}`);
    });
});
