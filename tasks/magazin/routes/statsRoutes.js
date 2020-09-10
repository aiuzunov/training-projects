const express = require('express');
const router = express.Router();
const pool = require("../db");
const QueryStream = require('pg-query-stream')
const JSONStream = require('JSONStream')


router.post("/monthlyIncome", async (req, res) => {
    try {
      const Filters = req.body;
      var testfilters = Filters;
      console.log("Grpby",testfilters.groupBy)
      var testArray= [];
      if(testfilters.groupBy!=''){
        switch(testfilters.groupBy){
          case 'USER':
            var query = 'SELECT DISTINCT users.name,users.email,users.username,sum(t.price) as price,currency FROM orders as t join users on t.user_id = users.id join order_items on order_items.order_id = t.id join products on order_items.product_id = products.id join addresses on addresses.id = t.address_id where DATE(created)>=$1 and DATE(created)<=$2 group by  users.name,users.email,users.username,currency'
            testArray.push(testfilters.from)
            testArray.push(testfilters.to)
            break;
          case 'MONTH':
            var query = 'SELECT EXTRACT(MONTH FROM created) AS date,users.name,users.email,users.username,SUM(orders.price) as price,currency FROM orders join users on orders.user_id = users.id where DATE(created)>=$1 and DATE(created)<=$2 group by date,users.name,users.email,users.username,currency'
            testArray.push(testfilters.from)
            testArray.push(testfilters.to)
            break;
          case 'YEAR':
          var query = 'SELECT EXTRACT(YEAR FROM created) AS date,users.name,users.email,users.username,SUM(orders.price) as price,currency FROM orders join users on orders.user_id = users.id where DATE(created)>=$1 and DATE(created)<=$2 group by date,users.name,users.email,users.username,currency'
          testArray.push(testfilters.from)
          testArray.push(testfilters.to)
          break;
          default:
          break;
        }
      }else {
      var query = "select * from (SELECT t.*,users.name,users.email,users.username,addresses.address,string_agg(products.name, ', '), count(*) OVER (ORDER BY t.id) as rownum FROM orders as t join users on t.user_id = users.id join order_items on order_items.order_id = t.id join products on order_items.product_id = products.id join addresses on addresses.id = t.address_id WHERE 1=1";
      const entries = Object.entries(testfilters);
      var i =0;
      for (const [key, value] of entries) {
        if(key!='filter'&&value!=''&&key!=''&&key!='currentPage'&&key!="groupBy"){
          if(key=='from'){
            ++i;
            query = query + ` AND DATE(created)>=$${i}`
            testArray.push(testfilters.from);

          }
          else if(key=='to'){
            ++i;
            testArray.push(testfilters.to);
            query = query + ` AND DATE(created)<=$${i}`
          }
          else if(key=='statusFilter'){
            ++i;
            testArray.push(testfilters.statusFilter);
            query += ` AND order_status=$${i}`
          }
          else{
          ++i;
          query = query + ` AND ${key}=$${i}`;
          testArray.push(value)
        }
        }
      }
      query+=` group by t.id,users.name,users.email,users.username,addresses.address)d`
    }
      console.log("Stat",query)
      pool.connect((err, client, done) => {
     if (err) throw err;
     const data = new QueryStream(query,testArray)
     const stream = client.query(data)
     stream.on('end', done)
     stream.pipe(JSONStream.stringify()).pipe(res)
   })
    } catch (err) {
        console.log(err.message)
        res.status(500).send({msg: 'Възникна проблем при взимането на информацията за печалбите.'});
    }
})

router.post("/soldProducts", async (req, res) => {
    try {
        const {monthId,from,to,groupBy} = req.body;
        var fromdate = from.split(",");
        var todate = to.split(",");
        var query = '';
        var testArray = [fromdate,todate];
        switch(groupBy){
          case 'DATE':
            query += "SELECT substring(CAST(created AS TEXT) from 0 for 11) AS DATE, SUM(quantity) AS Sales from order_items join orders on order_items.order_id = orders.id where DATE(created)>=$1 and DATE(created)<=$2 GROUP BY DATE ORDER BY DATE ASC";
            break;
          case 'MONTH':
            query += "SELECT EXTRACT(MONTH from created) AS DATE, SUM(quantity) AS Sales from order_items join orders on order_items.order_id = orders.id where DATE(created)>=$1 and DATE(created)<=$2 GROUP BY DATE ORDER BY DATE ASC";
            break;
          case 'YEAR':
            query+= "SELECT EXTRACT(YEAR from created) AS DATE, SUM(quantity) AS Sales from order_items join orders on order_items.order_id = orders.id where DATE(created)>=$1 and DATE(created)<=$2 GROUP BY DATE ORDER BY DATE ASC";
            break;
          default:
            break;
        }
        pool.connect((err, client, done) => {
     if (err) throw err;
     const data = new QueryStream(query,testArray)
     const stream = client.query(data)
     stream.on('end', done)
     stream.pipe(JSONStream.stringify()).pipe(res)
   })
    } catch (err) {
        console.log(err)
        res.status(500).send({msg: 'Възникна проблем при взимането на информацията за количеството продадени продукти.'});
    }
})

router.post("/registeredUsers", async (req, res) => {
    try {
      console.log(req.body)
      const Filters = req.body;
      var testfilters = Filters;
      var testArray= [];
      var query = 'select * from (SELECT t.*,name, count(*) OVER (ORDER BY t.id) as rownum FROM users as t WHERE 1=1';
      const entries = Object.entries(testfilters);
      var i =0;
      for (const [key, value] of entries) {
        if(key!='filter'&&value!=''&&key!=''&&key!='currentPage'){
          if(key=='verifiedFilter'){
            ++i;
            testArray.push(testfilters.verifiedFilter);
            query += ` AND verified=$${i}`
          }
          else if(key=='usernameFilter'){
            ++i;
            testArray.push(testfilters.usernameFilter);
            query += ` AND LOWER(username) LIKE concat('%',LOWER($${i}),'%')`;
          }
          else if(key=='emailFilter'){
            ++i;
            testArray.push(testfilters.emailFilter);
            query += ` AND LOWER(email) LIKE concat('%',LOWER($${i}),'%')`;
          }
          else if(key=='from'){
            ++i;
            query = query + ` AND DATE(create_date)>=$${i}`
            testArray.push(testfilters.from);

          }
          else if(key=='to'){
            ++i;
            testArray.push(testfilters.to);
            query = query + ` AND DATE(create_date)<=$${i}`
          }
          else{
          ++i;
          query = query + ` AND ${key}=$${i}`;
          testArray.push(value)
        }
        }
      }
        query+=`)d`
        pool.connect((err, client, done) => {
       if (err) throw err;
       const data = new QueryStream(query,testArray)
       const stream = client.query(data)
       stream.on('end', done)
       stream.pipe(JSONStream.stringify()).pipe(res)
     })
    } catch (err) {
        console.log(err.message)
        res.status(500).send({msg: 'Възникна проблем при взимането на информацията за брой регистрирани потребтиели.'});
    }
})

router.post("/bestSellers", async (req, res) => {
    try {
        const {monthId,from,to,groupBy} = req.body;
        console.log(groupBy)
        var fromdate = from.split(",");
        var todate = to.split(",");
        var query = '';
        var testArray = [fromdate,todate];
        switch(groupBy){
          case 'DATE':
            query += "SELECT created,substring(CAST(created AS TEXT) from 0 for 11), product_id, Total,products.name FROM ( SELECT created, product_id, SUM(quantity) as Total, RANK() OVER(PARTITION BY created ORDER BY SUM(quantity) DESC) rank FROM order_items join orders on order_items.order_id = orders.id GROUP BY created, product_id) a join products on products.id = a.product_id WHERE rank = 1 and DATE(created) >= $1 and DATE(created)<=$2 ORDER BY created ASC";
            break;
          case 'MONTH':
            query += "SELECT created,EXTRACT(MONTH from created) as DATE, product_id, Total,products.name FROM ( SELECT created, product_id, SUM(quantity) as Total, RANK() OVER(PARTITION BY EXTRACT(MONTH from created) ORDER BY SUM(quantity) DESC) rank FROM order_items join orders on order_items.order_id = orders.id GROUP BY created, product_id) a join products on products.id = a.product_id WHERE rank = 1 and date(created)>=$1 and date(created)<=$2 ORDER BY DATE ASC";
            break;
          case 'YEAR':
            query += "SELECT created,EXTRACT(YEAR from created) as DATE, product_id, Total,products.name FROM ( SELECT created, product_id, SUM(quantity) as Total, RANK() OVER(PARTITION BY EXTRACT(YEAR from created) ORDER BY SUM(quantity) DESC) rank FROM order_items join orders on order_items.order_id = orders.id GROUP BY created, product_id) a join products on products.id = a.product_id WHERE rank = 1 and date(created)>=$1 and date(created)<=$2 ORDER BY DATE ASC";
            break;
          default:
            break;
        }
        pool.connect((err, client, done) => {
     if (err) throw err;
     const data = new QueryStream(query,testArray)
     const stream = client.query(data)
     stream.on('end', done)
     stream.pipe(JSONStream.stringify()).pipe(res)
   })
    } catch (err) {
        console.log(err.message)
        res.status(500).send({msg: 'Възникна проблем при взимането на информацията за брой регистрирани потребтиели.'});
    }
})





module.exports = router;
