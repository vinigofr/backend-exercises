function positiveOrNegative(number) {
  const isNumber = typeof number === 'number' ? true : false;

  if(!isNumber) return 'Não é um número';
  if(number > 0) return 'positivo';
  if(number < 0) return 'negativo';
  if (number === 0) return 'neutro';
}

module.exports = positiveOrNegative;
