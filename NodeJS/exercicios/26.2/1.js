const three = (param1, param2, param3) => {
  const numbersOnly = !(
    typeof param1 === "number" &&
    typeof param2 === "number" &&
    typeof param3 === "number"
  );

  const promise = new Promise((resolve, reject) => {
    const result = (param1 + param2) * param3;

    if (numbersOnly) reject(new Error("Apenas parâmetros numéricos permitidos."));
    if (result < 50) reject(new Error("Valor muito baixo"));
    resolve(result);
  });

  return promise;
};

// three(1, 2, 210)
//   .then((content) => console.log(content))
//   .catch((e) => console.log(e.message));

module.exports = { 
  three
 };
