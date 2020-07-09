const express = require('express');
const app = express();
const cors = require("cors");
const pool = require("./db");

//middleware
app.use(cors());
app.use(express.json());

//routes

//create a new employee
app.post("/employees",async (req,res) => {
    try {
        const { name , username , email, password } = req.body;
        const newEmployee = await pool.query(
          "INSERT INTO employees (name,username,email,password) VALUES($1,$2,$3,$4)",[name,username,email,password]  
        );

        res.json(newEmployee);
    } catch (err) {
        console.error(err.message);
    }
})

//create a new user
app.post("/users",async (req,res) => {
    try {
        const {name,username,email,password} = req.body;
        const newUser = await pool.query(
            "INSERT INTO users (name,username,email,password) VALUES($1,$2,$3,$4)",[name,username,email,password]
        );
        res.json(newUser);
    } catch (err) {
        console.error(err.message);
    }

})

//create tag
app.post("/tags",async (req,res) => {
    try {
        const {name} = req.body;
        const newTag = await pool.query(" INSERT INTO tags (name) VALUES ($1)",[name]);
        res.json(newTag);
    } catch (err) {
        console.error(err.message);
    }
})
//create product
app.post("/tags",async (req,res) => {
    try {
        const {name} = req.body;
        const newTag = await pool.query(" INSERT INTO tags (name) VALUES ($1)",[name]);
        res.json(newTag);
    } catch (err) {
        console.error(err.message);
    }
})
// get all products
app.post("/products",async (req,res) => {
    try {
        const {tag_id,name,image,brand,price,count_in_stock,description} = req.body;
        const newProduct = await pool.query(" INSERT INTO products (tag_id,name,image,brand,price,count_in_stock,description) VALUES ($1,$2,$3,$4,$5,$6,$7)",[tag_id,name,image,brand,price,count_in_stock,description]);
        res.json(newProduct);
    } catch (err) {
        console.error(err.message);
    }
})
// get a product

// delete a product


// add aaddress


//create an order



app.listen(5000, ()=>{
 console.log("server has started");
});