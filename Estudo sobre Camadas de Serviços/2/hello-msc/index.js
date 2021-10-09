const express = require('express');

const Author = require('./controllers/Author');

const app = express();

app.use(express.json());

app.get('/authors', async (_req, res) => {
  await Author.getAll();
});

app.get('/authors/:id', async (req, res) => {
  await Author.findById(id);
});

app.post('/authors', async (req, res) => {
  await Author.create();
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Ouvindo a porta ${PORT}`);
});
