var fs = require('fs');
const { spawn } = require('child_process');
const ROOT_DIR = "/home/aiuzunov/github/training-projects/tasks/webServer-node";


function requestHandler(req, res){
  try{
  if(fs.lstatSync(ROOT_DIR+req.url).isDirectory()){
    if(fs.existsSync(ROOT_DIR+req.url+"index.html")) {
      fileHandler(res,"."+req.url+"index.html");
    }else{
      res.write("Error 404 File Not Found");
      res.end()
    }
    }
  else{
    if(req.url.includes("cgi")){
      const child = spawn('perl', ['hello.pl'], {shell: true});
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
    else{
    fileHandler(res,"."+req.url);
  }
  }

}catch (error) {
  if(error.code=='ENOENT'){
    res.write("Error 404 FILE NOT FOUND");
    res.end()
  }
}
}

function fileHandler(res,path){
  try{

  var readerStream = fs.createReadStream(path)

  readerStream.on('data', function(chunk) {
    res.write(chunk);
  });

  readerStream.on('end',function() {
     res.end();
  });

  readerStream.on('error', function(err) {
     console.log(err.stack);
  });
}catch (error){
  if(error.code == 'ENOENT'){
    res.write("Error 404 Resource Not Found");
    res.end();
    }
  else {
    res.write("Error 501 Internal Server Error");
    res.end();
  }
}

}






module.exports = {requestHandler};
