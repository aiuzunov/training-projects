const express = require('express');
const router = express.Router();
const pool = require("../db");



router.post("/create",async (req,res) => {
    try {
        console.log("New order")
        const {payment,user_id,address_id,price,cart_items,currency,create_date} = req.body;
        console.log(payment.paid)
        console.log(cart_items[0].product)
        await pool.query("INSERT INTO payments (cancelled,paid,time_of_payment,recipient_name,recipient_email,payerID,paymentID,paymentToken,payment_sum,currency) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)",[payment.cancelled,payment.paid,create_date,payment.address.recipient_name,payment.email,payment.payerID,payment.paymentID,payment.paymentToken,price,currency]);
        await pool.query("INSERT INTO orders (user_id,address_id,payment_id,created,order_status,price) VALUES($1,$2,$3,$4,$5,$6)",[user_id,address_id,payment.paymentID,create_date,'На път!!',price]);
        orderCheck = await pool.query("SELECT id from orders where payment_id = $1",[payment.paymentID]);
        let order_id = orderCheck.rows[0].id;
        cart_items.map(cart_item =>  {
            pool.query("INSERT INTO order_items (order_id,product_id,quantity) VALUES($1,$2,$3)",[order_id,cart_item.product,cart_item.quantity]);
            pool.query("UPDATE products SET count_in_stock = count_in_stock-$2 where id = $1 and count_in_stock-$2>=0",[cart_item.product,cart_item.quantity]);
            pool.query("DELETE FROM cart_items where product_id = $1 and user_id = $2",[cart_item.product,user_id])
    });

        /*
        const newPayment = await pool.query(" INSERT INTO")
        const newOrder = await pool.query(" INSERT INTO addresses (user_id,address,city,postalcode,country) VALUES ($1,$2,$3,$4,$5)",[user_id,address,city,postalCode,country]);
        res.json(newAddress);*/
    } catch (err) {
        console.log(err)
        res.status(500).send({msg: 'Възникна проблем при създаването на нов адрес.'});
    }
})

router.get("/list/:userid",async(req,res) => {
    try {
        const {userid} = req.params;
        const allOrders = await pool.query("SELECT * FROM orders where user_id = $1",[userid]);
        res.json(allOrders.rows);
    } catch (err) {
        res.status(500).send({msg: 'Възникна проблем при взимането на информацията за адресите.'});
    }
})

router.post("/update",async(req,res) => {
    try {
        const {order_id,order_status} = req.body;
        const updateOrder = await pool.query("UPDATE orders SET order_status=$1 WHERE id = $2",[order_status,order_id]);
        res.json(updateOrder);
    } catch (err) {
        res.status(500).send({msg: 'Възникна проблем при обновяването на статуса на поръчката.'});
    }
})

router.post("/listall",async(req,res) => {
    try {
        const {currentPage} = req.body;
        const filters = req.body;
        console.log(filters)
        const indexOfLastPost = currentPage * 9;
        const indexOfFirstPost = indexOfLastPost - 9;
        if(!filters.orderFilters.filter){
        const allOrders = await pool.query("select * from (SELECT t.*, count(*) OVER (ORDER BY t.id) as rownum FROM orders as t)d where rownum >= $1 and rownum<=$2",[indexOfFirstPost,indexOfLastPost]);
        res.json(allOrders.rows);}
        else{
          var filteredOrders = await pool.query('select * from (SELECT t.*, count(*) OVER (ORDER BY t.id) as rownum FROM orders as t)d')
          filteredOrders= (filteredOrders.rows).filter(function(item) {
            for (var key in filters.orderFilters) {
              switch(key){
                case 'fromDate':
                if(filters.orderFilters.fromDate){
                    if (item['created'] === undefined || (item['created'].getFullYear()<new Date(filters.orderFilters[key]).getFullYear()||item['created'].getMonth()<new Date(filters.orderFilters[key]).getMonth()||item['created'].getDate()<new Date(filters.orderFilters[key]).getDate()))
                      return false
                    }
                  break;
                case 'toDate':
                if(filters.orderFilters.toDate){
                    if (item['created'] === undefined || (item['created'].getFullYear()>new Date(filters.orderFilters[key]).getFullYear()||item['created'].getMonth()>new Date(filters.orderFilters[key]).getMonth()||item['created'].getDate()>new Date(filters.orderFilters[key]).getDate()))
                      return false
                    }
                  break;
                case 'filter':
                  break;
                case 'status':
                  if(filters.orderFilters.status){
                      if (item['order_status'] === undefined || (item['order_status'] != filters.orderFilters[key]))
                        return false
                      }
                      break;
                default:
                  if (item[key] === undefined || item[key] != filters.orderFilters[key])
                    return false;
                  break;
              }
            }
            return true;
          });
          console.log(filteredOrders.slice(indexOfFirstPost,indexOfLastPost))
          res.json(filteredOrders.slice(indexOfFirstPost,indexOfLastPost));
        }
    } catch (err) {
        console.log(err)
        res.status(500).send({msg: 'Възникна проблем при взимането на информацията за адресите.'});
    }
})

router.get("/listItems/:order_id",async(req,res) => {
    try {
        console.log(1)
        const {order_id} = req.params;
        console.log(order_id)
        const allOrderItems = await pool.query("select * from order_items join products on order_items.product_id = products.id where products.id=order_items.product_id and order_id = $1",[order_id]);

        res.json(allOrderItems.rows);
        console.log(allOrderItems.rows)
    } catch (err) {
        res.status(500).send({msg: 'Възникна проблем при взимането на информацията за адресите.'});
    }
})

router.get("/order/:order_id",async(req,res) => {
    try {
        const {order_id} = req.params;
        const Order = await pool.query("select * from orders where id = $1",[order_id]);
        res.json(Order.rows);
    } catch (err) {
        res.status(500).send({msg: 'Възникна проблем при взимането на информацията за адресите.'});
    }
})

router.get("/count", async (req, res) => {
    try {
      console.log("Request")

      const ordersCount = await pool.query(
        "SELECT COUNT(*) FROM orders");
      res.json(ordersCount.rows[0]);
    } catch (err) {
      console.error(err.message);
    }
  });

  router.get("/count", async (req, res) => {
    try {
      console.log("Request")

      const ordersCount = await pool.query(
        "SELECT COUNT(*) FROM orders");
      res.json(ordersCount.rows[0]);
    } catch (err) {
      console.error(err.message);
    }
  });




module.exports = router;
