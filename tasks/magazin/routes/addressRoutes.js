const express = require('express');
const router = express.Router();
const pool = require("../db");

router.get("/getAll",async(req,res) => {
    try {
        const userid = req.query.userid;
        const allAdresses = await pool.query("SELECT * FROM addresses where user_id = $1",[userid]);
        res.json(allAdresses.rows);
    } catch (err) {
        res.status(500).send({msg: 'Възникна проблем при взимането на информацията за адресите.'});
    }
})

router.get("/getOne",async(req,res) => {
    try {
        const order_id = req.query.order_id;
        const Address = await pool.query("select * from addresses join orders on orders.address_id = addresses.id where orders.id = $1",[order_id]);
        res.json(Address.rows);

    } catch (err) {
        console.log(err)
        res.status(500).send({msg: 'Възникна проблем при взимането на информацията за адресите.'});
    }
})




router.post("/create",async (req,res) => {
    try {
        const {user_id,address,city,country,postalCode} = req.body;
        const checkАddress = await pool.query(" SELECT * FROM addresses WHERE address = $1 and user_id =$2",[address,user_id]);
        if(checkАddress.rows>0)
        {
            res.status(409).send({msg: 'Този адрес вече съществува.'});


        }else{
            const newAddress = await pool.query(" INSERT INTO addresses (user_id,address,city,postalcode,country) VALUES ($1,$2,$3,$4,$5)",[user_id,address,city,postalCode,country]);
            res.json(newAddress);
        }

    } catch (err) {
        console.log(err)
        res.status(500).send({msg: 'Възникна проблем при създаването на нов адрес.'});
    }
})


module.exports = router;
