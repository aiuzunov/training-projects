var readline = require('readline');

var hour = 0;
var minutes = 0;
var rl = readline.createInterface({
   input: process.stdin,
   output: process.stdout
});


function processNums(n1, n2) {
   var hour = Number(n1);
   var minutes = Number(n2);
   var small=6*minutes
   if(small>180)
       small=small - 360
   var big=0.5*(60*hour+minutes)
   if(big>180)
       big = big -360
   var answer=small-big
   if(small<0){
     small=360+small;
   }else if(small==0){
     small=360;
   }
   if(small==0&&big==360 || small==360 && big==0)
    answer=0;
   var answer=small-big
   if(answer>180){
     answer=360-answer;
   }
   if(answer<0){
     answer = answer*-1;
   }
   console.log(answer.toFixed(3))
}

function start() {
   rl.question('hour: ', function (x) {
       rl.question('minutes: ', function (y) {
           rl.close();
           processNums(x, y);
       });

   });

}

start();
