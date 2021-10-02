const fs = require('fs').promises;
const fsWithoutPromise = require('fs');

const express = require('express')
const bodyParser = require('body-parser');

const app = express();
app.use(bodyParser.json());

// Crie uma rota GET /ping
app.get('/ping', (req, res) => {
  // Sua rota deve retornar o seguinte JSON: { message: 'pong' }
  res.status('200').json({message: 'pong'});
});

// Crie uma rota POST /hello
app.post('/hello', (req, res) => {
  // Sua rota deve receber, no body da requisição, o seguinte JSON: { "name": "<nome do usuário>" }
  const { name } = req.body;
  // Sua rota deve retornar o seguinte JSON: { "message": "Hello, <nome do usuário>!" }.
  res.status('200').json({ message: `Hello, ${name}!` });
});

// Crie uma rota POST /greetings
app.post('/greetings', (req, res) => {
  // Sua rota deve receber o seguinte JSON: { "name": "<nome do usuário>", "age": <idade do usuário> }.
  const { name, age } = req.body;

  // Caso a pessoa usuária tenha 17 anos ou menos, devolva o JSON { "message": "Unauthorized" } com o status code 401 - Unauthorized.
  if(Number(age) <= 17) return res.status('401').json({ "message": "Unauthorized" });


  // Caso a pessoa usuária tenha idade superior a 17 anos, devolva o JSON { "message": "Hello, <nome do usuário>!" } com o status code 200 - OK.
  res.status('200').json({ "message": `Hello,${name}!` });
});

// Crie uma rota PUT /users/:name/:age.
app.put('/users/:name/:age', (req, res) => {
  // Sua rota deve retornar o seguinte JSON: { "message": "Seu nome é <name> e você tem <age> anos de idade" }.
  const { name, age } = req.params;
  res.status('200').json({ "message": `Seu nome é ${name} e você tem ${age} anos de idade` });
});

// Crie um endpoint GET /simpsons
// O endpoint deve retornar um array com todos os simpsons.
app.get('/simpsons', (req, res) => {
    fs.readFile('simpsons.json', 'utf-8').then((content) => {
      res.status('200').json(JSON.parse(content));
    }).catch((e) => {
      res.status('401').json({"message": `Erro ao solicitar o arquivo simpsons.json, ${e.message}`});
    });  
});


// Crie um endpoint POST /simpsons .
// Este endpoint deve cadastrar novos personagens.
app.post('/simpsons', (req, res) => {
  // O corpo da requisição deve receber o seguinte JSON: { id: <id-da-personagem>, name: '<nome-da-personagem>' } .
  const { id, name } = req.query;
  
  const data = JSON.parse(fsWithoutPromise.readFileSync('simpsons.json', 'utf-8'));
  
  const alreadyExists = data.some((simpson) => Number(simpson.id) === Number(id));
  
  // Caso já exista uma personagem com o id informado, devolva o JSON { message: 'id already exists' } com o status 409 - Conflict .
  if(alreadyExists) return res.status('409').json({ message: 'ERROR 409 - CONFLICT: ID already exists!' });
  
  data.push({ id, name });
  console.log(req.query);
  
  // Caso a personagem ainda não exista, adicione-a ao arquivo simpsons.json e devolva um body vazio com o status 204 - No Content . Para encerrar a request sem enviar nenhum dado, você pode utilizar res.status(204).end(); .
  fsWithoutPromise.writeFileSync('simpsons.json', JSON.stringify(data), () => {
    res.status('204').end()
  });
});

// Crie um endpoint GET /simpsons/:id
app.get('/simpsons/:id', (req, res) => {
  const { id } = req.params;
  
  try {
    const data = JSON.parse(fsWithoutPromise.readFileSync('simpsons.json', 'utf-8'));
    const filteredSimpson = data.find(s => Number(s.id) === Number(id));
    
    // Caso não exista nenhum personagem com o id especificado, retorne o JSON { message: 'simpson not found' } com o status 404 - Not Found .
    if (!filteredSimpson) res.status('404').json({ message: 'simpson not found' });
    
    // O endpoint deve retornar o personagem com o id informado na URL da requisição.
    res.status('200').json(filteredSimpson);
  } catch(e) {
    res.status('200').json({"Arquivo não encontrado": 404});
  }
});

app.listen('4000', () => {
  console.log('Servidor aberto na porta 4000');
});
