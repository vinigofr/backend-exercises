// O pacote express-rescue está disponível no npm e nos ajuda com a tarefa de garantir que os erros sempre sejam tratados.

// Para adicionarmos os express-rescue , basta passarmos o nosso middleware como parâmetro para a função rescue que importamos do módulo. Essa função vai gerar um novo middleware que vai fazer o tratameto de erros da middleware sem precisarmos escrever o try/catch.

/* errorHandlerExample.js */
const express = require('express');
const rescue = require('express-rescue');
const fs = require('fs/promises');

const app = express();

app.get(
  '/:fileName',
  rescue(async (req, res) => {
    const file = await fs.readFile(`./${req.params.fileName}`);
    res.send(file.toString('utf-8'));
  })
);

app.use((err, req, res, next) => {
  res.status(500).json({ error: `Erro: ${err.message}` });
});

app.listen(3002, () => {
  console.log('rodando em 3002')
});

// Exemplo de middleware genérico para tratamento de erro:
module.exports = (err, req, res, next) => {
  if (err.code && err.status) {
    return res.status(err.status).json({ message: err.message, code: err.code });
  }

  return res.status(500).json({ message: err.message });
}