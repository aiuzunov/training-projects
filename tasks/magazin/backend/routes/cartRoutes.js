const express = require('express');
const router = express.Router();
const pool = require("../db");

// get a single product 
router.get("/:id", async (req, res) => {
    try {
        const{id} = req.params;
        const product = await pool.query("SELECT * FROM products WHERE id = $1",[id]);
        res.json(product.rows[0]);
    } catch (err) {
        res.status(500).send({msg: 'Възникна проблем при взимането на информацията за продукта.'});
    }
})

router.post("/create",async (req,res) => {
    try {
        const {user_id,product_id,quantity} = req.body;
        const checkCartitem = await pool.query("SELECT * from cart_items where user_id=$1 and product_id=$2",[user_id,product_id]);
        if(checkCartitem.rowCount>0){
            const newCartItem = await pool.query("UPDATE cart_items SET quantity=$1 where user_id=$2 and product_id=$3",[quantity,user_id,product_id]);
            res.json(newCartItem);   
        }
        else{
            const newCartItem = await pool.query(" INSERT INTO cart_items (user_id,product_id,quantity) VALUES ($1,$2,$3)",[user_id,product_id,quantity]);
            res.json(newCartItem);
        }
        
    } catch (err) {
        res.status(500).send({msg: 'Възникна грешка при добавянето на продукта към кошницата .'});
    }
})



router.post("/delete",async (req,res) => {
    try {
        const{product_id,user_id} = req.body;
        console.log(product_id)
        console.log(user_id)
        const deleteCartItem = await pool.query("DELETE FROM cart_items WHERE product_id = $1 and user_id=$2",[product_id,user_id]);
        res.json(deleteCartItem);
    } catch (err) {
        res.status(500).send({msg: 'Възникна грешка при визуализирането на продуктите .'});
    }
})



module.exports = router;