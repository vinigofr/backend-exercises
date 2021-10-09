// Vamos falar sobre as camadas de Controllers e de Services.
// Essas duas camadas são, respectivamente, responsáveis por (1) receber e tratar os dados da requisição e (2) aplicar as regras de negócio da aplicação antes que qualquer comunicação com o banco seja realizada. Dessa forma, o Model precisa fazer menos coisas, o que quer dizer que temos uma arquitetura que delimita mais as responsabilidades de cada camada, de forma que, caso precisemos alterar uma parte do código, a quantidade de lugares em que precisaremos mexer é menor, visto que camada tem sua responsabilidade bem delimitada. Vamos falar sobre as camadas de Controllers e de Services.
// Essas duas camadas são, respectivamente, responsáveis por (1) receber e tratar os dados da requisição e (2) aplicar as regras de negócio da aplicação antes que qualquer comunicação com o banco seja realizada. Dessa forma, o Model precisa fazer menos coisas, o que quer dizer que temos uma arquitetura que delimita mais as responsabilidades de cada camada, de forma que, caso precisemos alterar uma parte do código, a quantidade de lugares em que precisaremos mexer é menor, visto que camada tem sua responsabilidade bem delimitada.

// Fonte: https://s3.us-east-2.amazonaws.com/assets.app.betrybe.com/back-end/architecture/msc/msc-part-2/images/architecture_layers-ea1a7edbd08e7a7648a207cacbbadbd1.png

// A camada dos Controllers
// Isso porque a camada dos controllers é a primeira camada numa API. É nela onde os dados da requisição serão recebidos e tratados, pra depois serem passados para as próximas camadas.

// A camada de controllers é responsável por receber e tratar as requests, e, no express, é composta majoritariamente de middlewares. Sendo assim, para construir nosso controller, só precisamos trazer os middlewares do index.js para o controller, alterando-os para que utilizem o service ao invés do model. Parece bastante coisa? Não se preocupe, vamos fazer middleware a middleware.

// O controller recebe as requisições e então consulta o service , enviando na resposta aquilo que o service retornar, que pode ser uma mensagem de erro, em caso de falha, ou as informações pedidas, em caso de sucesso.
// Ao se comunicar com o service , o controller deve passar apenas as informações necessárias, sendo assim não é uma boa prática passar toda a request para o service , as informações devem ser extraídas e então apenas o que for necessário para determinada ação deve ser transferido.
// Uma ótima analogia para o controller é que ele seria como um garçom em um restaurante. O garçom não sabe como preparar os pratos e nem como recepcionar as pessoas na porta. Ele apenas anota o pedido, sabe para que parte do restaurante levar o pedido e para qual mesa entregá-lo depois de pronto.

// ===

// Camada dos Services.
// Ela fica situada entre as camadas de controller e model e é responsável pela nossa lógica de negócio. O modelo, então, passa a ser responsável somente pelo acesso a dados.

// Pense nessa camada como o chef da cozinha do nosso restaurante. Ele é quem sabe as receitas e delega as funções para os funcionários depois de receber o pedido do garçom.
// Uma boa camada de serviço:
// Deve centralizar acesso a dados e funções externas. Exemplo: chamar um evento que dispara uma mensagem no Slack;
// Deve abstrair lógica de negócio complexa do seu modelo;
// Não deve ter nenhum tipo de informação sobre o acesso a camada de dados. Exemplo: não ter nenhuma query SQL;
// Não deve receber nada relacionado ao HTTP, seja o request ou o response . O controller deve mandar apenas o necessário para o service .
