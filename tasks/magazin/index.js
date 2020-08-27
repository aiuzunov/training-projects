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





app.use(cors());
app.use(express.json());
app.use(express.static('public'))
app.use('/addresses',addressRoute)
app.use('/cart',cartRoute)
app.use('/employees',employeeRoute)
app.use('/products',productRoute)
app.use('/pts',ptRoute)
app.use('/tags',tagRoute)
app.use('/users',userRoute)
app.use('/orders',orderRoute)
app.use('/payments',paymentRoute)
app.use('/stats',statsRoute)
if(process.env.NODE_ENV === "production"){
	console.log(path.join(__dirname,"frontend/routing/build"))
	app.use(express.static(path.join(__dirname, "frontend/routing/build")));
	app.get('/*', (req, res) => {
  res.sendFile(__dirname + "/frontend/routing/build" + '/index.html');
})

}

const PORT = process.env.PORT||'5000';
app.listen(PORT, ()=>{
 console.log("server has started");
});
