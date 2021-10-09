const {MongoClient} = require('mongodb');

const OPTIONS = {
  useNewUrlParser: true,
  useUnifiedTopology: true,
};

const URL = 'mongodb://127.0.0.1:27017';
let db = null;

module.exports = {
  connection: () => {
    return db ? Promise.resolve(db) : MongoClient.connect(URL, OPTIONS)
        .then((conn) => {
          db = conn.db('model_example');
          return db;
        });
  },
};
