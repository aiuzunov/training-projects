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
app.post("/products",async (req,res) => {
    try {
        const {tag_id,name,image,brand,price,count_in_stock,description} = req.body;
        const newProduct = await pool.query(" INSERT INTO products (tag_id,name,image,brand,price,count_in_stock,description) VALUES ($1,$2,$3,$4,$5,$6,$7)",[tag_id,name,image,brand,price,count_in_stock,description]);
        res.json(newProduct);
    } catch (err) {
        console.error(err.message);
    }
})

// get products for 1 page
app.get("/products/:id/:name",async(req,res) => {
    try {
        const{id,name} = req.params;
        const allProducts = await pool.query("SELECT * FROM products WHERE id>$1 AND LOWER(name) LIKE concat('%',LOWER($2),'%') LIMIT 9",[id,name]);
        res.json(allProducts.rows);
    } catch (err) {
        console.error(err.message)
    }
})

// get products for 1 page
app.get("/products/:id",async(req,res) => {
    try {
        const{id} = req.params;
        const allProducts = await pool.query("SELECT * FROM products WHERE id>$1 LIMIT 9",[id]);
        res.json(allProducts.rows);
    } catch (err) {
        console.error(err.message)
    }
})





//get product count
app.get("/products/",async(req,res) => {
    try {
        const productCount = await pool.query("SELECT COUNT(*) FROM products");
        res.json(productCount.rows[0]);
    } catch (err) {
        console.error(err.message)
    }
})
/*
// get a single product 
app.get("/products/:id", async (req, res) => {
    try {
        const{id} = req.params;
        const product = await pool.query("SELECT * FROM products WHERE id = $1",[id]);
        res.json(product.rows[0]);
    } catch (err) {
        console.error(err.message)
    }
})*/

//update a product
app.put("/products/:id", async (req, res) => {
    try {
        const {id} = req.params;
        const {tag_id,name,image,brand,price,count_in_stock,description} = req.body;
        const updateProduct = await pool.query("UPDATE products SET tag_id = $2, name = $3, image = $4, brand = $5, price = $6, count_in_stock = $7, description = $8 WHERE id = $1",[id,tag_id,name,image,brand,price,count_in_stock,description]);
        res.json("The product was sucessfully updated");
    } catch (err) {
        console.log(err.message)
    }
})
// delete a product
app.delete("/products/:id",async (req,res) => {
    try {
        const {id} = req.params;
        const deleteProduct = await pool.query("DELETE FROM products WHERE id = $1",[id]);
        res.json("The Product Was Deleted");
    } catch (err) {
        console.log(err.message)
    }
})



app.listen(5000, ()=>{
 console.log("server has started");
});