const express = require('express');
const router = express.Router();
const pool = require("../db");


router.get("/monthlyIncome", async (req, res) => {
    try {
        const incomes = await pool.query("SELECT EXTRACT(MONTH FROM created) AS Month, SUM(price) FROM orders GROUP BY month");
        res.json(incomes.rows);
    } catch (err) {
        res.status(500).send({msg: 'Възникна проблем при взимането на информацията за печалбите.'});
    }
})

router.get("/soldProducts", async (req, res) => {
    try {
        const soldProducts = await pool.query("SELECT EXTRACT(MONTH FROM created) AS Month, SUM(quantity) AS Sales from order_items join orders on order_items.order_id = orders.id GROUP BY month");
        res.json(soldProducts.rows);
    } catch (err) {
        res.status(500).send({msg: 'Възникна проблем при взимането на информацията за количеството продадени продукти.'});
    }
})

router.get("/registeredUsers", async (req, res) => {
    try {
        const registeredUsers = await pool.query("SELECT EXTRACT(MONTH FROM create_date) AS Month, COUNT(*) FROM users  GROUP BY month");
        res.json(registeredUsers.rows);
    } catch (err) {
        res.status(500).send({msg: 'Възникна проблем при взимането на информацията за брой регистрирани потребтиели.'});
    }
})





module.exports = router;
