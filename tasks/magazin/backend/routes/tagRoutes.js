const express = require('express');
const router = express.Router();
const pool = require("../db");

router.get("/all",async(req,res) => {
    try {
        const allTags = await pool.query("SELECT * FROM tags");
        res.json(allTags.rows);
    } catch (err) {
        console.error(err.message)
    }
})

router.get("/:id",async(req,res) => {
    try {
        const{id} = req.params;
        console.log(id)

        const productTags = await pool.query("select name from tags join tags_products on tags.id = tags_products.tag_id where product_id = $1",[id]);
        res.json(productTags.rows);
    } catch (err) {
        console.error(err.message)
    }
})


module.exports = router;