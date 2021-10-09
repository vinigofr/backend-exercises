const connection = require("./connection");
const { ObjectId } = require('mongodb');

// Função que faz tratamento no objeto.
const getNewAuthor = ({ id, firstName, middleName, lastName }) => {
  const fullName = [firstName, middleName, lastName]
    .filter((name) => name)
    .join(" ");
  return {
    id,
    firstName,
    middleName,
    lastName,
    fullName,
  };
};

// Middleware que restata todos os atores.
const getAll = async () => {
  const data = await connection()
    // Collections que queremos acessar, no primeiro .then()
    // Em vez de -> db.authors.find(),
    // Se usa -> db.collection('authors').find()
    .then((db) => db.collection("authors").find().toArray())
    // O data será retornado no segundo .then
    .then((authors) => {
      return authors.map(({ _id, firstName, middleName, lastName }) => {
        return getNewAuthor({ id: _id, firstName, middleName, lastName });
      });
    });

  return data;
};

const getAllById = async (id) => {
  const data = await connection()
  .then((db) => db.collection("authors").findOne(new ObjectId(id)))
  .then((authors) => {
    return getNewAuthor(authors);
  });

return data;
};

module.exports = {
  getAll,
  getAllById
};
