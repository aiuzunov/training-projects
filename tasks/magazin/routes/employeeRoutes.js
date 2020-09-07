const express = require('express');
const router = express.Router();
const pool = require("../db");
const getToken = require("../util");
const QueryStream = require('pg-query-stream')
const JSONStream = require('JSONStream')


router.post("/signemployee",async (req,res) => {
    try {

        const {email,password} = req.body;
        const signEmployee = await pool.query("SELECT *,roles.name as role FROM employees join roles on roles.id = employees.role_id WHERE email=$1 AND password=crypt($2, password);",[email,password]);
        if(signEmployee.rowCount>0){
            res.json({
                name:signEmployee.rows[0].name,
                username:signEmployee.rows[0].username,
                email: signEmployee.rows[0].email,
                role: signEmployee.rows[0].role,
                token: getToken(signEmployee),
            });
        }else{
            res.status(401).send({msg: 'Грешна парола или имейл.'});
        }
    } catch (err) {
        res.status(500).send({msg: 'Възникна грешка със заявката,моля опитайте отново .'});
    }
})


//create employee
router.post("/createemployee",async (req,res) => {
    try {
        const {name,username,email,password} = req.body;
        const newEmployee = await pool.query(" INSERT INTO employees (name,username,email,password) VALUES ($1,$2,$3,$4)",[name,username,email,password]);
        if(newEmployee){
            res.json({
                name: name,
                username: username,
                email: email,
                token: getToken(newEmployee),
            });
        }else{
            res.status(401).send({msg: 'Имейла или потребителското име са заети.'});
        }

    } catch (err) {
        res.status(500).send({msg: 'Възникна грешка със заявката,моля опитайте отново .'});
    }
});

router.post("/create",async (req,res) => {
    try {
        const {name,username,email,password} = req.body;
        let usernames = 0
        let emails = 0
        const checkEmployees = await pool.query(" SELECT * FROM employees WHERE email = $2 or username =$1",[username,email]);
        checkEmployees.rows.map(employee => {
            employee.username == username ? usernames++ : usernames = usernames;
            employee.email == email ? emails++ : emails=emails;
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
        const newEmployee = await pool.query(" INSERT INTO employees (name,username,email,password) VALUES ($1,$2,$3,crypt($4, gen_salt('bf', 8)))",[name,username,email,password]);
            if(newEmployee.rowCount>0){
            res.json({
                name: name,
                username: username,
                email: email,
                token: getToken(newEmployee),
            });
        }
        }


}   catch (err) {
        res.status(500).send({msg: 'Възникна грешка със заявката,моля опитайте отново.'});
    }
});


router.post("/get",async(req,res) => {
    try {
        console.log(req.body)
        const Filters = req.body;
        var testfilters = Filters;
        const indexOfLastPost = Filters.currentPage * 9;
        const indexOfFirstPost = indexOfLastPost - 9;
        var testArray= [];
        var query = 'select * from (SELECT t.*,t.name,roles.name as role, count(*) OVER (ORDER BY t.id) as rownum FROM employees as t join roles on t.role_id = roles.id WHERE 1=1';
        const entries = Object.entries(testfilters);
        var i =0;
        for (const [key, value] of entries) {
          if(key!='filter'&&value!=''&&key!=''&&key!='currentPage'){
            if(key=='roleFilter'){
              ++i;
              testArray.push(testfilters.roleFilter);
              query += ` AND role=$${i}`
            }
            else if(key=='eUsernameFilter'){
              ++i;
              testArray.push(testfilters.eUsernameFilter);
              query += ` AND LOWER(username) LIKE concat('%',LOWER($${i}),'%')`;
            }
            else if(key=='eEmailFilter'){
              ++i;
              testArray.push(testfilters.eEmailFilter);
              query += ` AND LOWER(email) LIKE concat('%',LOWER($${i}),'%')`;
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
        }
       catch (err) {
        console.log(err)
        res.status(500).send({msg: 'There was a problem with the server.'});
    }
})


module.exports = router;
