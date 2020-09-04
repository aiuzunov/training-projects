const express = require('express');
const router = express.Router();
const pool = require("../db");
const QueryStream = require('pg-query-stream')
const JSONStream = require('JSONStream')


router.post("/monthlyIncome", async (req, res) => {
    try {
        const {monthId,from,to,groupBy} = req.body;
        var fromdate = from.split(",");
        var todate = to.split(",");
        var query = '';
        var testArray = [fromdate,todate];
        switch(groupBy){
          case 'DATE':
            query += "SELECT substring(CAST(created AS TEXT) from 0 for 11) AS DATE, SUM(price) from orders where DATE(created)>=$1 and DATE(created)<=$2 GROUP BY DATE ORDER BY DATE ASC";
            break;
          case 'MONTH':
            query += "SELECT EXTRACT(MONTH from created) AS DATE, SUM(price) from orders where DATE(created)>=$1 and DATE(created)<=$2 GROUP BY DATE ORDER BY DATE ASC";
            break;
          case 'YEAR':
            query+= "SELECT EXTRACT(YEAR from created) AS DATE, SUM(price) from orders where DATE(created)>=$1 and DATE(created)<=$2 GROUP BY DATE ORDER BY DATE ASC";
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
        const {monthId,from,to,groupBy} = req.body;
        console.log(groupBy)
        var fromdate = from.split(",");
        var todate = to.split(",");
        var query = '';
        var testArray = [fromdate,todate];
        switch(groupBy){
          case 'DATE':
            query += "SELECT substring(CAST(create_date AS TEXT) from 0 for 11) AS DATE, COUNT(*) FROM users where DATE(create_date)>=$1 and DATE(create_date)<=$2 GROUP BY DATE ORDER BY DATE ASC";
            break;
          case 'MONTH':
            query += "SELECT EXTRACT(MONTH from create_date) AS DATE, COUNT(*) FROM users where DATE(create_date)>=$1 and DATE(create_date)<=$2 GROUP BY DATE ORDER BY DATE ASC";
            break;
          case 'YEAR':
            query += "SELECT EXTRACT(YEAR from create_date) AS DATE, COUNT(*) FROM users where DATE(create_date)>=$1 and DATE(create_date)<=$2 GROUP BY DATE ORDER BY DATE ASC";
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
