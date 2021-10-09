const connection = require('./connection');

const getAllBooks = async () => {
  const result = connection.execute(
    'SELECT * FROM books'
  );
  return result;
};

const getByAuthorId = async (id) => {
  const result = connection.execute(
    `SELECT * FROM books WHERE author_id = ${id}`
  );
  return result
}

module.exports = {
  getAllBooks,
  getByAuthorId
};