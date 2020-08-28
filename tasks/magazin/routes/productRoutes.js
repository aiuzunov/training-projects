const express = require("express");
const router = express.Router();
const pool = require("../db");
const fs = require("fs");
const request = require("request");
const Authenticated = require("../util2");

function clean(obj) {
for (var propName in obj) {
if (obj[propName] === null || obj[propName]=='' || obj[propName] === undefined) {
  delete obj[propName];
}
}
}

const download = (url, path, callback) => {
  request.head(url, (err, res, body) => {
    request(url).pipe(fs.createWriteStream(path)).on("close", callback);
  });
};

router.get("/:search/:tagid/:price", async (req, res) => {
  try {
    const { search, tagid, price } = req.params;
    var pricearr = price.split(",");
    price1 = pricearr[0];
    price2 = pricearr[1];
    const productCount = await pool.query(
      "SELECT COUNT(*) FROM products join tags_products on tags_products.product_id = products.id WHERE LOWER(name) LIKE concat('%',LOWER($1),'%') AND tags_products.tag_id=$2 AND price>=$3 AND price<=$4 ",
      [search, tagid, price1, price2]
    );
    res.json(productCount.rows[0]);
  } catch (err) {
    console.error(err.message);
  }
});

router.post("/testingfilters", async (req, res) => {
  try {
    const Filters = req.body;
    console.log(Filters)
    var testfilters = Filters.productFilters;
    const indexOfLastPost = Filters.currentPage * 9;
    const indexOfFirstPost = indexOfLastPost - 9;
    console.log(Filters)
    console.log(indexOfFirstPost,indexOfLastPost)
    var testArray= [];
    if(testfilters.name!=''){
      var i=2;
      testArray.push(testfilters.name);
      var query = "SELECT DISTINCT t.id,name,image,brand,price,count_in_stock,description,create_date,edit_time,currency_id from (SELECT *, count(*) OVER (ORDER BY id ) ROWNUM FROM products where LOWER(name) LIKE concat('%',LOWER($1),'%')";
    }else{
      var i=1;
      var query = "SELECT DISTINCT t.id,name,image,brand,price,count_in_stock,description,create_date,edit_time,currency_id from (SELECT *, count(*) OVER (ORDER BY id ) ROWNUM FROM products WHERE 1=1";
    }

const entries = Object.entries(testfilters);

for (const [key, value] of entries) {
  if(key!='filter'&&value!=''&&key!='price'&&key!='name'&&key!='tagid'&&key!='age'&&key!='count_in_stock'){
    if(key=='fromDate'){
      query = query + ` AND create_date>=$${i}`
      i++;
      testArray.push(testfilters.fromDate);

    }
    else if(key=='toDate'){
      testArray.push(testfilters.toDate);
      query = query + ` AND create_date<=$${i}`
      i++;
    }
    else{
    query = query + ` AND ${key}=$${i}`;
    testArray.push(value)
    i++;
  }
  }

}
  query += ` AND price>=$${i} AND price<=$${i+1}`
  if(testfilters.count_in_stock){
    switch(testfilters.count_in_stock){
      case 1:
        query+=' and count_in_stock=0'
        break;
      case 2:
        query+=' and count_in_stock=1'
        break;
      case 3:
        query+=' and count_in_stock>1'
        break;
    }
  }
  if(testfilters.age){
    switch(testfilters.age){
      case 'ASC':
        query+=' ORDER BY create_date ASC'
        break;
      case 'DESC':
        query+=' ORDER BY create_date DESC'
        break;
    }
  }
  testArray.push(testfilters.price[0])
  testArray.push(testfilters.price[1])


  if(testfilters.tagid.length==0){
    testArray.push(indexOfFirstPost)
    testArray.push(indexOfLastPost)
    query+=`) as t join tags_products on t.id = tags_products.product_id where rownum>$${i+2} and rownum <= $${i+3}`
  }else{
    testArray.push(testfilters.tagid)
    testArray.push(indexOfFirstPost)
    testArray.push(indexOfLastPost)
    query+=`) as t join tags_products on t.id = tags_products.product_id where tags_products.tag_id = ANY($${i+2}) AND rownum>$${i+3} and rownum <= $${i+4}`

  }
  if(testfilters.age){
    switch(testfilters.age){
      case 'ASC':
        query+=' ORDER BY create_date ASC'
        break;
      case 'DESC':
        query+=' ORDER BY create_date DESC'
        break;
    }
  }
  console.log("This is the query:",query)


  var test = await pool.query(query,testArray)
    console.log(test.rows)
    res.json(test.rows);
  } catch (err) {
    console.log(err)
    res
      .status(500)
      .send({ msg: "Възникна грешка при визуализирането на продуктите ." });
  }
});


router.post("/productCount", async (req, res) => {
  try {
    const testfilters = req.body;

    if(testfilters.nofilters){
      console.log(1)
      const productCount = await pool.query("SELECT COUNT(*) FROM products WHERE price>=0 and price<=100");
      res.json(productCount.rows[0]);
    }else{
    console.log(2)
    var testArray= [];
    if(testfilters.name!=''){
      var i=2;
      testArray.push(testfilters.name);
      var query = "SELECT MAX(rownum) from (SELECT *, count(*) OVER (ORDER BY id ) ROWNUM FROM products where LOWER(name) LIKE concat('%',LOWER($1),'%')";
    }else{
      var i=1;
      var query = "SELECT MAX(rownum) from (SELECT *, count(*) OVER (ORDER BY id ) ROWNUM FROM products WHERE 1=1";
    }

const entries = Object.entries(testfilters);

for (const [key, value] of entries) {
  if(key!='filter'&&value!=''&&key!='price'&&key!='name'&&key!='tagid'&&key!='age'&&key!='count_in_stock'){
    if(key=='fromDate'){
      query = query + ` AND create_date>=$${i}`
      i++;
      testArray.push(testfilters.fromDate);

    }
    else if(key=='toDate'){
      testArray.push(testfilters.toDate);
      query = query + ` AND create_date<=$${i}`
      i++;
    }
    else{
    query = query + ` AND ${key}=$${i}`;
    testArray.push(value)
    i++;
  }
  }

}
  query += ` AND price>=$${i} AND price<=$${i+1}`
  if(testfilters.count_in_stock){
    switch(testfilters.count_in_stock){
      case 1:
        query+=' and count_in_stock=0'
        break;
      case 2:
        query+=' and count_in_stock=1'
        break;
      case 3:
        query+=' and count_in_stock>1'
        break;
    }
  }
  if(testfilters.age){
    switch(testfilters.age){
      case 'ASC':
        query+=' ORDER BY create_date ASC'
        break;
      case 'DESC':
        query+=' ORDER BY create_date DESC'
        break;
    }
  }
  testArray.push(testfilters.price[0])
  testArray.push(testfilters.price[1])


  if(testfilters.tagid.length==0){
    query+=`) as t join tags_products on t.id = tags_products.product_id`
  }else{
    testArray.push(testfilters.tagid)
    query+=`) as t join tags_products on t.id = tags_products.product_id where tags_products.tag_id = ANY($${i+2})`

  }

  console.log(query)
  var test = await pool.query(query,testArray)
    console.log("This is the product count",test.rows)
    res.json(test.rows[0]);
  }
  } catch (err) {
    console.log(err)
    res
      .status(500)
      .send({ msg: "Възникна грешка при визуализирането на продуктите ." });
  }
});




router.put("/update/:id", Authenticated, async (req, res) => {
  try {
    const {
      create_date,
      id,
      submitTags,
      name,
      image,
      brand,
      price,
      count_in_stock,
      description,
    } = req.body;
    const url = image;
    const path = `./public/${name}.png`;
    var tagarr = submitTags.split(",");
    const newProduct = await pool.query(
      " UPDATE products SET name=$1,image=$2,brand=$3,price=$4,count_in_stock=$5,description=$6,edit_time=$7 WHERE id=$8",
      [name, image, brand, price, count_in_stock, description, create_date, id]
    );
    await pool.query(
      `DELETE from tags_products where tag_id NOT IN (${submitTags}) AND product_id=${id}`
    );

    for (let i = 0; i < tagarr.length; i++) {
      await pool.query(
        "INSERT INTO tags_products (product_id,tag_id) VALUES ($1,$2) ON CONFLICT ON CONSTRAINT tags_products_pkey DO NOTHING ",
        [id, tagarr[i]]
      );
    }
    res.json(newProduct);
    download(url, path, () => {
      console.log("✅ Done!");
    });
  } catch (err) {
    res
      .status(500)
      .send({ msg: "Възникна грешка при актуализирането на продуктa ." });
  }
});

router.post("/create", Authenticated, async (req, res) => {
  try {
    const {
      create_date,
      submitTags,
      name,
      image,
      brand,
      price,
      count_in_stock,
      description,
    } = req.body;
    var tagarr = submitTags.split(",");
    const url = image;
    const path = `./public/${name}.png`;
    const newProduct = await pool.query(
      " INSERT INTO products (name,image,brand,price,count_in_stock,description,create_date) VALUES ($1,$2,$3,$4,$5,$6,$7)",
      [name, image, brand, price, count_in_stock, description, create_date]
    );
    productId = await pool.query(" SELECT id FROM products WHERE name=$1 ", [
      name,
    ]);
    for (let i = 0; i < tagarr.length; i++) {
      await pool.query(
        "INSERT INTO tags_products (product_id,tag_id) VALUES($1,$2)",
        [productId.rows[0].id, tagarr[i]]
      );
    }
    res.json(newProduct);
    download(url, path, () => {
      console.log("Image Downloaded Successfuly!");
    });
  } catch (err) {
    console.log(err.message)
    res
      .status(500)
      .send({ msg: "Възникна грешка при създаването на продукта ." });
  }
});

router.get("/get/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const product = await pool.query("SELECT * FROM products WHERE id = $1", [
      id,
    ]);
    res.json(product.rows[0]);
  } catch (err) {
    res
      .status(500)
      .send({ msg: "Възникна грешка при визуализирането на продуктите ." });
  }
});

router.delete("/delete/:id", Authenticated, async (req, res) => {
  try {
    const { id } = req.params;
    const deleteProduct = await pool.query(
      "UPDATE products SET count_in_stock=0 WHERE id = $1",
      [id]
    );
    res.json(deleteProduct);
  } catch (err) {
    res
      .status(500)
      .send({ msg: "Възникна грешка при визуализирането на продуктите ." });
  }
});


module.exports = router;
