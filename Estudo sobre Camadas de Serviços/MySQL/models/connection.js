const mysql = require('mysql2/promise');

const connection = mysql.createPool({
  user: 'vinicius',
  password: 'vinicius',
  host: 'localhost',
  database: 'model_example'
});

module.exports = connection;