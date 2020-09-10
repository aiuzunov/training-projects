const express = require("express");
const router = express.Router();
const pool = require("../db");
const fs = require("fs");
const request = require("request");
const Authenticated = require("../util2");
const Cursor = require('pg-cursor')
const QueryStream = require('pg-query-stream')
const JSONStream = require('JSONStream')



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

router.post("/getProducts", async (req, res) => {
  try {
    const Filters = req.body;
    var testfilters = Filters;
    if(testfilters.employeeInfo){
    var auth = await pool.query("select employees.name,employees.username,employees.email,roles.name as role,array_agg(permissions.name) from employees join roles on employees.role_id = roles.id join roles_perms on roles_perms.role_id = roles.id join permissions on permissions.id = roles_perms.perm_id where employees.name = $1 GROUP BY employees.name,employees.username,employees.email,roles.name",[testfilters.employeeInfo.name])
    console.log(auth.rows)
    if(auth.rows[0].array_agg.includes("Продукти")){
    const indexOfLastPost = Filters.currentPage * 9;
    const indexOfFirstPost = indexOfLastPost - 9;
    var testArray= [];
    var query = 'SELECT DISTINCT t.id,name,image,brand,price,count_in_stock,description,create_date,edit_time,currency_id from (SELECT *, count(*) OVER ';
    if(testfilters.ageFilter){
      switch(testfilters.ageFilter){
        case 'ASC':
          query+='(ORDER BY create_date ASC, id)'
          break;
        case 'DESC':
          query+='(ORDER BY create_date DESC, id DESC)'
          break;
      }
    }else{
      query+=`(ORDER BY id)`
    }
    if(testfilters.searchfilter!=''){
      var i=2;
      testArray.push(testfilters.searchfilter);
       query += " ROWNUM FROM products where LOWER(name) LIKE concat('%',LOWER($1),'%')";
    }else{
      var i=1;
       query += " ROWNUM FROM products WHERE 1=1";
    }

const entries = Object.entries(testfilters);
for (const [key, value] of entries) {
  if(key!='filter'&&value!=''&&key!='employeeInfo'&&key!='pricefilter'&&key!='searchfilter'&&key!='tagfilter'&&key!='ageFilter'&&key!='cisFilter'&&key!='currentPage'){
    if(key=='from'){
      query = query + ` AND DATE(create_date)>=$${i}`
      i++;
      testArray.push(testfilters.from);

    }
    else if(key=='to'){
      testArray.push(testfilters.to);
      query = query + ` AND DATE(create_date)<=$${i}`
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
  testArray.push(testfilters.pricefilter[0])
  testArray.push(testfilters.pricefilter[1])
  if(testfilters.cisFilter){
    switch(testfilters.cisFilter){
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
  if(testfilters.tagfilter.length==0){
    testArray.push(indexOfFirstPost)
    testArray.push(indexOfLastPost)
    query+=`) as t join tags_products on t.id = tags_products.product_id where rownum>$${i+2} and rownum <= $${i+3}`
  }else{
    testArray.push(testfilters.tagfilter)
    testArray.push(indexOfFirstPost)
    testArray.push(indexOfLastPost)
    query+=`) as t join tags_products on t.id = tags_products.product_id where tags_products.tag_id = ANY ($${i+2}) AND rownum>$${i+3} and rownum <= $${i+4}`

  }
  if(testfilters.ageFilter){
        switch(testfilters.ageFilter){
          case 'ASC':
            query+=' ORDER BY create_date ASC'
            break;
          case 'DESC':
            query+=' ORDER BY create_date DESC, id DESC'
            break;
        }
      }
      pool.connect((err, client, done) => {
     if (err) throw err;
     const data = new QueryStream(query,testArray)
     const stream = client.query(data)
     stream.on('end', done)
     stream.pipe(JSONStream.stringify()).pipe(res)
   })
 }else{
   res
     .status(500)
     .send({ msg: "Нямате права да виждате продуктите ." });
 }}
 else{
   const Filters = req.body;
   var testfilters = Filters;
   const indexOfLastPost = Filters.currentPage * 9;
   const indexOfFirstPost = indexOfLastPost - 9;
   var testArray= [];
   var query = 'SELECT DISTINCT t.id,name,image,brand,price,count_in_stock,description,create_date,edit_time,currency_id from (SELECT *, count(*) OVER ';
   if(testfilters.ageFilter){
     switch(testfilters.ageFilter){
       case 'ASC':
         query+='(ORDER BY create_date ASC, id)'
         break;
       case 'DESC':
         query+='(ORDER BY create_date DESC, id DESC)'
         break;
     }
   }else{
     query+=`(ORDER BY id)`
   }
   if(testfilters.searchfilter!=''){
     var i=2;
     testArray.push(testfilters.searchfilter);
      query += " ROWNUM FROM products where LOWER(name) LIKE concat('%',LOWER($1),'%')";
   }else{
     var i=1;
      query += " ROWNUM FROM products WHERE 1=1";
   }

const entries = Object.entries(testfilters);
for (const [key, value] of entries) {
 if(key!='filter'&&value!=''&&key!='employeeInfo'&&key!='pricefilter'&&key!='searchfilter'&&key!='tagfilter'&&key!='ageFilter'&&key!='cisFilter'&&key!='currentPage'){
   if(key=='from'){
     query = query + ` AND DATE(create_date)>=$${i}`
     i++;
     testArray.push(testfilters.from);

   }
   else if(key=='to'){
     testArray.push(testfilters.to);
     query = query + ` AND DATE(create_date)<=$${i}`
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
 testArray.push(testfilters.pricefilter[0])
 testArray.push(testfilters.pricefilter[1])
 if(testfilters.cisFilter){
   switch(testfilters.cisFilter){
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
 if(testfilters.tagfilter.length==0){
   testArray.push(indexOfFirstPost)
   testArray.push(indexOfLastPost)
   query+=`) as t join tags_products on t.id = tags_products.product_id where rownum>$${i+2} and rownum <= $${i+3}`
 }else{
   testArray.push(testfilters.tagfilter)
   testArray.push(indexOfFirstPost)
   testArray.push(indexOfLastPost)
   query+=`) as t join tags_products on t.id = tags_products.product_id where tags_products.tag_id = ANY ($${i+2}) AND rownum>$${i+3} and rownum <= $${i+4}`

 }
 if(testfilters.ageFilter){
       switch(testfilters.ageFilter){
         case 'ASC':
           query+=' ORDER BY create_date ASC'
           break;
         case 'DESC':
           query+=' ORDER BY create_date DESC, id DESC'
           break;
       }
     }
     pool.connect((err, client, done) => {
    if (err) throw err;
    const data = new QueryStream(query,testArray)
    const stream = client.query(data)
    stream.on('end', done)
    stream.pipe(JSONStream.stringify()).pipe(res)
  })
 }
  } catch (err) {
    console.log(err)
    res
      .status(500)
      .send({ msg: "Възникна грешка при визуализирането на продуктите ." });
  }
});


router.post("/getProductCount", async (req, res) => {
  try {
    const testfilters = req.body;
    var testArray= [];
    if(testfilters.employeesInfo){

    var auth = await pool.query("select employees.name,employees.username,employees.email,roles.name as role,array_agg(permissions.name) from employees join roles on employees.role_id = roles.id join roles_perms on roles_perms.role_id = roles.id join permissions on permissions.id = roles_perms.perm_id where employees.name = $1 GROUP BY employees.name,employees.username,employees.email,roles.name",[testfilters.employeeInfo.name])
    console.log(auth.rows)
    if(auth.rows[0].array_agg.includes("Продукти")){
    var query = 'SELECT MAX(ROWNUM) from (SELECT *, count(*) OVER ';
    if(testfilters.ageFilter){
      switch(testfilters.ageFilter){
        case 'ASC':
          query+='(ORDER BY create_date ASC, id)'
          break;
        case 'DESC':
          query+='(ORDER BY create_date DESC, id DESC)'
          break;
      }
    }
    else{
      query+='(ORDER BY id)'
    }
    if(testfilters.searchfilter!=''){
      var i=2;
      testArray.push(testfilters.searchfilter);
       query += " ROWNUM FROM products where LOWER(name) LIKE concat('%',LOWER($1),'%')";
    }else{
      var i=1;
       query += " ROWNUM FROM products WHERE 1=1";
    }
const entries = Object.entries(testfilters);

for (const [key, value] of entries) {
  if(key!='filter'&&value!=''&&key!='employeeInfo'&&key!='pricefilter'&&key!='searchfilter'&&key!='tagfilter'&&key!='ageFilter'&&key!='cisFilter'){
    if(key=='from'){
      query = query + ` AND DATE(create_date)>=$${i}`
      i++;
      testArray.push(testfilters.from);

    }
    else if(key=='to'){
      testArray.push(testfilters.to);
      query = query + ` AND DATE(create_date)<=$${i}`
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
  if(testfilters.cisFilter){
    switch(testfilters.cisFilter){
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
  if(testfilters.ageFilter){
    switch(testfilters.ageFilter){
      case 'ASC':
        query+=' ORDER BY create_date ASC'
        break;
      case 'DESC':
        query+=' ORDER BY create_date DESC'
        break;
    }
  }
  testArray.push(testfilters.pricefilter[0])
  testArray.push(testfilters.pricefilter[1])


  if(testfilters.tagfilter.length==0){
    query+=`) as t join tags_products on t.id = tags_products.product_id`
  }else{
    testArray.push(testfilters.tagfilter)
    query+=`) as t join tags_products on t.id = tags_products.product_id where tags_products.tag_id = ANY ($${i+2})`

  }
  console.log(query)
  var test = await pool.query(query,testArray)
    res.json(test.rows[0]);
  }

}
else{

      var query = 'SELECT MAX(ROWNUM) from (SELECT *, count(*) OVER ';
      if(testfilters.ageFilter){
        switch(testfilters.ageFilter){
          case 'ASC':
            query+='(ORDER BY create_date ASC, id)'
            break;
          case 'DESC':
            query+='(ORDER BY create_date DESC, id DESC)'
            break;
        }
      }
      else{
        query+='(ORDER BY id)'
      }
      if(testfilters.searchfilter!=''){
        var i=2;
        testArray.push(testfilters.searchfilter);
         query += " ROWNUM FROM products where LOWER(name) LIKE concat('%',LOWER($1),'%')";
      }else{
        var i=1;
         query += " ROWNUM FROM products WHERE 1=1";
      }
  const entries = Object.entries(testfilters);

  for (const [key, value] of entries) {
    if(key!='filter'&&value!=''&&key!='employeeInfo'&&key!='pricefilter'&&key!='searchfilter'&&key!='tagfilter'&&key!='ageFilter'&&key!='cisFilter'){
      if(key=='from'){
        query = query + ` AND DATE(create_date)>=$${i}`
        i++;
        testArray.push(testfilters.from);

      }
      else if(key=='to'){
        testArray.push(testfilters.to);
        query = query + ` AND DATE(create_date)<=$${i}`
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
    if(testfilters.cisFilter){
      switch(testfilters.cisFilter){
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
    if(testfilters.ageFilter){
      switch(testfilters.ageFilter){
        case 'ASC':
          query+=' ORDER BY create_date ASC'
          break;
        case 'DESC':
          query+=' ORDER BY create_date DESC'
          break;
      }
    }
    testArray.push(testfilters.pricefilter[0])
    testArray.push(testfilters.pricefilter[1])


    if(testfilters.tagfilter.length==0){
      query+=`) as t join tags_products on t.id = tags_products.product_id`
    }else{
      testArray.push(testfilters.tagfilter)
      query+=`) as t join tags_products on t.id = tags_products.product_id where tags_products.tag_id = ANY ($${i+2})`

    }
    console.log(query)
    var test = await pool.query(query,testArray)
      res.json(test.rows[0]);
}
  } catch (err) {
    console.log("max error",err)
    res
      .status(500)
      .send({ msg: "Възникна грешка при визуализирането на продуктите ." });
  }
});




router.put("/update", Authenticated, async (req, res) => {
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

router.get("/get", async (req, res) => {
  try {
    const id = req.query.id;
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

router.delete("/delete",Authenticated, async (req, res) => {
  try {
    const id = req.query.id;
    const deleteProduct = await pool.query(
      "UPDATE products SET count_in_stock=0 WHERE id = $1",
      [id]
    );
    res.json(deleteProduct);
  } catch (err) {
    res
      .status(500)
      .send({ msg: "Възникна грешка при изтриването на продукта ." });
  }
});


module.exports = router;
