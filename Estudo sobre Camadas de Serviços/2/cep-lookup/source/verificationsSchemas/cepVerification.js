// Abaixo, ficarão as funções que nos dão retornos aos erros.
// True, false, menssagens de erro e afins.
// As verificações feitas aqui sempre deverão retornar algo importante.

// Como as funções da camada MODELS são assíncronas, devemos usar async e await
// neste ambiente de SERVICES. Afinal, devemos esperar retornos.
const correctLength = (cep) => (cep.length !== 9);
const isStandardized = (cep) => (!/\d{5}-?\d{3}/.test(cep));
const needBar = (cep) => (cep[5] !== '-');

const err_code = 422;
const e = {
  wrong_length: 'O CEP precisa seguir o padrão de tamanho: 00000-000',
  wrong_standard: 'O CEP precisa seguir o padrão: 00000-000',
  miss_character: 'CEP não pode ser informado com ausência da "-"'
}

const validateCep = (cep) => {
  switch (true) {
    case correctLength(cep): return { err_code, message: e.wrong_length }
    case isStandardized(cep): return { err_code, message: e.wrong_standard }
    case needBar(cep):  return { err_code, message: e.miss_character }
    default: return '';
  }
}

module.exports = validateCep;
