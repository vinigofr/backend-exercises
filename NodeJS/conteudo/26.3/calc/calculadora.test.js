const sum = require('./calculadora').calcSum;
const chai = require('chai');

// const { it, describe, } = mocha;
const { expect, } = chai;

describe('Veririca se a soma é condizente com os parâmetros passados.', () => {
  it('Verificar se 1 + 1 retorna 2', () => {
    const resposta = sum(1, 1);
    expect(resposta).to.be.equals(2);  
  });
});