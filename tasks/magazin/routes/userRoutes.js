const express = require('express');
const router = express.Router();
const pool = require("../db");
const getToken = require("../util");
const nodemailer = require("nodemailer");
require("dotenv").config();
var CryptoJS = require("crypto-js");
const QueryStream = require('pg-query-stream')
const JSONStream = require('JSONStream')
require("es6-promise").polyfill()
require("isomorphic-fetch")

const RECAPTCHA_SERVER_KEY = process.env.RECAPTCHA_SERVER_KEY



var minutes = 120, the_interval = minutes * 60 * 1000;
setInterval(async function() {
  console.log("DELETING ALL UNVERIFIED USERS");
  await pool.query("DELETE FROM users WHERE verified = false");
}, the_interval);

async function unlockAccount(email) {
  console.log(12)
  await pool.query("UPDATE users set locked=false where email=$1",[email]);
}

var smtpTransport = nodemailer.createTransport({
    service: "gmail",
    auth: {
        user: process.env.EMAIL_SENDER_EMAIL,
        pass: process.env.EMAIL_SENDER_PASSWORD
    }
});
var rand,mailOptions,host,link;

router.post("/sign",async (req,res) => {
    try {
        const {captchvalue,email,password} = req.body;
        const lockSettings = await pool.query("select * from lock_settings where id = 1");

        const isHuman = await fetch(`https://www.google.com/recaptcha/api/siteverify`, {
            method: "post",
            headers: {
              Accept: "application/json",
              "Content-Type": "application/x-www-form-urlencoded; charset=utf-8"
              },
              body: `secret=${RECAPTCHA_SERVER_KEY}&response=${captchvalue}`
              })
                .then(res => res.json())
                .then(json => json.success)
                .catch(err => {
                  throw new Error(`Error in Google Siteverify API. ${err.message}`)
                })


        const signUser = await pool.query("SELECT * FROM users WHERE email=$1 AND password=crypt($2, password);",[email,password]);
        if(signUser.rowCount>0&&captchvalue != null && isHuman){
            if(signUser.rows[0].verified=='true'){
                await pool.query("DELETE FROM failed_logins where email=$1",[email])
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
          const checkFailedLogins = await pool.query("SELECT COUNT(1) AS failed FROM failed_logins join users on failed_logins.email = users.email WHERE users.email = $1 and users.verified='true'",[email])
          const checkLocked = await pool.query("SELECT locked FROM users WHERE email=$1",[email]);
          if(checkFailedLogins.rows[0].failed>=lockSettings.rows[0].firstlock&&checkLocked.rowCount>0){
            if(!checkLocked.rows[0].locked){
              console.log("unlockAccount1")
              await pool.query("UPDATE users set locked=true where email=$1",[email])
              res.status(500).send({msg: `Акаунта ви беше заключен моля изчакайте ${lockSettings.rows[0].timeaftersecondlock} минути преди да опитате отново.`});
              await pool.query(`insert into failed_logins (email,attempted) VALUES($1,CURRENT_TIMESTAMP)`,[email]);
              setTimeout(unlockAccount,lockSettings.rows[0].timeaftersecondlock*60000,email)
            }else{
              res.status(500).send({msg: 'Акаунта ви е заключен моля изчакайте.'});

            }


          }
          else if(checkFailedLogins.rows[0].failed==lockSettings.rows[0].firstlock&&checkLocked.rowCount>0){
            if(!checkLocked.rows[0].locked){
              await pool.query("UPDATE users set locked=true where email=$1",[email])
              res.status(500).send({msg: `Акаунта ви беше заключен моля изчакайте  ${lockSettings.rows[0].timeafterfirstlock} минути преди да опитате отново.`});
              console.log(email)
              await pool.query(`insert into failed_logins (email,attempted) VALUES($1,CURRENT_TIMESTAMP)`,[email]);
              setTimeout(unlockAccount,lockSettings.rows[0].timeafterfirstlock*60000,email)
            }else{
              res.status(500).send({msg: 'Акаунта ви е заключен моля изчакайте.'});

            }


          }else if(checkLocked.rowCount==0){
            res.status(401).send({msg: 'Несъществуващ имейл.'});
          }
          else if(checkFailedLogins.rows[0].failed>lockSettings.rows[0].firstlock&&checkFailedLogins.rows[0].failed<lockSettings.rows[0].secondlock&&checkLocked.rowCount>0 ){
            if(!checkLocked.rows[0].locked){
                        await pool.query(`insert into failed_logins (email,attempted) VALUES($1,CURRENT_TIMESTAMP)`,[email]);
                        res.status(401).send({msg: 'Грешен имейл или парола.'});
                      }else{
                          res.status(500).send({msg: 'Акаунта ви е заключен моля изчакайте.'});
                      }
          }
          else{

            await pool.query(`insert into failed_logins (email,attempted) VALUES($1,CURRENT_TIMESTAMP)`,[email]);
            res.status(401).send({msg: 'Грешен имейл или парола.'});
          }

        }

    } catch (err) {
        console.log(err)
        res.status(500).send({msg: 'Възникна проблем, моля опитайте по-късно.'});
    }
})

router.put("/update",async (req,res) => {
    try {
        const {name,username,email,password,id} = req.body;
        console.log("dada",id)
        await pool.query(" UPDATE users SET name=$1,username=$2,email=$3,password=crypt($4, gen_salt('bf', 8)) WHERE id=$5",[name,username,email,password,id]);
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
        console.log(err)
        res.status(500).send({msg: 'Възникна проблем, моля опитайте по-късно.'});
    }
})

router.post("/create",async (req,res) => {
    try {
        const {name,username,email,password} = req.body;
        let usernames = 0
        let emails = 0
        var currentdate = new Date();
        var create_date =  currentdate.getDate() + "/"
                + (currentdate.getMonth()+1)  + "/"
                + currentdate.getFullYear() + " @ "
                + currentdate.getHours() + ":"
                + currentdate.getMinutes() + ":"
                + currentdate.getSeconds();
        const checkUsers = await pool.query(" SELECT * FROM users WHERE email = $2 or username =$1 ",[username,email]);
        checkUsers.rows.map(user => {
            user.username == username ? usernames++ : usernames = usernames;
            user.verified == 'true' ? (user.email == email ? emails++ : emails=emails) : emails=emails;
        });
        if(usernames>0&&emails>0)
        {
            res.status(401).send({msg: 'Потребителското име и имейла са заети.'});
        }
        else if(usernames>0){
            res.status(401).send({msg: 'Потребителското име e заетo.'});
        }
        else if(emails>0){
            res.status(401).send({msg: 'Имейла е зает.'});
        }
        else
        {
        const newUser = await pool.query(" INSERT INTO users (name,username,email,password,create_date) VALUES ($1,$2,$3,crypt($4, gen_salt('bf', 8)),$5)",[name,username,email,password,create_date]);
        if(newUser.rowCount>0){
        rand=Math.floor((Math.random() * 100) + 54);
        rand = rand.toString(2);
        var ciphertext = CryptoJS.AES.encrypt(rand, process.env.CRYPTO_SECRET).toString();
        await pool.query("INSERT INTO email_codes (username,email,ver_code) VALUES($1,$2,$3)",[username,email,ciphertext]);
        host=req.get('host');
        link="http://"+req.get('host')+"/users/verify?id="+ciphertext;
        mailOptions={
            username: username,
            to : email,
            subject : "Моля потвърдете вашият имейл адрес",
            html : "Здравейте,<br> Моля Кликнете на линка за да потвърдите вашият имейл.<br><a href="+link+">Кликнете тук за да потвърдите имейла</a>"
        }
        smtpTransport.sendMail(mailOptions, function(error, response){
        if(error){
            res.status(500).send({msg: 'Възникна грешка с изпращането на имейл за потвърждение.'});
            pool.query(" DELETE FROM users where email=$1",[email])

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
  console.log(mailOptions)
    } catch (err) {
        console.log(err)

        res.status(500).send({msg: 'Възникна проблем, моля опитайте по-късно.'});
    }
});

router.get('/verify',async function(req,res){
    console.log(mailOptions)
    const code = await pool.query("SELECT ver_code from email_codes where username=$1",[mailOptions.username]);
    if(req.query.id.slice(0,9)==code.rows[0].ver_code.slice(0,9))
    {
        await pool.query("DELETE FROM email_codes where email=$1",[mailOptions.to])
        await pool.query("UPDATE users SET verified =TRUE where username=$1",[mailOptions.username])
        await pool.query("DELETE FROM users where email=$1 and verified='false'",[mailOptions.to])
        res.end("<h1>Вашият email "+mailOptions.to+" беше успешно потвърден");
    }
    else
    {
        res.end("<h1>Bad Request</h1>");
    }


});

router.post("/get",async(req,res) => {
    try {
        console.log(req.body)
        const Filters = req.body;
        var testfilters = Filters;
        var auth = await pool.query("select employees.name,employees.username,employees.email,roles.name as role,array_agg(permissions.name) from employees join roles on employees.role_id = roles.id join roles_perms on roles_perms.role_id = roles.id join permissions on permissions.id = roles_perms.perm_id where employees.name = $1 GROUP BY employees.name,employees.username,employees.email,roles.name",[testfilters.employeeInfo.name])
        console.log(auth.rows)
        if(auth.rows[0].array_agg.includes("Потребители")){
        const indexOfLastPost = Filters.currentPage * 9;
        const indexOfFirstPost = indexOfLastPost - 9;
        var testArray= [];
        var query = 'select * from (SELECT t.*,name, count(*) OVER (ORDER BY t.id) as rownum FROM users as t WHERE 1=1';
        const entries = Object.entries(testfilters);
        var i =0;
        for (const [key, value] of entries) {
          if(key!='filter'&&key!='employeeInfo'&&value!=''&&key!=''&&key!='currentPage'){
            if(key=='verifiedFilter'){
              ++i;
              testArray.push(testfilters.verifiedFilter);
              query += ` AND verified=$${i}`
            }
            else if(key=='usernameFilter'){
              ++i;
              testArray.push(testfilters.usernameFilter);
              query += ` AND LOWER(username) LIKE concat('%',LOWER($${i}),'%')`;
            }
            else if(key=='emailFilter'){
              ++i;
              testArray.push(testfilters.emailFilter);
              query += ` AND LOWER(email) LIKE concat('%',LOWER($${i}),'%')`;
            }
            else if(key=='from'){
              ++i;
              query = query + ` AND DATE(create_date)>=$${i}`
              testArray.push(testfilters.from);

            }
            else if(key=='to'){
              ++i;
              testArray.push(testfilters.to);
              query = query + ` AND DATE(create_date)<=$${i}`
            }
            else{
            ++i;
            query = query + ` AND ${key}=$${i}`;
            testArray.push(value)
          }
          }
        }
          testArray.push(indexOfFirstPost);
          testArray.push(indexOfLastPost);
          query+=`)d where rownum >=$${i+1} and rownum<=$${i+2}`
          console.log("Orders query:",query)

          pool.connect((err, client, done) => {
         if (err) throw err;
         const data = new QueryStream(query,testArray)
         const stream = client.query(data)
         stream.on('end', done)
         stream.pipe(JSONStream.stringify()).pipe(res)
       })
     }else{
         res.status(500).send({msg: 'Нямате права да виждате списъка с потребителите.'});
     }
        }
       catch (err) {
        console.log(err)
        res.status(500).send({msg: 'There was a problem with the server.'});
    }
})

router.get("/info",async(req,res) => {
    try {
        const id = req.query.id;
        const user = await pool.query(`select users.name,users.username,users.email from users join orders on orders.user_id = users.id where orders.id=$1`,[id]);
        console.log(user.rows[0])
        res.json(user.rows[0]);
    } catch (err) {
        console.log(err)
        res.status(500).send({msg: 'There was a problem with the server.'});
    }
})

router.post("/changeSettings",async(req,res) => {
    try {
        const settings = req.body;
        const lockSettings = await pool.query(`update lock_settings set firstlock = $1 , secondlock=$2, timeafterfirstlock=$3,timeaftersecondlock=$4 where id =1`,[settings.chance1,settings.chance2,settings.time1,settings.time2]);
        console.log(lockSettings.rows[0])
        res.json(lockSettings.rows[0]);
    } catch (err) {
        console.log(err)
        res.status(500).send({msg: 'There was a problem with the server.'});
    }
})



router.get("/count", async (req, res) => {
    try {
      pool.connect((err, client, done) => {
     if (err) throw err;
     const query = new QueryStream('SELECT COUNT(*) FROM users')
     const stream = client.query(query)
     stream.on('end', done)
     stream.pipe(JSONStream.stringify()).pipe(res)
   })
    } catch (err) {
      console.error(err.message);
    }
  });

module.exports = router;
