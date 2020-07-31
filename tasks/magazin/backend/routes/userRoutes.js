const express = require('express');
const router = express.Router();
const pool = require("../db");
const getToken = require("../util");
const nodemailer = require("nodemailer");

var smtpTransport = nodemailer.createTransport({
    service: "gmail",
    auth: {
        user: "aleksandar.i.uzunov@gmail.com",
        pass: "aleksandar106810"
    }
});
var rand,mailOptions,host,link;

router.post("/sign",async (req,res) => {
    try {
      
        const {email,password} = req.body;
        const signUser = await pool.query("SELECT * FROM users WHERE email=$1 AND password=$2",[email,password]);
        console.log(signUser.rows[0].verified)
        if(signUser.rowCount>0 && signUser.rows[0].verified==true){
            res.json({
                id: signUser.rows[0].id,
                name:signUser.rows[0].name,
                username:signUser.rows[0].username,
                email: signUser.rows[0].email,
                token: getToken(signUser),
            });
        }else{
            res.status(401).send({msg: 'Invalid Email or Password.'});
        }
    } catch (err) {
        console.error(err.message);
    }
})

router.put("/update",async (req,res) => {
    try {
        const {name,username,email,password} = req.body;
        console.log(name)

        await pool.query(" UPDATE users SET name=$1,username=$2,email=$3,password=$4 WHERE password=$4",[name,username,email,password]);
        const updatedUser = await pool.query(" SELECT * from users where email=$1",[email]);

        if(updatedUser){
            res.json({
                id: updatedUser.rows[0].id,
                name: updatedUser.rows[0].name,
                username: updatedUser.rows[0].username,
                email: updatedUser.rows[0].email,
                token: getToken(updatedUser),
            });
        console.log(updatedUser.rows[0])
        console.log(updatedUser.rowCount)
        }else{
            res.status(401).send({msg: 'Invalid User Data.'});
        } 
    } catch (err) {
        console.error(err.message);
    }
})

router.post("/create",async (req,res) => {
    try {
        const {name,username,email,password} = req.body;
        const newUser = await pool.query(" INSERT INTO users (name,username,email,password) VALUES ($1,$2,$3,$4)",[name,username,email,password]);
        console.log(newUser);
        if(newUser){
            res.json({
                name: name,
                username: username,
                email: email,
                token: getToken(newUser),
            });
        }else{
            res.status(401).send({msg: 'Invalid User Data.'});
        }
        rand=Math.floor((Math.random() * 100) + 54);
        host=req.get('host');
        link="http://"+req.get('host')+"/verify?id="+rand;
        mailOptions={
            to : email,
            subject : "Please confirm your Email account",
            html : "Hello,<br> Please Click on the link to verify your email.<br><a href="+link+">Click here to verify</a>"
        }
        console.log(mailOptions);
        smtpTransport.sendMail(mailOptions, function(error, response){
        if(error){
            console.log(error);
            res.end("error");
        }else{
            console.log("Message sent: " + response.message);
            res.end("sent");
         }
});
        
    } catch (err) {
        console.error(err.message);
    }
})

router.get('/verify',async function(req,res){
    console.log(req.protocol+":/"+req.get('host'));
if((req.protocol+"://"+req.get('host'))==("http://"+host))
{
    console.log("Domain is matched. Information is from Authentic email");
    if(req.query.id==rand)
    {
        await pool.query("UPDATE users SET verified =TRUE where email=$1",[mailOptions.to])
        console.log("email is verified");
        res.end("<h1>Email "+mailOptions.to+" has been Successfully verified");
    }
    else
    {
        console.log("email is not verified");
        res.end("<h1>Bad Request</h1>");
    }
}
else
{
    res.end("<h1>Request is from unknown source");
}

});

module.exports = router;
