/* recipes.js */
const express = require('express');
const app = express();

const recipes = [
  { id: 1, name: 'Lasanha', price: 40.0, waitTime: 30 },
  { id: 2, name: 'Macarrão a Bolonhesa', price: 35.0, waitTime: 25 },
  { id: 3, name: 'Macarrão com molho branco', price: 35.0, waitTime: 25 },
];

app.get('/recipes', function (req, res) {
  res.json(recipes);
});

app.post('/vinicius/:id',(req, res) => {
  res.json({"vinicius": `${req.params.id}`});

});

app.listen(3001, () => {
  console.log('Aplicação ouvindo na porta 3001');
});

// Agora, deixamos de usar o método .send para usar o método .json . O método .send é um método que consegue retornar a resposta de uma requisição de uma forma genérica, adaptando o tipo do retorno ao que vai ser retornado. Mas para deixar mais evidente que o que vamos devolver é um JSON usamos o método .json .