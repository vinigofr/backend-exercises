// Importante fazer a exportação do módulo Router do express, para posteriormente, exportálo ao index.js
const router = require('express').Router();

// Aqui, importamos o cepController. Lá, serão feitas as
// requisições, a partir da camada CONTROLLER > SERVICE
const cepController = require('../controllers/cepController');

// Rota GET que busca CEP por um parâmetro CEP. 
router.get('/cep/:cep', cepController.getByCep);

module.exports = router;
