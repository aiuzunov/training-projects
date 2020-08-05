const express = require('express');
const router = express.Router();
const pool = require("../db");


router.get("/list:/productids",async(req,res) => {
    try {
        const {productids} = req.params;
        //za doopravqne
        const allPT = await pool.query("select tags.id,name,tags_products.product_id from tags join tags_products on tags.id = tags_products.tag_id");
        res.json(allPT.rows);
    } catch (err) {
        res.status(500).send({msg: 'There was a problem with the server.'});
    }
})

module.exports = router;