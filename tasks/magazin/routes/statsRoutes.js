const express = require('express');
const router = express.Router();
const pool = require("../db");


router.post("/monthlyIncome", async (req, res) => {
    try {
          const {monthId} = req.body;
          if(monthId.length>0){
            const incomes = await pool.query("SELECT EXTRACT(MONTH FROM created) AS Month, SUM(price) FROM orders where EXTRACT(MONTH FROM created) = ANY ($1) GROUP BY month",[monthId]);
            res.json(incomes.rows);
          }
          else{
            const incomes = await pool.query("SELECT EXTRACT(MONTH FROM created) AS Month, SUM(price) FROM orders GROUP BY month");
            res.json(incomes.rows);
          }



    } catch (err) {
        console.log(err.message)
        res.status(500).send({msg: 'Възникна проблем при взимането на информацията за печалбите.'});
    }
})

router.post("/soldProducts", async (req, res) => {
    try {
        const {monthId} = req.body;
        if(monthId.length>0){
          const soldProducts = await pool.query("SELECT EXTRACT(MONTH FROM created) AS Month, SUM(quantity) AS Sales from order_items join orders on order_items.order_id = orders.id where EXTRACT(MONTH FROM created) = ANY ($1) GROUP BY month",[monthId]);
          res.json(soldProducts.rows);
        }else{
          const soldProducts = await pool.query("SELECT EXTRACT(MONTH FROM created) AS Month, SUM(quantity) AS Sales from order_items join orders on order_items.order_id = orders.id GROUP BY month");
          res.json(soldProducts.rows);
        }

    } catch (err) {
        console.log(err.message)
        res.status(500).send({msg: 'Възникна проблем при взимането на информацията за количеството продадени продукти.'});
    }
})

router.post("/registeredUsers", async (req, res) => {
    try {
        const {monthId} = req.body;
        if(monthId.length>0){
          const registeredUsers = await pool.query("SELECT EXTRACT(MONTH FROM create_date) AS Month, COUNT(*) FROM users where EXTRACT(MONTH FROM create_date) = ANY ($1)  GROUP BY month",[monthId]);
          res.json(registeredUsers.rows);
        }else{
          const registeredUsers = await pool.query("SELECT EXTRACT(MONTH FROM create_date) AS Month, COUNT(*) FROM users  GROUP BY month");
          res.json(registeredUsers.rows);
        }

    } catch (err) {
        console.log(err.message)
        res.status(500).send({msg: 'Възникна проблем при взимането на информацията за брой регистрирани потребтиели.'});
    }
})





module.exports = router;
