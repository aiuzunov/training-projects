const express = require('express');
const router = express.Router();
const pool = require("../db");

router.get("/get",async(req,res) => {
    try {
        const order_id = req.query.order_id;
        const payment = await pool.query("select cancelled,paid,time_of_payment,recipient_name,recipient_email,payment_sum,payments.currency from payments join orders on orders.payment_id = payments.paymentid where orders.id = $1",[order_id]);
        res.json(payment.rows);

    } catch (err) {
        console.log(err)
        res.status(500).send({msg: 'Възникна проблем при взимането на информацията за адресите.'});
    }
})


module.exports = router;
