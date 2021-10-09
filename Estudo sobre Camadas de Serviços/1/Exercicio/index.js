const express = require('express');
const app = express();
app.use(express.json());

const {createNewAuthor, findLastAdded} = require('./models/Authors');

const {
  emptyVerification,
  passwordVerification,
} = require('./middlewares/userVerifier');


app.post('/user',
    emptyVerification,
    passwordVerification,
    async (req, res) => {
      const {firstName, lastName, email, password} = req.body;
      const returnedData = await findLastAdded();
      createNewAuthor({firstName, lastName, email, password});
      res.status(201).json( {
        added: true,
        data: returnedData,
      });
    });

app.listen(3000, () => console.log('Server oppened at 3000 PORT'));
