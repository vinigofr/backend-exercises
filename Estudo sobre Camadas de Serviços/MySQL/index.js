const express = require('express')
const app = express();
const BP = require('body-parser');

app.use(BP.json());

const Author = require('./models/Author');
const Book = require('./models/Book');

app.get('/authors', async (req, res) => {
  const authors = await Author.getAll(); 

  res.status(200).json(authors);
});

app.get('/books', async (req, res) => {
  const { q } = req.query;

  if(!q) {
    const books = await Book.getAllBooks();
    return res.status(200).json(books);
  }

  const booksByAuthorId = await Book.getByAuthorId(q);
  return res.status(200).json(booksByAuthorId);
});

app.post('/authors', async (req, res) => {
  const {first_name, middle_name, last_name} = req.body;

  if(Author.isValid(first_name, middle_name, last_name)) {
    return res.status(400).json({ message: 'Dados inválidos' });
  }

  await Author.create(first_name, middle_name, last_name);
  res.status(201).json({ message: 'Autor criado com sucesso! '});
});

app.listen(3000);