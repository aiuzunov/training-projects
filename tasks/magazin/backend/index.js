const express = require('express');
const app = express();
const cors = require("cors");
const pool = require("./db");
const addressRoute =require ('./routes/addressRoutes')
const cartRoute = require('./routes/cartRoutes')
const employeeRoute = require('./routes/employeeRoutes')
const productRoute = require('./routes/productRoutes')
const ptRoute = require('./routes/ptRoutes')
const tagRoute = require('./routes/tagRoutes')
const userRoute = require('./routes/userRoutes')

//for downloading images



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



app.listen(5000, ()=>{
 console.log("server has started");
});

