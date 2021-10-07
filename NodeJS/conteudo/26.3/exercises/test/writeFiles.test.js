// File system
const fs = require("fs");

// Fake functions
const sinon = require("sinon");

// Provê funções como bee, expect to, be...
const { expect } = require("chai");

// Função para criação de arquivos
const writeFiles = require('../writeFiles');

// 

// Conteúdo da função
const CONTENT = "oi beleléu";

describe('Verificações para escrita de arquivos',() => {
  
  before(() => {
    sinon.stub(fs, "readFileSync").returns(CONTENT);
  });

  after(() => {
    fs.readFileSync.restore();
  });

  describe('Verifica se', () => {
    it('retorna "ok" quando parâmetros corretos são passados', () => {
      const resultado = writeFiles('Oi.txt', 'oi beleléu');
      expect(resultado).to.be.equals('ok');
    });

    it('retorna "erro" quando parâmetros incorretos são passados', () => {
      const resultado = writeFiles();
      expect(resultado).to.be.equals('Erro ao criar arquivo. Verifique os parâmetros');
    });

    it('arquivo foi criado com sucesso', () => {
      const data = fs.readFileSync('Oi.txt', 'utf-8');
      expect(data).to.be.equals('oi beleléu');
    });
});
});