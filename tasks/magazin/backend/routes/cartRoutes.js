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
        console.error(err.message)
    }
})

module.exports = router;