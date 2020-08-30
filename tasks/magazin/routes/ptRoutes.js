const express = require('express');
const router = express.Router();
const pool = require("../db");
const { json } = require('express');


router.post("/list",async(req,res) => {
    try {
      const Filters = req.body;
      var testfilters = Filters;
      const indexOfLastPost = Filters.currentPage * 27;
      const indexOfFirstPost = indexOfLastPost - 27;
      var testArray= [];
      if(testfilters.searchfilter!=''){
        var i=2;
        testArray.push(testfilters.searchfilter);
        var query = "select distinct tags.name,tags_products.product_id from tags_products join (SELECT t.*, count(*) OVER (ORDER BY t.id) as rownum FROM tags_products as t join tags on tags.id = t.tag_id join products on products.id = t.product_id where LOWER(products.name) LIKE concat('%',LOWER($1),'%')";
      }else{
        var i=1;
        var query = "select distinct tags.name,tags_products.product_id from tags_products join (SELECT t.*, count(*) OVER (ORDER BY t.id) as rownum FROM tags_products as t join tags on tags.id = t.tag_id join products on products.id = t.product_id WHERE 1=1";
      }

  const entries = Object.entries(testfilters);
  for (const [key, value] of entries) {
    if(key!='filter'&&value!=''&&key!='pricefilter'&&key!='searchfilter'&&key!='tagfilter'&&key!='ageFilter'&&key!='cisFilter'&&key!='currentPage'){
      if(key=='fromDateFilter'){
        query = query + ` AND create_date>=$${i}`
        i++;
        testArray.push(testfilters.fromDateFilter);

      }
      else if(key=='toDateFilter'){
        testArray.push(testfilters.toDateFilter);
        query = query + ` AND create_date<=$${i}`
        i++;
      }
      else{
      query = query + ` AND ${key}=$${i}`;
      testArray.push(value)
      i++;
    }
    }

  }
    query += ` AND price>=$${i} AND price<=$${i+1}`
    testArray.push(testfilters.pricefilter[0])
    testArray.push(testfilters.pricefilter[1])
    if(testfilters.cisFilter){
      switch(testfilters.cisFilter){
        case 1:
          query+=' and count_in_stock=0'
          break;
        case 2:
          query+=' and count_in_stock=1'
          break;
        case 3:
          query+=' and count_in_stock>1'
          break;
      }
    }
    if(testfilters.ageFilter){
      switch(testfilters.ageFilter){
        case 'ASC':
          query+=' ORDER BY create_date ASC'
          break;
        case 'DESC':
          query+=' ORDER BY create_date DESC'
          break;
      }
    }



    if(testfilters.tagfilter.length==0){
      testArray.push(indexOfFirstPost)
      testArray.push(indexOfLastPost)
      query+=`)d on tags_products.product_id = d.product_id join tags on tags.id = tags_products.tag_id where rownum>$${i+2} and rownum <= $${i+3}`
    }else{
      testArray.push(testfilters.tagfilter)
      testArray.push(indexOfFirstPost)
      testArray.push(indexOfLastPost)
      query+=`)d on tags_products.product_id = d.product_id join tags on tags.id = tags_products.tag_id where tags_products.tag_id = ANY ($${i+2}) AND rownum>=$${i+3} and rownum <= $${i+4}`

    }
    console.log("This is the query:",query)


    var test = await pool.query(query,testArray)
      console.log(test.rows)
      res.json(test.rows);

    } catch (err) {
        console.log(err)
        res.status(500).send({msg: 'Възкникна грешка, моля опитайте отново.'});
    }
})

module.exports = router;
