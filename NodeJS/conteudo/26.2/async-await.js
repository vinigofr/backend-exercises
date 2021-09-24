// Utilizando async/await
// Acontece que nem sempre queremos utilizar essa API das Promises. Muitas vezes, queremos simplesmente buscar o resultado e pronto. E é aí que entra o async/await .
// Essas duas palavras-chave foram criadas para trabalhar com Promises como se estivéssemos trabalhando com código síncrono.
// A questão é que toda função na qual utilizamos async, automaticamente passa a retornar uma Promise, que será rejeitada em caso de erro, e resolvida em caso de sucesso.
// O resultado de usarmos async / await é que o código fica com uma sintaxe quase idêntica à sintaxe utilizada para código síncrono. Veja como fica o exemplo anterior utilizando async/await :
const fs = require('fs').promises;

async function main() {
  try {
    await fs.writeFile('./meu-arquivo.txt', 'Meu textão');
    console.log('Arquivo escrito com sucesso!');
  } catch (err) {
    console.error(`Erro ao escrever o arquivo: ${err.message}`);
  }
}

main()

//

// Ainda sobre o writeFile , você pode especificar algumas opções na escrita de arquivos passando um terceiro parâmetro opcional para os métodos writeFile e writeFileSync . A opção flag especifica como o arquivo deve ser aberto e manipulado. O padrão é 'w' , que especifica que o arquivo deve ser aberto para escrita. Se o arquivo não existir, ele é criado. Caso contrário, ele é reescrito, ou seja, tem seu conteúdo apagado antes de o novo conteúdo ser escrito. A flag 'wx' , por exemplo, funciona como 'w' , mas lança um erro caso o arquivo já exista:
const fs = require('fs').promises;

// A flag wx abre o arquivo para escrita **apenas** caso ele não exista. Caso o contrário, um erro será lançado
fs.writeFile('./meu-arquivo.txt', 'Eu estive aqui :eyes:', { flag: 'wx' })
  .then(() => {
    console.log('Arquivo salvo');
  })
  .catch((err) => {
    // Se o arquivo existir, um erro é retornado
    console.error('err');
  });

// Como o arquivo acima já existe, o seguinte erro é retornado:
// [...]
// [Error: EEXIST: file already exists, open './meu-arquivo.txt'] {
//   errno: -17,
//   code: 'EEXIST',
//   syscall: 'open',
//   path: './meu-arquivo.txt'
// }

// Flags: https://nodejs.org/api/fs.html#fs_file_system_flags

// Rodando tudo junto
// Promises são executadas assim que são criadas. Isso quer dizer que, no código abaixo, todos os arquivos serão lidos ao mesmo tempo e, portanto, não teremos uma forma de saber quando cada um vai terminar de ser lido. Mas e se precisarmos do resultado da leitura dos três arquivos?
// Entra no palco: Promise.all !
// O Promise.all é um método da Promise que nos permite passar um array de Promises e receber, de volta, uma única Promise. Ela será resolvida com os resultados de todas as Promises, assim que todas elas forem resolvidas. Esse método também nos permite utilizar um único catch , que será chamado caso qualquer uma das Promises seja rejeitada.
// Vamos reescrever quase o mesmo código que fizemos lá em cima, que utilizamos para mostrar como Promises evitam o callback hell. Desta vez, vamos escrever, no final, a soma do tamanho de todos os arquivos. Além disso, vamos utilizar o módulo ('fs').promises para não precisarmos trabalhar com callbacks manualmente.

const fs = require('fs').promises;

Promise.all([
  fs.readFile('file1.txt'),
  fs.readFile('file2.txt'),
  fs.readFile('file3.txt'),
])
  .then(([file1, file2, file3]) => {
    const fileSizeSum = file1.byteLength + file2.byteLength + file3.byteLength;
    console.log(`Lidos 3 arquivos totalizando ${fileSizeSum} bytes`);
  })
  .catch((err) => {
    console.error(`Erro ao ler arquivos: ${err.message}`);
  });
  
// Ótimo! Agora, estamos lendo os três arquivos ao mesmo tempo, e nosso .then será executado quando a leitura de todos eles terminar, recebendo como parâmetro um array com o resultado de cada uma das Promises.