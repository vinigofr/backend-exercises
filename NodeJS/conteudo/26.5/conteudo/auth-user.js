const express = require('express');
const bodyParser = require('body-parser');
const authMiddleware = require('./auth-middleware');


const app = express();
app.use(bodyParser.json());

// Observe que adicionamos uma rota, antes do app.use. Aqui é importante destacar que o app.use só afeta as rotas que vem abaixo da sua definição. Ou seja, todas as rotas do nosso CRUD de receitas vão passar pelo middleware de autenticação, enquanto a rota /aberto não, por que foi definida antes da linha do app.use. Vamos testar: Tente fazer uma requisição para as rotas GET /aberto e GET /recipes.

app.use(authMiddleware);
// Esta rota não passa pelo middleware de autenticação!
app.get('/open', function (req, res) {
  res.send('open!')
});

const recipesRouter = require('./router');

app.use('/recipes', recipesRouter);
app.listen(3000);


// Repare no uso de mais um parâmetro na chamada à função app.use. Isso diz ao Express que queremos que aquele middleware (no caso o router) seja executado para qualquer rota que comece com aquele caminho. Repare que, ao registrar uma rota no router, não precisamos repetir a parte do caminho que já passamos para app.use. É por isso que a rota que definimos com router.get('/:id') na verdade se torna acessível através de /recipes/:id.

// Routers suportam que qualquer tipo de middleware seja registrado. Ou seja, se tivermos vários endpoints com autenticação e vários endpoints abertos, podemos criar um router, e registrar nele nosso middleware de autenticação, bem como todas as rotas que precisam ser autenticadas, registrando as rotas abertas diretamente no app. Veja abaixo:

