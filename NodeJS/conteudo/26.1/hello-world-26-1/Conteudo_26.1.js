// Pra começar, vamos entender o que é um módulo em Node.js: um módulo é um "pedaço de código" que pode ser organizado em um ou mais arquivos, e que possui escopo próprio, ou seja: suas variáveis, funções, classes e afins só estão disponíveis nos arquivos que fazem parte daquele módulo. Em outras palavras, um módulo é uma funcionalidade ou um conjunto delas que se encontram isoladas do restante do código.

// O Node.js possui três tipos de módulos: internos, locais e de terceiros.

// Módulos internos
// Os módulos internos (ou core modules ) são inclusos no Node.js e instalados junto com ele quando baixamos o runtime.

// Alguns exemplos de core modules são:
// Clique no nome de cada módulo para abrir a documentação oficial (em inglês).
// fs : Fornece uma API para interagir com o sistema de arquivos de forma geral;

// url : Provê utilitários para ler e manipular URLs;

// querystring : Disponibiliza ferramentas para leitura e manipulação de parâmetros de URLs;

// util : Oferece ferramentas e funcionalidades comumente úteis a pessoas programadoras.

// Importações em Node.js

// Existem dois sistemas de módulos difundidos na comunidade JavaScript:
// Módulos ES6 ;
// Na especificação do ECMAScript 6, os módulos são importados utilizando a palavra-chave import , tendo como contrapartida a palavra-chave export para exportá-los.

// Módulos CommonJS .
// Para exportar algo nesse método, a seguinte sintaxe é utilizada:
const brl = 5.37;
module.exports = brl;

// O module.exports pode receber qualquer valor válido em JavaScript, incluindo objetos, classes, funções e afins.

const brl = 5.37;
const usdToBrl = (valueInUsd) => valueInUsd * brl;
module.exports = usdToBrl;

// Exportando mais de um item:
const brl = 5.37;
const usdToBrl = (valueInUsd) => valueInUsd * brl;
module.exports = {
  brl,
  usdToBrl,
};

// Desta forma, o acesso deverá ser feito com notação de ponto ou descontrução:
const { brl, usdToBrl } = require("./converter");

// UM pouco mais sobre o NPM (Node Package Manager).

// O comando npm init nos permite criar, de forma rápida e simplificada, um novo pacote Node.js na pasta onde é executado.
// O NPM irá pedir algumas informações para que possamos criar o pacote.
// O comando npm init --yes ou -y nos permite criar o pacote sem que o usuário tenha que digitar nada.
// Após, um arquivo package.json será criado na pasta onde o comando foi executado.


// NPM RUN 
// O comando run faz com que o npm execute um determinado script configurado no package.json . Scripts são "atalhos" que podemos definir para executar determinadas tarefas relacionadas ao pacote atual.
// Ex de script para ESLint:
const obj =
{
  "scripts": {
    "lint": "eslint ."
  }
}

/* Exemplo de npm start:
{
   ...
   "scripts": {
     "start": "node imc.js"
   }
   ...
}
*/

// npm run lint
