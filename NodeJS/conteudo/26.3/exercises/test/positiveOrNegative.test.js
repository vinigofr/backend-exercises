// File system
const fs = require("fs");

// Provê funções como bee, expect to, be...
const { expect } = require("chai");

// Função verificadora de números
const positiveOrNegative = require("../positiveOrNegative");

describe("Verifica os retornos quando", () => {
  describe("é informado um número positivo", () => {
    const resultado = positiveOrNegative(1);
    it("é retornado uma string", () => {
      expect(resultado).to.be.a("string");
    });

    it('e seu retorno é "positivo"', () => {
      expect(resultado).to.be.equals("positivo");
    });
  });

  describe("é informado um número negativo", () => {
    const resultado = positiveOrNegative(-1);
    it("é retornado uma string", () => {
      expect(resultado).to.be.a("string");
    });

    it("e seu valor é negativo", () => {
      expect(resultado).to.be.equals("negativo");
    });
  });

  describe('é informado algo fora do tipo "Number"', () => {
    const resultado = positiveOrNegative('número');
    it('é retornado uma string', () => {
      expect(resultado).to.be.a("string");
    });

    it('e seu valor é "Não é um número"', () => {
      expect(resultado).to.be.equals("Não é um número");
    });
  });
});
