// Tratando erros com um middleware de erro

// A diferença dos outros para este, é que ele recebe como primeiro parâmetro o error, logo em seguida dos req, res e next.

// Ex:
function example(err, req, res, next) {};

// Exemplo de uso dos middlewares de erro com a função next()

app.use(function logErrors(err, _req, _res, next) {
  console.error(err.stack);
  /* passa o erro para o próximo middleware */
  next(err);
});

// Repare que estamos fazendo next(err) na linha 4. Isso diz ao Express que ele não deve continuar executando nenhum middleware ou rota que não seja de erro. Ou seja, quando passamos qualquer parâmetro para o next, o Express entende que é um erro e deixa de executar middlewares comuns, passando a execução para o próximo middleware de erro registrado para aquela rota, router ou aplicação.

app.use(function (err, _req, res, _next) {
  res.status(500);
  res.json({ error: err });
});

// Exemplo de trattamento de erro com next(err);
// ⚠️ Atenção ⚠️: Jamais devemos realizar a leitura de um arquivo do sistema de arquivos dessa forma. Concatenar parâmetros recebidos do usuário diretamente na chamada para qualquer método representa uma falha gigantesca de segurança. Vamos fazer isso aqui nesse momento para fins didáticos. Repetindo: não tente isso em casa em produção!

/* errorHandlerExample.js */
const express = require('express');
const fs = require('fs/promises');

const app = express();

app.get('/:fileName', async (req, res, next) => {
    try {
        const file = await fs.readFile(`./${req.params.fileName}`);
        res.send(file.toString('utf-8'));
    } catch (e) {
        next(e); 
    }
});

app.use(function (err, req, res, next) { 
  res.status(500).json({ error: `Erro: ${err.message}` });
});

app.listen(3002);


