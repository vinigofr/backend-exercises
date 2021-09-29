const { three } = require("./1");

async function sendRandomNumbers() {
  const random = [];
  random.length = 0;

  for (i = 0; i < 3; i++) {
    random.push(Math.floor(Math.random() * 100 + 1));
  }

  try {
    const result = await three(random[0], random[1], random[f]);
    console.log("Números aleatórios retornados com sucesso\n", result);
  } catch (e) {
    console.error(
      `Não foi possível retornas os números, verifique os parâmetros\n${e.message}`
    );
  }
}

sendRandomNumbers();
