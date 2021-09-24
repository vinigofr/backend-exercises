// Lendo arquivos com métodos assíncronos:

// Primeiro, é importante saber que não precisamos ler arquivos "em segundo plano". Podemos fazer isso de forma síncrona, ou seja: parar a execução de todo o programa até que um arquivo seja lido.

// O método disponibilizado pelo módulo fs para leitura síncrona de arquivos é o fs.readFileSync . Vamos utilizá-lo no exemplo a seguir.

// Para começar, vamos criar uma pasta para nosso projeto, chamada io-local . Iniciaremos nosso projeto Node.js usando o comando npm init . Feito isso, vamos criar um arquivo chamado readFileSync.js e colocar nele o seguinte código:

const fs = require("fs");

const nomeDoArquivo = "file.txt";

try {
  //   Ele recebe três parâmetros:
  // O nome do arquivo;
  // Um parâmetro opcional que, quando é uma string, define o encoding que será utilizado durante a leitura do arquivo;
  // Uma callback que permite receber e manipular os dados lidos do arquivo.
  const data = fs.readFileSync(nomeDoArquivo, "utf8");
  console.log(data);
} catch (err) {
  console.error(`Erro ao ler o arquivo: ${err.path}`);
  console.log(err);
}

// Também é possível trabalhar com promisses usando o fs com promisses
const fs = require('fs').promises;

const nomeDoArquivo = 'meu-arquivo.txt';

fs.readFile(nomeDoArquivo, 'utf8')
  .then((data) => {
    console.log(`Conteúdo do arquivo: ${data}`);
  })
  .catch((err) => {
    console.error(`Não foi possível ler o arquivo ${nomeDoArquivo}\n Erro: ${err}`);
    process.exit(1); // Encerra a execução do script e informa ao sistema operacional que houve um erro com código
  });