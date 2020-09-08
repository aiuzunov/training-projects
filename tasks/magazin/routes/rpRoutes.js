const express = require('express');
const router = express.Router();
const pool = require("../db");
const { json } = require('express');
const Cursor = require('pg-cursor')
const QueryStream = require('pg-query-stream')
const JSONStream = require('JSONStream')



router.get("/get",async(req,res) => {
    try {
        const roles = await pool.query("select roles.id,roles.name as role,array_agg(permissions.name) as permissions from roles join roles_perms on roles.id = roles_perms.role_id join permissions on permissions.id = roles_perms.perm_id group by roles.id,roles.name");
        res.json(roles.rows);

    } catch (err) {
        console.log(err)
        res.status(500).send({msg: 'Възникна проблем при взимането на информацията за ролите.'});
    }
})

router.post("/update",async(req,res) => {
    try {
        const {role_id,perm_id,action} = req.body;
        if(action=='give'){
          const permissions = await pool.query("INSERT INTO roles_perms (role_id,perm_id) VALUES($1,$2)",[role_id,perm_id]);
          res.json(permissions.rows);
        }
        else if(action=='take'){
          const permissions = await pool.query("DELETE FROM roles_perms where role_id=$1 and perm_id=$2",[role_id,perm_id]);
          res.json(permissions.rows);
        }


    } catch (err) {
        console.log(err)
        res.status(500).send({msg: 'Възникна проблем при взимането на информацията за ролите.'});
    }
})

module.exports = router;
