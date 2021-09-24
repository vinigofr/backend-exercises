const read = require('readline-sync');

console.log('Adivinha o número aleatório!!!');
console.log('Foi gerado um número aleatório de 0 a 10. ADIVINHE-O');

function game() {
  const random = Math.floor(Math.random() * 10) + 1;
  /*Solução GitHub Copilot
  let numero = read.questionInt('Qual o número? ');
    if (numero === random) {
        console.log('Parabéns!!! Você acertou o número');
    } else {
        console.log('Você errou o número. Tente novamente');
        game();
    }*/

    // Minha solução
  const numero = read.questionInt('Qual o número? ');
  if(numero === random) {
    console.log('Parabéns!!! Você acertou o número');
    console.log('Deseja jogar novamente? :)');
    const resposta = read.keyInYN('Digite Y para sim ou N para não: ');
    if(resposta) game();
  } else {
    console.log(`O número era ${random}`);
    console.log('Mas você errou :( Deseja jogar novamente?');
    const resposta = read.keyInYN('Digite Y para sim ou N para não: ');
    if(resposta) game();
  }
};

game();