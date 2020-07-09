const Pool = require("pg").Pool;

const pool = new Pool({
    user: "postgres",
    password: "aleksan99",
    host: "localhost",
    port: 5432,
    database: "onlineshop"
});

module.exports = pool;