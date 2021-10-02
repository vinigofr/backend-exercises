const express = require('express');
const bodyParser = require('body-parser');

const drinks = [
  { id: 1, name: 'Refrigerante Lata', price: 5.0 },
  { id: 2, name: 'Refrigerante 600ml', price: 8.0 },
  { id: 3, name: 'Suco 300ml', price: 4.0 },
  { id: 4, name: 'Suco 1l', price: 10.0 },
  { id: 5, name: 'Cerveja Lata', price: 4.5 },
  { id: 6, name: 'Água Mineral 500 ml', price: 5.0 },
];

const recipes = [
  { id: 1, name: 'Lasanha', price: 40.0, waitTime: 30 },
  { id: 2, name: 'Macarrão a Bolonhesa', price: 35.0, waitTime: 25 },
  { id: 3, name: 'Macarrão com molho branco', price: 35.0, waitTime: 25 },
];

const app = express();

app.use(bodyParser.json());

// Para poder mandar dados será necessário o seguinte comando:
// fetch(`http://localhost:3000/recipes/`, {
//   method: 'POST',
//   headers: {
//     Accept: 'application/json',
//     'Content-Type': 'application/json',
//   },
//   body: JSON.stringify({
//     id: 4,
//     title: 'Macarrão com Frango',
//     price: 30
//   })
// });

// Diferente do que fizemos para fazer uma requisição do tipo GET , dessa vez passamos um segundo parâmetro que é um objeto formado pelos atributos method , headers , body . Vamos entender o que é cada um.
// method : Método HTTP utilizado, como vimos no primeiro bloco temos 4 que são mais utilizados (GET, POST, PUT e DELETE).
// headers : Define algumas informações sobre a requisição como o atributo Accept que diz qual o tipo de dado esperado como resposta dessa requisição e o Content-Type que sinaliza que no corpo da requisição está sendo enviado um JSON.
// body : É o corpo da requisição. Como no HTTP só é possível trafegar texto, é necessário transformar o objeto JavaScript que quermos enviar para uma string JSON. Por isso que do lado do nosso back-end precisamos utilizar o bodyParser para transformar as informações que foram trafegadas como string JSON, de volta para um objeto JavaScript.

app.post('/recipes', (req, res) => {
  const { id, name, price } = req.body;
  console.log(req.body);
  recipes.push({ id, name, price});
  res.status(201).json({ message: 'Recipe created successfully!'});
});

app.put('/recipes/:id', (req, res) => {
  const { id } = req.params;
  const { name, price } = req.body;
  console.log(req.body);

  const recipeIndex = recipes.findIndex((r) => r.id === Number(id));

  if (recipeIndex === -1) return res.status(404).json({message: 'not found'});
  
  recipes[recipeIndex] = { ...recipes[recipeIndex], name: name, price: price };
  res.status(204).end();
});

app.all('*',(req, res) => {
  return res.status(404).json({ message: `Rota ${ req.path } não existe!`})
})

app.delete('/recipes/:id', function (req, res) {
  const { id } = req.params;
  const recipeIndex = recipes.findIndex((r) => r.id === parseInt(id));

  if (recipeIndex === -1) return res.status(404).json({ message: 'Recipe not found!' });

  recipes.splice(recipeIndex, 1);

  res.status(204).end();
});

app.get('/recipes', (req, res) => {
  res.json(recipes);
});

app.get('/token', (req, res) => {
  const token = req.headers.authorization || '';
  console.log(token);

  if (token.length !== 16) return res.status(401).json({message: 'Invalid Token!'});

  res.status(200).json({message: 'Valid Token'});
});

app.listen('3000', () => {
  console.log('Servidor aberto: 3000');
})