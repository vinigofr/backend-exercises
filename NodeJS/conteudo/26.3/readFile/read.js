const fs = require('fs');

const read = (fileName) => {
  try {
    const content = fs.readFileSync(fileName, 'utf-8');
    return content;
  } catch (e) {
    return null
  }
}

module.exports = read;