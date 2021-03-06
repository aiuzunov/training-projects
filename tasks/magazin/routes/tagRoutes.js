const express = require('express');
const router = express.Router();
const pool = require("../db");

router.get("/getAll",async(req,res) => {
    try {
        const allTags = await pool.query("SELECT * FROM tags");
        res.json(allTags.rows);
    } catch (err) {
        res.status(500).send({msg: 'There was a problem with the server.'});
    }
})

router.get("/getOne",async(req,res) => {
    try {
        const id = req.query.id;
        const productTags = await pool.query("select name from tags join tags_products on tags.id = tags_products.tag_id where product_id = $1",[id]);
        res.json(productTags.rows);
    } catch (err) {
        res.status(500).send({msg: 'Възкникна грешка, моля опитайте отново.'});
    }
})


module.exports = router;
