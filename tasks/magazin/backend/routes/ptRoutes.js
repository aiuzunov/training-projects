const express = require('express');
const router = express.Router();
const pool = require("../db");
const { json } = require('express');


router.post("/list/:pageNumber",async(req,res) => {
    try {
        const {pageNumber} = req.params;
        const indexOfLastPost = pageNumber * 27;
        const indexOfFirstPost = indexOfLastPost - 27;
        console.log(indexOfFirstPost,indexOfLastPost)
        const allPT = await pool.query(`select * from (SELECT t.*,tags.name, count(*) OVER (ORDER BY t.id) as rownum FROM tags_products as t join tags on tags.id = t.tag_id)d  where rownum>$1 and rownum<=$2 `,[indexOfFirstPost,indexOfLastPost]);
        res.json(allPT.rows);
    } catch (err) {
        console.log(err)
        res.status(500).send({msg: 'Възкникна грешка, моля опитайте отново.'});
    }
})

module.exports = router;