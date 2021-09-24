// Hoje aprenderemos como utilizar funções assíncronas no NodeJS.

// Você será capaz de:
// Realizar operações assíncronas utilizando callbacks;
// Realizar operações assíncronas utilizando Promises;
// Ler e escrever arquivos localmente com Node.js;
// Escrever seus próprios scripts que criam e consomem Promises;
// Reescrever código que usa callbacks para que use Promises.

// Exemplo de callback usando fs do NodeJS
const fs = require('fs');

fs.readFile('./arquivo.txt', (err, content) => {
  if (err) {
    console.error(`Erro ao ler o arquivo: ${err.message}`);
    return;
  }

  console.log(`Arquivo lido com sucesso. Conteúdo: ${content.toString('utf8')}`);
});

// Esse formato de callback que recebe dois parâmetros, erro e resultado, não foi utilizado por acaso. Callbacks desse tipo são chamadas de node-style callbacks e são, por convenção, a melhor maneira de se estruturar uma callback. Toda API de módulos nativos do Node.js utiliza esse mesmo formato de callbacks . Guarde essa informação, pois ela vai ser importante mais tarde. 😉

// Função de divisão simples usando a criação de new Promise.
function dividirNumeros(num1, num2) {
  const promise = new Promise((resolve, reject) => {
    if (num2 == 0) reject(new Error("Não pode ser feito uma divisão por zero"));

    const resultado = num1 / num2;
    resolve(resultado)
  });

  return promise;
}

dividirNumeros(2, 1)
  .then(result => console.log(`sucesso: ${result}`))
  .catch(err => console.log(`erro: ${err.message}`));

// Agora, de forma síncrona:
function dividirNumeros(num1, num2) {
  if (num2 == 0) throw new Error("Não pode ser feito uma divisão por zero");

  return num1 / num2;
}

try {
  const resultado = dividirNumeros(2, 1);
  console.log(`resultado: ${resultado}`);
} catch (e) {
  console.log(e.message);
}
