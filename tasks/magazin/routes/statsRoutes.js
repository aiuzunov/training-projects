const express = require('express');
const router = express.Router();
const pool = require("../db");


router.post("/monthlyIncome", async (req, res) => {
    try {
        const {monthId,from,to} = req.body;
        var fromdate = from.split(",");
        var todate = to.split(",");
        const incomes = await pool.query("SELECT DATE(created) AS DATE, SUM(price) FROM orders where DATE(created)>=$1 and DATE(created)<=$2 GROUP BY DATE",[fromdate[0],todate[0]]);
        res.json(incomes.rows);
    } catch (err) {
        console.log(err.message)
        res.status(500).send({msg: 'Възникна проблем при взимането на информацията за печалбите.'});
    }
})

router.post("/soldProducts", async (req, res) => {
    try {
        const {monthId,from,to} = req.body;
        var fromdate = from.split(",");
        var todate = to.split(",");
        const soldProducts = await pool.query("SELECT DATE(created) AS DATE, SUM(quantity) AS Sales from order_items join orders on order_items.order_id = orders.id where DATE(created)>=$1 and DATE(created)<=$2 GROUP BY DATE",[fromdate[0],todate[0]]);
        res.json(soldProducts.rows);
    } catch (err) {
        console.log(err.message)
        res.status(500).send({msg: 'Възникна проблем при взимането на информацията за количеството продадени продукти.'});
    }
})

router.post("/registeredUsers", async (req, res) => {
    try {
        const {monthId,from,to} = req.body;
        var fromdate = from.split(",");
        var todate = to.split(",");
        const registeredUsers = await pool.query("SELECT create_date AS DATE, COUNT(*) FROM users where DATE(create_date)>=$1 and DATE(create_date)<=$2 GROUP BY DATE ORDER BY DATE ASC",[fromdate[0],todate[0]]);
        res.json(registeredUsers.rows);
        console.log(registeredUsers.rows)
    } catch (err) {
        console.log(err.message)
        res.status(500).send({msg: 'Възникна проблем при взимането на информацията за брой регистрирани потребтиели.'});
    }
})





module.exports = router;
