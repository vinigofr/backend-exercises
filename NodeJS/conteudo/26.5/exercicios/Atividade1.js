const express = require("express");
const app = express();

app.use(express.json());

// Crie uma rota POST /user/register que receba uma requisição que envie username , email e password no body da requisição, onde:
app.post("/user/register", (req, res) => {
  const { email, password, username } = req.body;
  const emailRegex = /^[a-z0-9.]+@[a-z0-9]+\.[a-z]+(\.[a-z]+)?$/;

  // 1. email deve ter o formato email@mail.com;
  const emailValidation = emailRegex.test(email);
  // 2. username deve ter mais de 3 caracteres;
  const usernameValidation = username.length > 3;
  // 3. password deve conter no mínimo 4 caracteres e no máximo 8 (todos números);
  const passwordValidation =
    password.length >= 4 && password.length <= 8 && Number(password) > 0;

    // Para todos os casos não atendidos acima deve ser retornado o código de status e um JSON com uma mensagem de erro, ex: status 400 e { "message": "invalid data" } ;
  if (!(emailValidation &&
    usernameValidation &&
    passwordValidation)) return res.status(400).json({ message: "Invalid data!" });

    // Caso tenha sucesso deve ser retornado uma resposta com o código de status e um JSON com uma mensagem de sucesso, ex: status 201 e { "message": "user created" } ;
  res.status(200).json({ "message": "User created" });
  
});

// Crie uma rota POST /user/login que receba uma requisição que envie email / password no body da requisição e devolva um token como resposta, onde:
app.post('/user/login', (req, res) => {
  const { email, password } = req.body;
});

// create a function to generate a random token with length of 12 characters, including letters and numbers
function generateToken() {
  const possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%&*()_+£¢¬{[]}=+-*/";
  let token = "";
  for (let i = 0; i < 12; i++) {
    token += possible.charAt(Math.floor(Math.random() * possible.length));
  }
  console.log(token);
  return token;
}

generateToken();


// O formato desse token retornado deve ser uma string aleatória com 12 caracteres;
// O email recebido deve ter o formato email@mail.com;
// O password deve conter no mínimo 4 caracteres e no máximo 8, todos números;
// Para todos os casos não atendidos acima deve ser retornado o código de status e um JSON com uma mensagem de erro, ex: status 400 e { "message": "email or password is incorrect" }
// Caso tenha sucesso deve ser retornado uma resposta com o código de status e um JSON com uma mensagem de sucesso, ex: status 200 e { "token": "86567349784e" } ;
// Dicas: separe suas rotas em arquivos e utilize middlewares para validar os campos recebidos nas requisições

app.listen(3000, () => {
  console.log("Servidor aberto na porta 3000");
});
