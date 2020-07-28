const express = require('express');
const app = express();
const cors = require("cors");
const pool = require("./db");
const getToken = require("./util");
const fs = require('fs')
const request = require('request')

//for downloading images
const download = (url, path, callback) => {
    request.head(url, (err, res, body) => {
      request(url)
        .pipe(fs.createWriteStream(path))
        .on('close', callback)
    })
  }


//middleware
app.use(cors());
app.use(express.json());
app.use(express.static('public'))


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
        const {create_date,tag_id,name,image,brand,price,count_in_stock,description} = req.body;
        var tagarr = tag_id.split(",");
        const url = image;
        const path = `./public/${name}.png`;
        const newProduct = await pool.query(" INSERT INTO products (name,image,brand,price,count_in_stock,description,create_date) VALUES ($1,$2,$3,$4,$5,$6,$7)",[name,image,brand,price,count_in_stock,description,create_date]);
        productId = await pool.query(" SELECT id FROM products WHERE name=$1 ",[name])
        for(let i = 0; i< tagarr.length;i++){
            await pool.query("INSERT INTO tags_products (product_id,tag_id) VALUES($1,$2)",[productId.rows[0].id,tagarr[i]]);
        }
        res.json(newProduct);
        download(url, path, () => {
            console.log('✅ Done!')
          })
    } catch (err) {
        console.error(err.message);
    }
})

//update product
app.put("/products/:id",async (req,res) => {
    try {
        const {create_date,id,tag_id,name,image,brand,price,count_in_stock,description} = req.body;
        const url = image;
        const path = `./public/${name}.png`;
        var tagarr = tag_id.split(",");
        const newProduct = await pool.query(" UPDATE products SET name=$1,image=$2,brand=$3,price=$4,count_in_stock=$5,description=$6,edit_time=$7 WHERE id=$8",[name,image,brand,price,count_in_stock,description,create_date,id]);
        await pool.query(`DELETE from tags_products where tag_id NOT IN (${tag_id}) AND product_id=${id}`);
        
        for(let i = 0; i< tagarr.length;i++){
            await pool.query("INSERT INTO tags_products (product_id,tag_id) VALUES ($1,$2) ON CONFLICT ON CONSTRAINT tags_products_pkey DO NOTHING ",[id,tagarr[i]]);
        }
        res.json(newProduct);
        download(url, path, () => {
            console.log('✅ Done!')
          })
    } catch (err) {
        console.error(err.message);
    }
})


//delete product
app.delete("/products/:id",async (req,res) => {
    try {
        const{id} = req.params;
        const deleteProduct = await pool.query("UPDATE products SET count_in_stock=0 WHERE id = $1",[id]);
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
        const allProducts = await pool.query("SELECT DISTINCT products.id,name,image,brand,price,count_in_stock,description,create_date,edit_time FROM products join tags_products on products.id = tags_products.product_id where tags_products.tag_id = $1 ",[tagid]);
        res.json(allProducts.rows);
    } catch (err) {
        console.error(err.message)
    }
})


app.get("/products/all/:name/:tagid",async(req,res) => {
    try {
        const{name,tagid} = req.params;
        const allProducts = await pool.query("SELECT DISTINCT products.id,name,image,brand,price,count_in_stock,description,create_date,edit_time FROM products join tags_products on products.id = tags_products.product_id WHERE LOWER(name) LIKE concat('%',LOWER($1),'%') AND tags_products.tag_id = $2",[name,tagid]);
        res.json(allProducts.rows);
    } catch (err) {
        console.error(err.message)
    }
})


app.get("/products/all/:name/:tagid/:price",async(req,res) => {
    try {
        const{name,tagid,price} = req.params;
        var pricearr = price.split(",")
        price1 = pricearr[0];
        price2 = pricearr[1];
        const allProducts = await pool.query("SELECT DISTINCT products.id,name,image,brand,price,count_in_stock,description,create_date,edit_time FROM products join tags_products on products.id = tags_products.product_id WHERE LOWER(name) LIKE concat('%',LOWER($1),'%') AND tags_products.tag_id = $2 AND price>=$3 AND price<=$4",[name,tagid,price1,price2]);
        res.json(allProducts.rows);
    } catch (err) {
        console.error(err.message)
    }
})


app.get("/products/np/:name/:price",async(req,res) => {
    try {
        const{name,price} = req.params;
        var pricearr = price.split(",")
        price1 = pricearr[0];
        price2 = pricearr[1];
        const allProducts = await pool.query("SELECT * FROM products WHERE LOWER(name) LIKE concat('%',LOWER($1),'%') AND price>=$2 AND price<=$3",[name,price1,price2]);
        res.json(allProducts.rows);
    } catch (err) {
        console.error(err.message)
    }
})


app.get("/products/tp/:tagid/:price",async(req,res) => {
    try {
        const{tagid,price} = req.params;
        var pricearr = price.split(",")
        price1 = pricearr[0];
        price2 = pricearr[1];
        const allProducts = await pool.query("SELECT DISTINCT products.id,name,image,brand,price,count_in_stock,description,create_date,edit_time FROM products join tags_products on products.id = tags_products.product_id WHERE tags_products.tag_id = $1 AND price>=$2 AND price<=$3",[tagid,price1,price2]);
        res.json(allProducts.rows);
    } catch (err) {
        console.error(err.message)
    }
})


app.get("/products/p/:price",async(req,res) => {
    
    try {
        const{price} = req.params;
        var pricearr = price.split(",")
        price1 = pricearr[0];
        price2 = pricearr[1];
        const allProducts = await pool.query("SELECT * FROM products WHERE price>=$1 AND price<=$2",[price1,price2]);
        res.json(allProducts.rows);
    } catch (err) {
        console.error(err.message)
    }
})






app.get('/image/:name', function (req, res) {
    const{name} = req.params;
    const path = `./images/${name}.png`;
    res.sendFile(path);
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


//sign im user
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



// get all tags
app.get("/tags/all",async(req,res) => {
    try {
        const allTags = await pool.query("SELECT * FROM tags");
        res.json(allTags.rows);
    } catch (err) {
        console.error(err.message)
    }
})

app.get("/listPT",async(req,res) => {
    try {
        const allPT = await pool.query("select tags.id,name,tags_products.product_id from tags join tags_products on tags.id = tags_products.tag_id");
        res.json(allPT.rows);
    } catch (err) {
        console.error(err.message)
    }
})

//get all tags for product
app.get("/tags/:id",async(req,res) => {
    try {
        const{id} = req.params;
        console.log(id)

        const productTags = await pool.query("select name from tags join tags_products on tags.id = tags_products.tag_id where product_id = $1",[id]);
        res.json(productTags.rows);
    } catch (err) {
        console.error(err.message)
    }
})




app.listen(5000, ()=>{
 console.log("server has started");
});

