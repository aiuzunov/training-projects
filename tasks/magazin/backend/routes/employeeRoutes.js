const express = require('express');
const router = express.Router();
const pool = require("../db");
const getToken = require("../util");



router.post("/signemployee",async (req,res) => {
    try {
      
        const {email,password} = req.body;
        const signEmployee = await pool.query("SELECT * FROM employees WHERE email=$1 AND password=$2",[email,password]);
        console.log()
        if(signEmployee.rowCount>0){
            res.json({
                name:signEmployee.rows[0].name,
                username:signEmployee.rows[0].username,
                email: signEmployee.rows[0].email,
                token: getToken(signEmployee),
            });
        }else{
            res.status(401).send({msg: 'Invalid Email or Password.'});
        }
    } catch (err) {
        console.error(err.message);
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
            res.status(401).send({msg: 'Invalid User Data.'});
        }
        
    } catch (err) {
        console.error(err.message);
    }
})


module.exports = router;