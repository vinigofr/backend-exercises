// Como as requisições ao banco de dados são feitas por aqui agora, e não mais no index (por meio de app.get),
// nada mais justo do que fazer as requisições através da CAMADA DE MODELO.

// Por isso, usaremos o arquivo de conexão com o servidor aqui.
// Tirando essa tarefa do index.
const connection = require('../server/connection');

// Abaixo, criaremos as "funções" específicas. Elas serão chamadas quando necessário!
// Por isso é importante saber o que sua API fará. Assim, fica mais fácil criar essas "funções".

// Antes de ocorrer o chamado das funções, é feita uma verificação na camada de Service (SERVIÇO)

// Tarefas que foram definidas no exercício do dia 26.2

// Rota GET /cep/:cep
const getByCep = async (cep) => {
  const newCep = Number(cep.split('-').join(''))

  const [data] = await connection.execute(
    `SELECT cep FROM ceps WHERE cep = '?';`, [newCep]
  );
  console.log(data)
  if(data.length === 0) {
    return { "error": { "code": "notFound", "message": "CEP não encontrado" } }
  }

  return data;
};

module.exports = {
  getByCep,
}



