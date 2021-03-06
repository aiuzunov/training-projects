var fs = require('fs');
const { spawn } = require('child_process');
const ROOT_DIR = "/home/aiuzunov/github/training-projects/tasks/webServer-node";


function requestHandler(req, res, accessLogger, errorLogger){

  try{
  if(req.url.endsWith("/")){
    accessLogger.info("The client with IP:"+req.socket.remoteAddress+":"+req.socket.remotePort+" requested the following file"+ROOT_DIR+req.url+"/index.html")
      fileHandler(res,"."+req.url+"index.html",errorLogger,req);
    }
  else{
    accessLogger.info("The client with IP:"+req.socket.remoteAddress+req.socket.remotePort+"requested the following file"+ROOT_DIR+req.url)
    if(req.url.includes("cgi")){

      if(req.method=='POST'){
        let post_data = req.socket.read();
        const child = spawn('perl', [ROOT_DIR+req.url+" "+"'"+post_data+"'"], {shell: true});
        child.stdout.on('data', (data) => {
          res.write(`${data}`);
          res.end()
        });

        child.stderr.on('data', (data) => {
          console.error(`stderr: ${data}`);
        });

        child.on('close', (code) => {
        });
      }else{
        var query_string = req.url.split("?")[1], path = req.url.split("?")[0];
        const child = spawn('perl', [ROOT_DIR+path+" "+query_string.replace(/[&]/g, " ")], {shell: true});
        child.stdout.on('data', (data) => {
          res.write(`${data}`);
          res.end()
        });

        child.stderr.on('data', (data) => {
          console.error(`stderr: ${data}`);
        });

        child.on('close', (code) => {
        });
      }


    }
    else{
    fileHandler(res,"."+req.url,errorLogger,req);
  }
  }

}catch (error) {
  if(error.code=='ENOENT'){
    errorLogger.error("The file "+ROOT_DIR+req.url+" requested by: "+req.socket.remoteAddress+req.socket.remotePort+" was not found!")
    res.write("Error 404 Resource Not Found");
    res.end()
  }
}
}

function fileHandler(res,path,errorLogger,req){
  var readerStream = fs.createReadStream(path)

  readerStream.on('data', function(chunk) {
    res.write(chunk);
  });

  readerStream.on('end',function() {
     res.end();
  });

  readerStream.on('error', function(err) {
    if(err.code == 'ENOENT'){
      errorLogger.error("The file "+ROOT_DIR+req.url+" requested by: "+req.socket.remoteAddress+req.socket.remotePort+" was not found!")
      res.write("Error 404 Resource Not Found");
      res.end();
      }
    else {
      errorLogger.error("A request for the following file: "+ROOT_DIR+req.url+" requested by: "+req.socket.remoteAddress+req.socket.remotePort+" has caused the following internal server error :"+err.message)
      res.write("Error 501 Internal Server Error");
      res.end();
    }
  });


}






module.exports = {requestHandler};
