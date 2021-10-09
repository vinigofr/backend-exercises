const express = require('express');
const app = express();

const Author = require('./models/Author');

app.use(express.json());

app.get('/authors', async (req, res) => {
  try {
    const data = await Author.getAll();
    return res.status(200).json(data);
  } catch (e) { 
    console.error(e);
  }
});

app.get('/authors/:id', async (req, res) => {
  const data = await Author.getAllById(req.params.id);
  res.status(200).json(data);
});

app.listen(3000, () => console.log('servidor aberto'));
