const express = require('express');
const router = express.Router();
const pool = require("../db");
const fs = require('fs')
const request = require('request')
const Authenticated = require("../util2");



const download = (url, path, callback) => {
    request.head(url, (err, res, body) => {
      request(url)
        .pipe(fs.createWriteStream(path))
        .on('close', callback)
    })
  }



//  all products filter by tag
router.get("/tagsfilter/:tagid",async(req,res) => {
    try {
        const{tagid} = req.params;
        const allProducts = await pool.query("SELECT DISTINCT products.id,name,image,brand,price,count_in_stock,description,create_date,edit_time FROM products join tags_products on products.id = tags_products.product_id where tags_products.tag_id = $1 ",[tagid]);
        res.json(allProducts.rows);
    } catch (err) {
        res.status(500).send({msg: 'Възникна грешка при визуализирането на продуктите .'});
    }
})

router.get("/all/:name",async(req,res) => {
    try {
        const{name} = req.params;
        const allProducts = await pool.query("SELECT * FROM products WHERE LOWER(name) LIKE concat('%',LOWER($1),'%')",[name]);
        res.json(allProducts.rows);
    } catch (err) {
        res.status(500).send({msg: 'Възникна грешка при визуализирането на продуктите .'});
    }
})

router.get("/p/:price",async(req,res) => {
    
    try {
        const{price} = req.params;
        var pricearr = price.split(",")
        price1 = pricearr[0];
        price2 = pricearr[1];
        const allProducts = await pool.query("SELECT * FROM products WHERE price>=$1 AND price<=$2",[price1,price2]);
        res.json(allProducts.rows);
    } catch (err) {
        res.status(500).send({msg: 'Възникна грешка при визуализирането на продуктите .'});
    }
})


router.get("/tp/:tagid/:price",async(req,res) => {
    try {
        const{tagid,price} = req.params;
        var pricearr = price.split(",")
        price1 = pricearr[0];
        price2 = pricearr[1];
        const allProducts = await pool.query("SELECT DISTINCT products.id,name,image,brand,price,count_in_stock,description,create_date,edit_time FROM products join tags_products on products.id = tags_products.product_id WHERE tags_products.tag_id = $1 AND price>=$2 AND price<=$3",[tagid,price1,price2]);
        res.json(allProducts.rows);
    } catch (err) {
        res.status(500).send({msg: 'Възникна грешка при визуализирането на продуктите .'});
    }
})


router.get("/np/:name/:price",async(req,res) => {
    try {
        const{name,price} = req.params;
        var pricearr = price.split(",")
        price1 = pricearr[0];
        price2 = pricearr[1];
        const allProducts = await pool.query("SELECT * FROM products WHERE LOWER(name) LIKE concat('%',LOWER($1),'%') AND price>=$2 AND price<=$3",[name,price1,price2]);
        res.json(allProducts.rows);
    } catch (err) {
        res.status(500).send({msg: 'Възникна грешка при визуализирането на продуктите .'});
    }
})




router.get("/all/:name/:tagid",async(req,res) => {
    try {
        const{name,tagid} = req.params;
        const allProducts = await pool.query("SELECT DISTINCT products.id,name,image,brand,price,count_in_stock,description,create_date,edit_time FROM products join tags_products on products.id = tags_products.product_id WHERE LOWER(name) LIKE concat('%',LOWER($1),'%') AND tags_products.tag_id = $2",[name,tagid]);
        res.json(allProducts.rows);
    } catch (err) {
        res.status(500).send({msg: 'Възникна грешка при визуализирането на продуктите .'});
    }
})


router.get("/all/:name/:tagid/:price",async(req,res) => {
    try {
        const{name,tagid,price} = req.params;
        var pricearr = price.split(",")
        price1 = pricearr[0];
        price2 = pricearr[1];
        const allProducts = await pool.query("SELECT DISTINCT products.id,name,image,brand,price,count_in_stock,description,create_date,edit_time FROM products join tags_products on products.id = tags_products.product_id WHERE LOWER(name) LIKE concat('%',LOWER($1),'%') AND tags_products.tag_id = $2 AND price>=$3 AND price<=$4",[name,tagid,price1,price2]);
        res.json(allProducts.rows);
    } catch (err) {
        res.status(500).send({msg: 'Възникна грешка при визуализирането на продуктите .'});
    }
})

router.put("/update/:id",Authenticated,async (req,res) => {
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
        res.status(500).send({msg: 'Възникна грешка при визуализирането на продуктите .'});
    }
})


router.post("/create",Authenticated, async (req,res) => {
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
            console.log('Image Downloaded Successfuly!')
          })
    } catch (err) {
        res.status(500).send({msg: 'Възникна грешка при визуализирането на продуктите .'});
    }
})

router.get("/:id", async (req, res) => {
    try {
        const{id} = req.params;
        const product = await pool.query("SELECT * FROM products WHERE id = $1",[id]);
        res.json(product.rows[0]);
    } catch (err) {
        res.status(500).send({msg: 'Възникна грешка при визуализирането на продуктите .'});
    }
})

router.delete("/delete/:id",Authenticated,async (req,res) => {
    try {
        const{id} = req.params;
        const deleteProduct = await pool.query("UPDATE products SET count_in_stock=0 WHERE id = $1",[id]);
        res.json(deleteProduct);
    } catch (err) {
        res.status(500).send({msg: 'Възникна грешка при визуализирането на продуктите .'});
    }
})







module.exports = router;