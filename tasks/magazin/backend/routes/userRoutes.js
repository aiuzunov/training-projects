const express = require('express');
const router = express.Router();
const pool = require("../db");
const getToken = require("../util");
const nodemailer = require("nodemailer");



var minutes = 120, the_interval = minutes * 60 * 1000;
setInterval(async function() {
  console.log("DELETING ALL UNVERIFIED USERS");
  await pool.query("DELETE FROM users WHERE verified = false");
}, the_interval);


var smtpTransport = nodemailer.createTransport({
    service: "gmail",
    auth: {
        user: "aleksandar.i.uzunov@gmail.com",
        pass: ""
    }
});
var rand,mailOptions,host,link;

router.post("/sign",async (req,res) => {
    try {
      
        const {email,password} = req.body;
        const signUser = await pool.query("SELECT * FROM users WHERE email=$1 AND password=crypt($2, password);",[email,password]);
        if(signUser.rowCount>0){
            if(signUser.rows[0].verified==true){
                res.json({
                    id: signUser.rows[0].id,
                    name:signUser.rows[0].name,
                    username:signUser.rows[0].username,
                    email: signUser.rows[0].email,
                    token: getToken(signUser),
                });
            }
            else{
                res.status(401).send({msg: 'Моля потвърдете вашият имейл.'})
            }
        }else{
            res.status(401).send({msg: 'Грешен имейл или парола.'});
        }
    } catch (err) {
        console.log(err)
        res.status(500).send({msg: 'There was a problem with the request.'});
    }
})

router.put("/update",async (req,res) => {
    try {
        const {name,username,email,password} = req.body;
        await pool.query(" UPDATE users SET name=$1,username=$2,email=$3 WHERE password=crypt($4, password)",[name,username,email,password]);
        const updatedUser = await pool.query(" SELECT * from users where email=$1",[email]);

        if(updatedUser){
            res.json({
                id: updatedUser.rows[0].id,
                name: updatedUser.rows[0].name,
                username: updatedUser.rows[0].username,
                email: updatedUser.rows[0].email,
                token: getToken(updatedUser),
            });
            console.log(updatedUser.rows[0].name)
        }else{
            res.status(401).send({msg: 'Несъществуващ потребител.'});
        } 
    } catch (err) {
        res.status(500).send({msg: 'There was a problem with the request.'});
    }
})

router.post("/create",async (req,res) => {
    try {
        const {name,username,email,password} = req.body;
        let usernames = 0
        let emails = 0
        const checkUsers = await pool.query(" SELECT * FROM users WHERE email = $2 or username =$1",[username,email]);
        checkUsers.rows.map(user => {
            user.username == username ? usernames++ : usernames = usernames;
            user.email == email ? emails++ : emails=emails;
        });
        if(usernames>0&&emails>0)
        {  
            res.status(401).send({msg: 'Потребителското име и имейла са заети.'});
        }
        else if(usernames>0){
            res.status(401).send({msg: 'Потребителското име са заети.'});
        }
        else if(emails>0){
            res.status(401).send({msg: 'Имейла е зает.'});
        }
        else
        {
        const newUser = await pool.query(" INSERT INTO users (name,username,email,password) VALUES ($1,$2,$3,crypt($4, gen_salt('bf', 8)))",[name,username,email,password]);
        if(newUser.rowCount>0){
        rand=Math.floor((Math.random() * 100) + 54);
        host=req.get('host');
        link="http://"+req.get('host')+"/api/users/verify?id="+rand;
        mailOptions={
            to : email,
            subject : "Please confirm your Email account",
            html : "Hello,<br> Please Click on the link to verify your email.<br><a href="+link+">Click here to verify</a>"
        }
        smtpTransport.sendMail(mailOptions, function(error, response){
        if(error){
            res.status(500).send({msg: 'There was a problem with sending the verification email.'});
        }
        else{
            res.json({
                name: name,
                username: username,
                email: email,
                token: getToken(newUser),
            });
        }
        });
        }
       
        
}   
    } catch (err) {
        console.log(err)

        res.status(500).send({msg: 'There was a problem with the request.'});
    }
});

router.get('/verify',async function(req,res){
    console.log(req.protocol+":/"+req.get('host'));
if((req.protocol+"://"+req.get('host'))==("http://"+host))
{
    console.log("Domain matches. The email is from authentic source");
    if(req.query.id==rand)
    {
        await pool.query("UPDATE users SET verified =TRUE where email=$1",[mailOptions.to])
        console.log("email is verified");
        res.end("<h1>Your email "+mailOptions.to+" was successfully verified");
    }
    else
    {
        console.log("Your email was not verified");
        res.end("<h1>Bad Request</h1>");
    }
}
else
{
    res.end("<h1>The request is from uknown source");
}

});

module.exports = router;
