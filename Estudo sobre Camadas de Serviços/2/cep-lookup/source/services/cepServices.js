// Aqui, nós estamos importanto o arquivo CepModels.
// Aqui, na camada de SERVICE, serão feitas as verificações.
const CepModels = require('../models/cepModels');

const cepVerification = require('../verificationsSchemas/cepVerification');

// Após as validações serem feitas, a camada de MODEL irá agir.
const getByCep = async (cep) => {
  const isValid = cepVerification(cep);

  // A condicional verificará a integridade do dado.
  // Cao haja algo errado, será retornada uma mensagem de erro.
  if(isValid) {
    return  { error: { "code": "invalidData", "message": "CEP inválido" } }
  }

  // Caso tudo ocorra bem, a requisição será feita na CAMADA MODEL com o comando abaixo
  return await CepModels.getByCep(cep);
};

module.exports = {  
 getByCep,
}
