const express = require('express');
const router = express.Router();
const pool = require("../db");
const { json } = require('express');
const Cursor = require('pg-cursor')
const QueryStream = require('pg-query-stream')
const JSONStream = require('JSONStream')




router.post("/list",async(req,res) => {
    try {
      const Filters = req.body;
      var testfilters = Filters;
      const indexOfLastPost = Filters.currentPage * 27;
      const indexOfFirstPost = indexOfLastPost - 27;
      var testArray= [];
      var query = 'select DISTINCT tags.name,tags_products.product_id from tags_products join (SELECT t.*, count(*) OVER ';
      if(testfilters.ageFilter){
        switch(testfilters.ageFilter){
          case 'ASC':
            query+='(ORDER BY products.create_date ASC, products.id)'
            break;
          case 'DESC':
            query+='(ORDER BY products.create_date DESC, products.id DESC)'
            break;
        }
      }else{
        query+=`(ORDER BY t.id)`
      }
      if(testfilters.searchfilter!=''){
        var i=2;
        testArray.push(testfilters.searchfilter);
         query += "  as rownum FROM tags_products as t join tags on tags.id = t.tag_id join products on products.id = t.product_id where LOWER(products.name) LIKE concat('%',LOWER($1),'%')";
      }else{
        var i=1;
         query += "  as rownum FROM tags_products as t join tags on tags.id = t.tag_id join products on products.id = t.product_id WHERE 1=1";
      }

  const entries = Object.entries(testfilters);
  for (const [key, value] of entries) {
    if(key!='filter'&&value!=''&&key!='pricefilter'&&key!='searchfilter'&&key!='tagfilter'&&key!='ageFilter'&&key!='cisFilter'&&key!='currentPage'){
      if(key=='from'){
        query = query + ` AND DATE(create_date)>=$${i}`
        i++;
        testArray.push(testfilters.from);

      }
      else if(key=='to'){
        testArray.push(testfilters.to);
        query = query + ` AND DATE(create_date)<=$${i}`
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
      query+=`)d on tags_products.product_id = d.product_id join tags on tags.id = tags_products.tag_id where rownum>=$${i+2} and rownum <= $${i+3}`

    }else{
      query+=`)d on tags_products.product_id = d.product_id join tags on tags.id = tags_products.tag_id where rownum>=$${i+3} and rownum <= $${i+4}`
    }

        if(testfilters.tagfilter.length==0){
          testArray.push(indexOfFirstPost)
          testArray.push(indexOfLastPost)
        }else{
          testArray.push(testfilters.tagfilter)
          testArray.push(indexOfFirstPost)
          testArray.push(indexOfLastPost)
          query+=` and d.tag_id = ANY($${i+2})`

        }
    pool.connect((err, client, done) => {
     if (err) throw err;
     const data = new QueryStream(query,testArray)
     const stream = client.query(data)
     stream.on('end', done)
     stream.pipe(JSONStream.stringify()).pipe(res)
   })
    } catch (err) {
      console.log("Get Products Error",err)
        res.status(500).send({msg: 'Възкникна грешка, моля опитайте отново.'});
    }
})

module.exports = router;
