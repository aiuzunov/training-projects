const express = require('express');
const router = express.Router();
const pool = require("../db");
const getToken = require("../util");
const nodemailer = require("nodemailer");
require("dotenv").config();
var CryptoJS = require("crypto-js");



var minutes = 120, the_interval = minutes * 60 * 1000;
setInterval(async function() {
  console.log("DELETING ALL UNVERIFIED USERS");
  await pool.query("DELETE FROM users WHERE verified = false");
}, the_interval);


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
        await pool.query("INSERT INTO email_codes (email,ver_code) VALUES($1,$2)",[email,ciphertext]);
        host=req.get('host');
        link="http://"+req.get('host')+"/api/users/verify?id="+ciphertext;
        mailOptions={
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
    } catch (err) {
        console.log(err)

        res.status(500).send({msg: 'Възникна проблем, моля опитайте по-късно.'});
    }
});

router.get('/verify',async function(req,res){
    console.log("http://"+host);
if((req.protocol+"://"+req.get('host'))==("http://"+host))
{

    const code = await pool.query("SELECT ver_code from email_codes where email=$1",[mailOptions.to]);
    console.log(code.rows[0].ver_code,req.query.id)
    if(req.query.id==code.rows[0].ver_code)
    {
        await pool.query("DELETE FROM email_codes where email=$1",[mailOptions.to])
        await pool.query("UPDATE users SET verified =TRUE where email=$1",[mailOptions.to])
        res.end("<h1>Вашият email "+mailOptions.to+" беше успешно потвърден");
    }
    else
    {
        res.end("<h1>Bad Request</h1>");
    }
}
else
{
    res.end("<h1>Заявката е от неизвестен източник");
}

});

router.post("/get",async(req,res) => {
    try {
        console.log(req.body)
        const {currentPage} = req.body;
        const filters = req.body;
        const indexOfLastPost = currentPage * 9;
        const indexOfFirstPost = indexOfLastPost - 9;
        console.log('ww',filters)
        if(!filters.userFilters.filter){
          const users = await pool.query(`select * from (SELECT t.*,name, count(*) OVER (ORDER BY t.id) as rownum FROM users as t)d where rownum >= $1 and rownum<=$2 `,[indexOfFirstPost,indexOfLastPost]);
          res.json(users.rows);
        }
        else{
          var filteredUsers = await pool.query('select * from (SELECT t.*,name, count(*) OVER (ORDER BY t.id) as rownum FROM users as t)d')
          filteredUsers= (filteredUsers.rows).filter(function(item) {
            for (var key in filters.userFilters) {
              switch(key){
                case 'username':
                  if(filters.userFilters.username){
                    if (item[key] === undefined || !item[key].includes(filters.userFilters[key]))
                      return false;
                    }
                  break;
                case 'fromDate':
                if(filters.userFilters.fromDate){
                    if (item['create_date'] === undefined || (item['create_date'].getFullYear()<new Date(filters.userFilters[key]).getFullYear()||item['create_date'].getMonth()<new Date(filters.userFilters[key]).getMonth()||item['create_date'].getDate()<new Date(filters.userFilters[key]).getDate()))
                      return false
                    }
                  break;
                case 'toDate':
                if(filters.userFilters.toDate){
                    if (item['create_date'] === undefined || (item['create_date'].getFullYear()>new Date(filters.userFilters[key]).getFullYear()||item['create_date'].getMonth()>new Date(filters.userFilters[key]).getMonth()||item['create_date'].getDate()>new Date(filters.userFilters[key]).getDate()))
                      return false
                    }
                  break;
                case 'email':
                  if(filters.userFilters.email){
                    if (item[key] === undefined || !item[key].includes(filters.userFilters[key]))
                      return false;
                    }
                    break;

                case 'filter':
                  break;
                case 'verified':
                  if(filters.userFilters.verified){
                      console.log("Item",(item[key] != filters.userFilters[key]))
                      if (item[key] === undefined || (item[key] != filters.userFilters[key]))
                        return false
                      }
                      break;
                default:
                  if (item[key] === undefined || item[key] != filters.UsersFilters[key])
                    return false;
                  break;
              }
            }
            return true;
          });
          console.log(filteredUsers)
          res.json(filteredUsers);
        }

    } catch (err) {
        console.log(err)
        res.status(500).send({msg: 'There was a problem with the server.'});
    }
})

router.get("/info/:id",async(req,res) => {
    try {
        const {id} = req.params;
        const user = await pool.query(`select users.name,users.username,users.email from users join orders on orders.user_id = users.id where orders.id=$1`,[id]);
        console.log(user.rows[0])
        res.json(user.rows[0]);
    } catch (err) {
        console.log(err)
        res.status(500).send({msg: 'There was a problem with the server.'});
    }
})

router.get("/count", async (req, res) => {
    try {
      const usersCount = await pool.query(
        "SELECT COUNT(*) FROM users");
      res.json(usersCount.rows[0]);
    } catch (err) {
      console.error(err.message);
    }
  });

module.exports = router;