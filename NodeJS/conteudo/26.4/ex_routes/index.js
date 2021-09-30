const express = require('express');

const app = express();

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

app.get('/drinks', (req, res) => {
  res.json(drinks);
});

app.get('/drinks/:id', (req, res) => {
  const { id } = req.params;
  const result = drinks.find((d) => d.id === Number(id));

  if (!result) return res.status(404).json({ message: '404'});

  res.status(200).json(result);
});

// Com query string
// http://localhost:3000/recipes/search?name=Macarr%C3%A3o&minPrice=35
// Utilizamos & para AND
app.get('/recipes/search', (req, res) => {
  const { name, minPrice } = req.query;
  
  console.log(name, minPrice);
  const filtereds = recipes.filter((r) => r.name.includes(name) && r.price >= parseInt(minPrice));

  res.status(200).json(filtereds);

});
app.get('/recipes/:id', (req, res) => {
  const { id } = req.params;
  const result = recipes.find((r) => r.id === Number(id) );

  if (!result) return res.status(404).json({ message: '404'});

  res.status(200).json(result);
});
app.get('/recipes', (req, res) => {
  res.json(recipes);
});




app.listen('3000', () => {
  console.log('Servidor aberto na porta 3000');
});