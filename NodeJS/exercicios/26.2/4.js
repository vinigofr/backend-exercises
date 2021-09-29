const fs = require("fs").promises;

// function handleSimpson(array) {
//   const allSimpsonns = JSON.parse(array);
//   const result = allSimpsonns.map(({ id, name }) => `${id} - ${name}`);
//   return result;
// }

// async function HandleId(id) {
//   const promise = new Promise((resolve, reject) => {
//     fs.readFile("simpsons.json", "utf-8")
//       .then((content) => {
//         const anySimpson = JSON.parse(content).filter(
//           (person) => Number(person.id) === id
//         );
//         if (anySimpson.length === 0) {
//           reject(`Não existe nenhum simpson com o id ${id}`);
//         }
//         resolve(anySimpson);
//       })
//       .catch((e) => {
//         console.log("Arquivo não encontrado", e.message);
//       });
//   });
//   return promise;
// }

// async function reWrite() {
//   fs.readFile('simpsons.json', 'utf-8').then((content) => {
//     const simpsonsArray = JSON.parse(content);
//     const removedSimpson = simpsonsArray.filter(({ id }) => Number(id) !== 10 && Number(id) !== 6);

//     fs.writeFile('simpsons.json', JSON.stringify(removedSimpson), 'utf-8').then(() => {
//       console.log('Simpson regravado com sucesso');
//     }).catch((e) => {
//       console.log('Erro ao gravar arquivo', e.message);
//     });
//   }).catch((e) => {
//     console.log('Arquivo não encontrado', e.message);
//   });
// }

// reWrite();

// function theSimpsons() {
//   fs.readFile("simpsons.json", "utf-8")
//     .then(async (content) => {
//       console.log(handleSimpson(content));
//       const result = await HandleId(10);
//       console.log(result);
//     })
//     .catch((error) => {
//       console.error(`Ocorreu um erro interno, ${error}`);
//     });
// }

// theSimpsons();

// async function reWrite() {
//   fs.readFile('simpsons.json', 'utf-8').then((content) => {
//     const simpsonsArray = JSON.parse(content);
//     const filterFamily = simpsonsArray.filter(({ id }) => Number(id) > 0 && Number(id) <= 4);

//     fs.writeFile('simpsonFamily.json', JSON.stringify(filterFamily), 'utf-8', { flag: 'a' })
//     .then(() => {
//       console.log('Sucesso na operação.');
//     });

//   }).catch((e) => {
//     console.log('Arquivo não encontrado', e.message);
//   });
// }

// reWrite();+


async function reWrite() {
  fs.readFile('simpsons.json', 'utf-8').then((content) => {
    const simpsonsArray = JSON.parse(content);
    const filterFamily = simpsonsArray.filter(({ id }) => Number(id) > 0 && Number(id) <= 4);

    fs.writeFile('simpsonFamily.json', JSON.stringify(filterFamily), 'utf-8', { flag: 'a' })
    .then(() => {
      console.log('Sucesso na operação.');
    });

  }).catch((e) => {
    console.log('Arquivo não encontrado', e.message);
  });
}

reWrite();
