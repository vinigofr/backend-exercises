const { MongoClient } = require('mongodb');

const OPTIONS = {
  // useNewUrlParser : o time do mongodb reescreveu a forma que o driver utiliza para interpretar a URL de conexão
  //  ao banco. Por ser uma mudança muito grande, essa nova forma de interpretação de URLs só é ativada com o uso 
  // dessa flag. A forma antiga, no entanto, está depreciada, e seu uso emite um warning no terminal.
  useNewUrlParser: true,
  // useUnifiedTopology : nas versões mais recentes do driver do mongodb, a ferramenta que realiza a descoberta de
  // servidores e a conexão com os mesmos foi alterada. Essa flag diz para o driver do mongodb que queremos utilizar 
  // essa nova forma de conexão. A forma de conexão antiga está depreciada, e seu uso emite um warning no terminal.
  useUnifiedTopology: true
};

const MONGO_URL = 'mongodb://127.0.0.1:27017';
// Este primeiro exemplo sempre conectará ao banco
// const connection = () => {
//   return MongoClient.connect(MONGO_URL, OPTIONS)
//   .then((conn) => {
//     Onde 'model_example' é o nome do db
//     return conn.db('model_example');
//   })
//   .catch(e => {
//     console.log(e);
//     process.exit();
//   });
// };

// Este segundo exemplo permanecerá conectado depois da primeira vez.
let db = null;

const connection = () => {
    return db
    ? Promise.resolve(db)
    : MongoClient.connect(MONGO_URL, OPTIONS)
    .then((conn) => {
    db = conn.db('model_example');
    return db;
    })
};

// Outro ponto importante de se reparar no código acima é que estamos utilizando um padrão conhecido como singleton. Em resumo, um singleton é um objeto ou módulo que, mesmo que chamado várias vezes, só vai ser criado uma vez.
// No nosso caso, da primeira vez que chamarmos a função connection , a variável db estará vazia, e precisaremos realizar a conexão com o banco.
// No entanto, nas próximas vezes, a variável já estará preenchida, pois nós a preenchemos na linha 14, da primeira vez que realizamos a condição.
// Sendo assim, a execução não chega no MongoClient.connect . Ela é interrompida antes e a db armazenada anteriormente é retornada.
// Isso garante que, durante todo o ciclo de vida da nossa aplicação, só iremos abrir uma conexão com o banco. Isso que estamos fazendo é semelhante ao que fazemos ao criar uma pool no mysql2 . A questão é que o método de conexão do driver do MongoDB retorna uma Promise e, por isso, é mais difícil utilizá-lo exatamente da mesma forma.

module.exports = connection;
