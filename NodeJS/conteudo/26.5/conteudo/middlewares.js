// Middlewares
// A primeira coisa que você precisa saber sobre middlewares é que, no Express qualquer função passada para uma rota é um middleware , seja de forma direta ou indireta.

// Para o Express, um middleware é uma função que realiza o tratamento de uma request e que pode encerrar essa request, ou chamar o próximo middleware.

// Um exemplo de Middleware:

app.post("/recipes", 
  function (req, res, next) {
    const { name } = req.body;
    if (!name || name === "")
      return res.status(400).json({ message: "Invalid data!" }); // 1

    next(); // 2
  },
  function (req, res) {
    // 3
    const { id, name, price } = req.body;
    recipes.push({ id, name, price });
    res.status(201).json({ message: "Recipe created successfully!" });
  }
);

// Uma das vantagens do Express suportar diversos middlewares é que podemos reaproveitar alguns deles para serem utilizados em diversas rotas. No nosso caso essa função que valida se o nome foi enviado poderia ser também aproveitada para a rota PUT /recipes/:id. Para isso vamos tirar a definição dessa função de dentro da rota POST /recipes e aplicá-la para ser usada nas duas rotas.

// Aparentemente, colocando o parâmetro next, estamos simbolizando para um próximo middleware. Para se fazer uso deve-se colocar comoo parâmetros dos próximos verbos HTTP, como parâmetro, o primeiro middleware com a função Next()

function validateName(req, res, next) {
  const { name } = req.body;
  if (!name || name === "")
    return res.status(400).json({ message: "Invalid data!" });

  next();
}

app.post("/recipes", validateName, function (req, res) {
  const { id, name, price } = req.body;
  recipes.push({ id, name, price });
  res.status(201).json({ message: "Recipe created successfully!" });
});

app.put("/recipes/:id", validateName, function (req, res) {
  const { id } = req.params;
  const { name, price } = req.body;
  const recipesIndex = recipes.findIndex((r) => r.id === parseInt(id));

  if (recipesIndex === -1)
    return res.status(404).json({ message: "Recipe not found!" });

  recipes[recipesIndex] = { ...recipes[recipesIndex], name, price };

  res.status(204).end();
});

// mas geralmente no caso do último middleware de uma rota, que processa a resposta da requisição caso todos os middlewares anteriores não tenham encerrado o fluxo, não temos necessidade de usar o objeto next por isso podemos simplesmente receber apenas os objetos req e res.


// Passando valores entre middlewares com objeto req.

// Middlewares também podem modificar o objeto req , e essas modificações serão recebidas pelos próximos middlewares, caso next seja chamado. Isso geralmente é utilizado para propagar informações de um middleware para o outro.

// Observe que tivemos acesso ao objeto req.user que veio do nosso middleware authMiddleware . Dessa forma aproveitando o encadeamento entre middlewares conseguimos passar informações entre middleware sempre que for necessário. O objeto req praticamente aceita qualquer atributo que você quiser definir, só é preciso tomar cuidado para não sobrescrever nenhum dos atributos padrão (req.body, req.headers, req.params, req.query, etc).
