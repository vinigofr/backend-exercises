const {connection} = require('./connection');

const createNewAuthor = async ({firstName, lastName, email, password}) => {
  await connection()
      .then((db) => db.collection('authors').insertOne({
        firstName,
        lastName,
        email,
        password,
      }));
};

const findLastAdded = async () => {
  const data = await connection()
      .then((db) => db.collection('authors')
          .find()
          .sort( {'_id': -1} )
          .toArray());
  return data[0];
};

module.exports = {
  createNewAuthor,
  findLastAdded,
};
