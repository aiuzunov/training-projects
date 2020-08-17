const express = require('express');
const router = express.Router();
const pool = require("../db");
const { json } = require('express');


router.post("/list",async(req,res) => {
    try {
        console.log(req.body)
        const {currentPage,pricefilter,tagfilter,searchfilter} = req.body;
        var indexOfLastPost = currentPage * 27;
        var indexOfFirstPost = indexOfLastPost - 27;
        console.log(indexOfFirstPost,indexOfLastPost)
        if(pricefilter){
            price1=pricefilter[0];
            price2=pricefilter[1];
        }
        if(tagfilter&&searchfilter&&pricefilter){
            indexOfLastPost = currentPage * 9;
            indexOfFirstPost = indexOfLastPost -9;
            const allPT = await pool.query(`select tags.name,tags_products.product_id from tags_products join (SELECT t.*, count(*) OVER (ORDER BY t.id) as rownum FROM tags_products as t join tags on tags.id = t.tag_id join products on products.id = t.product_id where LOWER(products.name) LIKE concat('%',LOWER($5),'%') and products.price >=$3 and products.price <=$4 and t.tag_id = $6)d on tags_products.product_id = d.product_id join tags on tags.id = tags_products.tag_id where rownum>=$1 and rownum<=$2`,[indexOfFirstPost,indexOfLastPost,price1,price2,searchfilter,tagfilter]);
            res.json(allPT.rows);
        }
        else if(tagfilter&&pricefilter){
            const allPT = await pool.query(`select tags.name,tags_products.product_id from tags_products join (SELECT t.*, count(*) OVER (ORDER BY t.id) as rownum FROM tags_products as t join tags on tags.id = t.tag_id join products on products.id = t.product_id where products.price >=$3 and products.price <=$4 and t.tag_id = $5)d on tags_products.product_id = d.product_id join tags on tags.id = tags_products.tag_id where rownum>=$1 and rownum<=$2`,[indexOfFirstPost,indexOfLastPost,price1,price2,tagfilter]);
            indexOfLastPost = currentPage * 9;
            indexOfFirstPost = indexOfLastPost -9;
            res.json(allPT.rows);
        }
        else if(searchfilter&&pricefilter){
            const allPT = await pool.query(`select * from (SELECT t.*,tags.name, count(*) OVER (ORDER BY t.id) as rownum FROM tags_products as t join tags on tags.id = t.tag_id join products on products.id = t.product_id where LOWER(products.name) LIKE concat('%',LOWER($5),'%') and products.price >=$3 and products.price <=$4)d  where rownum>$1 and rownum<=$2 `,[indexOfFirstPost,indexOfLastPost,price1,price2,searchfilter]);
            res.json(allPT.rows);
        }
        else{
            const allPT = await pool.query(`select * from (SELECT t.*,tags.name, count(*) OVER (ORDER BY t.id) as rownum FROM tags_products as t join tags on tags.id = t.tag_id join products on products.id = t.product_id where products.price >=$3 and products.price <=$4)d  where rownum>$1 and rownum<=$2 `,[indexOfFirstPost,indexOfLastPost,price1,price2]);
            res.json(allPT.rows);
        }
        
    } catch (err) {
        console.log(err)
        res.status(500).send({msg: 'Възкникна грешка, моля опитайте отново.'});
    }
})

module.exports = router;