const express = require('express')
const app = express();
const bodyParser = require('body-parser');
app.use(bodyParser.json());

function validatePrice(req, res, next) {
  const { price } = req.body;
  const theNumber = Number(price);
  console.log(price, theNumber);

  if (!price || price === '' || theNumber < 0) return res.status(400).json({ message: 'Invalid data!'});
  next();
}

app.post('/price', validatePrice, (req, res) => {
  res.status('200').json({ message: "O preço está OK"});
});

app.put('/price/:id', validatePrice, (req, res) => {
  const { id } = req.params;
  
});

app.listen('3000', () => {
  console.log('Aberto na porta 3000');
});