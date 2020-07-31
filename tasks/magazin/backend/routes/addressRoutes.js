const express = require('express');
const router = express.Router();
const pool = require("../db");

router.get("/all",async(req,res) => {
    try {
        const allAdresses = await pool.query("SELECT * FROM addresses");
        res.json(allAdresses.rows);
    } catch (err) {
        console.error(err.message)
    }
})

module.exports = router;