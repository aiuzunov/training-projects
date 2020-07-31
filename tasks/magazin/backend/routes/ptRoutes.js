const express = require('express');
const router = express.Router();
const pool = require("../db");


router.get("/list",async(req,res) => {
    try {
        const allPT = await pool.query("select tags.id,name,tags_products.product_id from tags join tags_products on tags.id = tags_products.tag_id");
        res.json(allPT.rows);
    } catch (err) {
        console.error(err.message)
    }
})

module.exports = router;