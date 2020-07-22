const express = require('express');
const app = express();
const cors = require("cors");
const pool = require("./db");
const getToken = require("./util");


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
        console.log('test2321');
        const {tag_id,name,image,brand,price,count_in_stock,description} = req.body;
        const newProduct = await pool.query(" INSERT INTO products (tag_id,name,image,brand,price,count_in_stock,description) VALUES ($1,$2,$3,$4,$5,$6,$7)",[tag_id,name,image,brand,price,count_in_stock,description]);
        res.json(newProduct);
    } catch (err) {
        console.error(err.message);
    }
})

//update product
app.put("/products/:id",async (req,res) => {
    try {
        console.log('test221');
        const {id,tag_id,name,image,brand,price,count_in_stock,description} = req.body;
        const newProduct = await pool.query(" UPDATE products SET tag_id=$1,name=$2,image=$3,brand=$4,price=$5,count_in_stock=$6,description=$7 WHERE id=$8",[tag_id,name,image,brand,price,count_in_stock,description,id]);
        res.json(newProduct);
    } catch (err) {
        console.error(err.message);
    }
})


//delete product
app.delete("/products/:id",async (req,res) => {
    try {
        const{id} = req.params;
        const deleteProduct = await pool.query("DELETE FROM products where id=$1",[id]);
        res.json(deleteProduct);
    } catch (err) {
        console.error(err.message);
    }
})
/*
// get products for 1 page + name
app.get("/products/:id/:name",async(req,res) => {
    try {
        console.log("name")

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
        console.log("no name")
        const{id} = req.params;
        const allProducts = await pool.query("SELECT * FROM products WHERE id>$1 LIMIT 9",[id]);
        res.json(allProducts.rows);
    } catch (err) {
        console.error(err.message)
    }
})

*/
// all products
app.get("/products/all",async(req,res) => {
    try {
        const allProducts = await pool.query("SELECT * FROM products");
        res.json(allProducts.rows);
    } catch (err) {
        console.error(err.message)
    }
})

//  all products filter by name
app.get("/products/all/:name",async(req,res) => {
    try {
        const{name} = req.params;
        const allProducts = await pool.query("SELECT * FROM products WHERE LOWER(name) LIKE concat('%',LOWER($1),'%')",[name]);
        res.json(allProducts.rows);
    } catch (err) {
        console.error(err.message)
    }
})


//  all products filter by tag
app.get("/products/tagsfilter/:tagid",async(req,res) => {
    try {
        const{tagid} = req.params;
        const allProducts = await pool.query("SELECT * FROM products WHERE tag_id=$1",[tagid]);
        res.json(allProducts.rows);
    } catch (err) {
        console.error(err.message)
    }
})


app.get("/products/all/:name/:tagid",async(req,res) => {
    try {
        const{name,tagid} = req.params;
        const allProducts = await pool.query("SELECT * FROM products WHERE LOWER(name) LIKE concat('%',LOWER($1),'%') AND tag_id=$2",[name,tagid]);
        res.json(allProducts.rows);
    } catch (err) {
        console.error(err.message)
    }
})


app.get("/products/all/:name/:tagid/:price",async(req,res) => {
    try {
        const{name,tagid,price} = req.params;
        if(price==0){
            const allProducts = await pool.query("SELECT * FROM products WHERE LOWER(name) LIKE concat('%',LOWER($1),'%') AND tag_id=$2",[name,tagid]);
            res.json(allProducts.rows);
        }
        else if(price==1){
            const allProducts = await pool.query("SELECT * FROM products WHERE LOWER(name) LIKE concat('%',LOWER($1),'%') AND tag_id=$2 AND price>=0 and price<=99",[name,tagid]);
            res.json(allProducts.rows);
        }
        else if(price==2){
            const allProducts = await pool.query("SELECT * FROM products WHERE LOWER(name) LIKE concat('%',LOWER($1),'%') AND tag_id=$2 AND price>=100 and price<=199",[name,tagid]);
            res.json(allProducts.rows);
        }
        else if(price==3){
            const allProducts = await pool.query("SELECT * FROM products WHERE LOWER(name) LIKE concat('%',LOWER($1),'%') AND tag_id=$2 AND price>=200 and price<=299",[name,tagid]);
            res.json(allProducts.rows);
        }
        else if(price==4){
            const allProducts = await pool.query("SELECT * FROM products WHERE LOWER(name) LIKE concat('%',LOWER($1),'%') AND tag_id=$2 AND price>=300",[name,tagid]);
            res.json(allProducts.rows);
        }
     
    } catch (err) {
        console.error(err.message)
    }
})


app.get("/products/np/:name/:price",async(req,res) => {
    try {
        const{name,price} = req.params;
        if(price==0){
            const allProducts = await pool.query("SELECT * FROM products WHERE LOWER(name) LIKE concat('%',LOWER($1),'%')",[name]);
            res.json(allProducts.rows);
        }
        else if(price==1){
            const allProducts = await pool.query("SELECT * FROM products WHERE LOWER(name) LIKE concat('%',LOWER($1),'%') AND price>=0 and price<=99",[name]);
            res.json(allProducts.rows);
        }
        else if(price==2){
            const allProducts = await pool.query("SELECT * FROM products WHERE LOWER(name) LIKE concat('%',LOWER($1),'%') AND price>=100 and price<=199",[name]);
            res.json(allProducts.rows);
        }
        else if(price==3){
            const allProducts = await pool.query("SELECT * FROM products WHERE LOWER(name) LIKE concat('%',LOWER($1),'%') AND price>=200 and price<=299",[name]);
            res.json(allProducts.rows);
        }
        else if(price==4){
            const allProducts = await pool.query("SELECT * FROM products WHERE LOWER(name) LIKE concat('%',LOWER($1),'%') AND price>=300",[name]);
            res.json(allProducts.rows);
        }
     
    } catch (err) {
        console.error(err.message)
    }
})


app.get("/products/tp/:tagid/:price",async(req,res) => {
    try {
       
        const{tagid,price} = req.params;
        if(price==0){
            const allProducts = await pool.query("SELECT * FROM products WHERE tag_id=$1",[tagid]);
            res.json(allProducts.rows);
        }
        else if(price==1){
            const allProducts = await pool.query("SELECT * FROM products WHERE tag_id=$1 AND price>=0 and price<=99",[tagid]);
            res.json(allProducts.rows);
        }
        else if(price==2){
            const allProducts = await pool.query("SELECT * FROM products WHERE tag_id=$1 AND price>=100 and price<=199",[tagid]);
            res.json(allProducts.rows);
        }
        else if(price==3){
            const allProducts = await pool.query("SELECT * FROM products WHERE tag_id=$1 AND price>=200 and price<=299",[tagid]);
            res.json(allProducts.rows);
        }
        else if(price==4){
            const allProducts = await pool.query("SELECT * FROM products WHERE tag_id=$1 AND price>=300",[tagid]);
            res.json(allProducts.rows);
        }
     
    } catch (err) {
        console.error(err.message)
    }
})


app.get("/products/p/:price",async(req,res) => {
    try {
        const{price} = req.params;
        if(price==0){
            const allProducts = await pool.query("SELECT * FROM products");
            res.json(allProducts.rows);
        }
        else if(price==1){
            const allProducts = await pool.query("SELECT * FROM products WHERE price>=0 and price<=99");
            res.json(allProducts.rows);
        }
        else if(price==2){
            const allProducts = await pool.query("SELECT * FROM products WHERE price>=100 and price<=199");
            res.json(allProducts.rows);
        }
        else if(price==3){
            const allProducts = await pool.query("SELECT * FROM products WHERE price>=200 and price<=299");
            res.json(allProducts.rows);
        }
        else if(price==4){
            const allProducts = await pool.query("SELECT * FROM products WHERE price>=300");
            res.json(allProducts.rows);
        }
     
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

//all product count+name
app.get("/products/:name",async(req,res) => {
    try {
        const{name} = req.params;
        const productCount = await pool.query("SELECT COUNT(*) FROM products WHERE LOWER(name) LIKE concat('%',LOWER($1),'%')",[name]);
        res.json(productCount.rows[0]);
    } catch (err) {
        console.error(err.message)
    }
})

//all product count+name
app.get("/products/:name/:tagid",async(req,res) => {
    try {
        const{name,tagid} = req.params;
        const productCount = await pool.query("SELECT COUNT(*) FROM products WHERE LOWER(name) LIKE concat('%',LOWER($1),'%') AND tag_id=$2",[name,tagid]);
        res.json(productCount.rows[0]);
    } catch (err) {
        console.error(err.message)
    }
})

// get a single product 
app.get("/product/:id", async (req, res) => {
    try {
        const{id} = req.params;
        const product = await pool.query("SELECT * FROM products WHERE id = $1",[id]);
        res.json(product.rows[0]);
    } catch (err) {
        console.error(err.message)
    }
})

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


//create user
app.post("/createuser",async (req,res) => {
    try {
        const {name,username,email,password} = req.body;
        const newUser = await pool.query(" INSERT INTO users (name,username,email,password) VALUES ($1,$2,$3,$4)",[name,username,email,password]);
        console.log(newUser);
        if(newUser){
            res.json({
                name: name,
                username: username,
                email: email,
                token: getToken(newUser),
            });
        }else{
            res.status(401).send({msg: 'Invalid User Data.'});
        }
        
    } catch (err) {
        console.error(err.message);
    }
})


//create user
app.post("/signin",async (req,res) => {
    try {
      
        const {email,password} = req.body;
        const signUser = await pool.query("SELECT * FROM users WHERE email=$1 AND password=$2",[email,password]);
        console.log()
        if(signUser.rowCount>0){
            res.json({
                name:signUser.rows[0].name,
                username:signUser.rows[0].username,
                email: signUser.rows[0].email,
                token: getToken(signUser),
            });
        }else{
            res.status(401).send({msg: 'Invalid Email or Password.'});
        }
    console.log(signUser)
    } catch (err) {
        console.error(err.message);
    }
})






app.listen(5000, ()=>{
 console.log("server has started");
});


// get all tags
app.get("/tags/all",async(req,res) => {
    try {
        const allTags = await pool.query("SELECT * FROM tags");
        res.json(allTags.rows);
    } catch (err) {
        console.error(err.message)
    }
})