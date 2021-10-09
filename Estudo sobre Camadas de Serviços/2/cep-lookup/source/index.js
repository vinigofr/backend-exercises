const express = require('express');

// Importamos aqui o arquivo de rotas, para deixarmos o nosso index.js mais enxuto.
// Afinal, sua única tarefa é iniciar o servidor.
const cepRoutes = require('./routes/cepRoutes');

const PORT = 3000;
const app = express();
app.use(express.json());

app.use(cepRoutes);
app.get('/', (req, res) => {
  return res.status(200).json({ message: 'pong'});
});


app.listen(PORT, () => console.log(`Servidor aberto na porta ${PORT}`));
