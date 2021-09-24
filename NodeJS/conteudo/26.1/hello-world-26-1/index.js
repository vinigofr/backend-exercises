const { question, questionInt } = require('readline-sync');

// Hello World do npm
// console.log('Hello, world!');

// Hello world robusto:
const nome = question('Qual seu nome? ');
const idade = questionInt('Qual sua idade? ');

console.log(`Olá, ${nome}! Você tem ${idade} anos.`);