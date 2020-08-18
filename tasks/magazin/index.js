const express = require('express');
const app = express();
const path = require("path");
const cors = require("cors");
const pool = require("./db");
const addressRoute =require ('./routes/addressRoutes')
const cartRoute = require('./routes/cartRoutes')
const employeeRoute = require('./routes/employeeRoutes')
const productRoute = require('./routes/productRoutes')
const ptRoute = require('./routes/ptRoutes')
const tagRoute = require('./routes/tagRoutes')
const userRoute = require('./routes/userRoutes')
const orderRoute = require('./routes/orderRoutes')
const paymentRoute = require('./routes/paymentRoutes')
const statsRoute = require('./routes/statsRoutes')
const PORT = process.env.PORT||'5000';

//process.env.PORT
//process.env.NODE_ENV => production or undefined



//middleware
app.use(cors());
app.use(express.json());
app.use(express.static('public'))
app.use('/api/addresses',addressRoute)
app.use('/api/cart',cartRoute)
app.use('/api/employees',employeeRoute)
app.use('/api/products',productRoute)
app.use('/api/pts',ptRoute)
app.use('/api/tags',tagRoute)
app.use('/api/users',userRoute)
app.use('/api/orders',orderRoute)
app.use('/api/payments',paymentRoute)
app.use('/api/stats',statsRoute)

if(process.env.NODE_ENV === "production"){
	app.use(express.static(path.join(__dirname, "frontend/routing/build")));
}


app.listen(PORT, ()=>{
 console.log("server has started");
});
