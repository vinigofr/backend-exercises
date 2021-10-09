const mysql = require('mysql2/promise');

// Configuração de conexão ao MySQL com o DB 'cep_lookup'
const connection = mysql.createPool({
  user: 'vinicius',
  password: 'vinicius',
  host: 'localhost',
  database: 'cep_lookup'
});
module.exports = connection;
