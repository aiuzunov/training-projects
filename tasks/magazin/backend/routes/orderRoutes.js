const express = require('express');
const router = express.Router();
const pool = require("../db");



router.post("/create",async (req,res) => {
    try {
        const {payment,user_id,address_id,price,cart_items,currency,create_date} = req.body;
        console.log(payment.paid)
        console.log(cart_items[0].product)
        await pool.query("INSERT INTO payments (cancelled,paid,time_of_payment,recipient_name,recipient_email,payerID,paymentID,paymentToken,payment_sum,currency) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)",[payment.cancelled,payment.paid,create_date,payment.address.recipient_name,payment.email,payment.payerID,payment.paymentID,payment.paymentToken,price,currency]);
        await pool.query("INSERT INTO orders (user_id,address_id,payment_id,created,order_status,price) VALUES($1,$2,$3,$4,$5,$6)",[user_id,address_id,payment.paymentID,create_date,'На път!!',price]);
        orderCheck = await pool.query("SELECT id from orders where payment_id = $1",[payment.paymentID]);
        let order_id = orderCheck.rows[0].id;
        cart_items.map(cart_item =>  {
            pool.query("INSERT INTO order_items (order_id,product_id,quantity) VALUES($1,$2,$3)",[order_id,cart_item.product,cart_item.quantity]);
            pool.query("UPDATE products SET count_in_stock = count_in_stock-$2 where id = $1 and count_in_stock-$2>=0",[cart_item.product,cart_item.quantity]);
            pool.query("DELETE FROM cart_items where product_id = $1 and user_id = $2",[cart_item.product,user_id])    
    });  
        
        /*
        const newPayment = await pool.query(" INSERT INTO")
        const newOrder = await pool.query(" INSERT INTO addresses (user_id,address,city,postalcode,country) VALUES ($1,$2,$3,$4,$5)",[user_id,address,city,postalCode,country]);
        res.json(newAddress);*/
    } catch (err) {
        console.log(err)
        res.status(500).send({msg: 'Възникна проблем при създаването на нов адрес.'});
    }
})


module.exports = router;