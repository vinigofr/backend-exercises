const read = require('readline-sync');
// const Math = require('mathjs');

const peso = read.questionFloat('Digite seu peso ->');
const altura = read.questionFloat('Digite sua altura ->');

const result = Math.round(peso / (altura * altura),2);
let situação = '';

const situation = () => {
  // using if
  if (result < 18.5) {
    situação = 'Abaixo do peso';
  }
  else if (result >= 18.5 && result <= 24.9) {
    situação = 'Peso normal';
  }
  else if (result >= 25 && result <= 29.9) {
    situação = 'Sobrepeso';
  }
  else if (result >= 30 && result <= 34.9) {
    situação = 'Obesidade grau 1';
  }
  else if (result >= 35 && result <= 39.9) {
    situação = 'Obesidade grau 2';
  }
  else if (result >= 40) {
  situação = 'Obesidade grau 3';
  }
};

situation();

console.log(`Seu IMC é ${result} e sua situação é ${situação}`);
