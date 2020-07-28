const Pool = require("pg").Pool;

const pool = new Pool({
    user: "ekatte",
    password: "12345",
    host: "localhost",
    port: 5432,
    database: "onlineshop"
});

module.exports = pool;