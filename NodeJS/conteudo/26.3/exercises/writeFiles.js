const fs = require('fs');

function writeFiles(fileName, content) {
  try {
    const data = fs.writeFileSync(fileName, content);
    return 'ok'
  } catch (e) {
    return 'Erro ao criar arquivo. Verifique os parâmetros'
  }
}

module.exports = writeFiles;