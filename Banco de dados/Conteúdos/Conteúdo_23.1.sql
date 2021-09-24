-- Conteúdo sobre MongoDB

-- Primeiramente, é importante falar dos pacotes que foram instalados e suas respectivas funções.

-- -> Os pacotes instalados
-- mongodb-org-server : esse pacote contém o que podemos chamar de "servidor" do MongoDB . Contém todos os recursos necessários para que uma instância do banco seja executada;

-- mongodb-org-shell : o shell é onde você se conecta com o MongoDB através do terminal. É uma interface que suporta JavaScript e é super completa para administração de instâncias e clusters;

-- mongodb-org-mongos : pronuncia-se "Mongo S" e só se faz necessário em ambientes Shard . Não entraremos em detalhes sobre ele agora;

-- mongodb-org-tools : esse pacote contém algumas ferramentas nativas do MongoDB. Como por exemplo:
-- mongodump : ferramenta para extrair dados no formato BSON (falaremos dele mais adiante). Em alguns ambientes, pode fazer parte da estratégia de backup;
-- mongorestore : ferramenta para restaurar backups gerados pelo mongodump ;
-- mongoimport : ferramenta para importar arquivos JSON , CSV ou TSV para uma instância do MongoDB ;
-- mongoexport : exporta dados de uma instância do MongoDB para arquivos JSON ou CSV .

-- Diretórios de trabalho
-- Se você instalou o MongoDB via apt (gerenciador de pacotes do Linux), então algumas configurações são executadas e mantidas em diretórios do sistema operacional. Por padrão, no Linux, os dados ficarão armazenados em /var/lib/mongodb , e o log de funcionamento em /var/log/mongodb .
-- No MacOS, os dados e os logs ficam em /usr/local/var/mongodb e /usr/local/var/log/mongodb , respectivamente.
-- Por padrão, o MongoDB roda utilizando a conta do usuário mongodb , que também foi criada durante a instalação. Se você quiser rodar uma instância com outro usuário, deverá dar as permissões para ele nos diretórios de dados e log.

-- Lista de comandos úteis para MongoDB:
-- https://docs.mongodb.com/manual/reference/mongo-shell/

-- Banco de Dados, Coleções e Documentos

-- Para adicionar itens em um documento, você pode utilizar o comando insertOne() ou insertMany().
-- Ambos recebem um JSON como parâmetro, mas a diferença é que o insertOne() recebe apenas um documento, enquanto o insertMany() recebe um array de documentos.

db.movies.insertOne(
    {
        "title" : "Forrest Gump",
        "category" : [ "drama", "romance" ],
        "imdb_rating" : 8.8,
        "filming_locations" : [
            { "city" : "Savannah", "state" : "GA", "country" : "USA" },
            { "city" : "Monument Valley", "state" : "UT", "country" : "USA" },
            { "city" : "Los Anegeles", "state" : "CA", "country" : "USA" }
        ],
        "box_office" : {
            "gross" : 557, "opening_weekend" : 24, "budget" : 55
        }
    }
);

-- Para encontrar itens específicos em um documento, você pode utilizar o comando find().
-- Ele recebe dois parametros:
-- 1. Um JSON com os critérios de busca.
-- 2. Um JSON com as opções de busca.

  db.movies.find(
    {
        "title" : "Forrest Gump",
        "category" : "drama",
    },
    {
        "title" : 1,
        "category" : 1,
        "imdb_rating" : 0,
        "_id": 0
    }
);

-- Onde 1 significa que o campo será retornado, e 0 que não.

-- Por padrão, o .find() retorna todos os documentos que atendem aos critérios de busca.
-- Esse valor é de 20 em 20.

-- Você pode digitar "it" para continuar a iteração.
-- O método .count() retorna o número de itens que há em uma colação.


-- Tipos e comparações.

-- No NoSQL do MongoDB, uma comparação de "maior que" pode ser feita da seguinte forma:

db.movies.find(
    {
        "box_office.gross" : { $gt : 500 }
    }
);

-- A expressão $gt significa "maior que", que em inglês é "greater than".

-- No MongoDB, uma comparação de "menor que" pode ser feita da seguinte forma:

db.movies.find(
    {
        "box_office.gross" : { $lt : 500 }
    }
);

-- Onde $lt significa "less than".

-- Vales lembrar que para certos retornos, é importante saber com qual tipo
-- de dato estamos lidando.
-- De nada adianta comparar um número com uma string, por exemplo.
-- Para isso, você pode utilizar o operador $type.

db.movies.find(
    {
        "box_office.gross" : { $type : "number" }
    }
);

-- Selecionando todos os documentos de uma coleção: BASEADO EM BIOS

db.bios.find();
-- equivalente a SELECT * FROM bios;

-- A operação abaixo retorna os documentos da coleção bios em que o atributo _id é igual a 5 :
db.bios.find( { _id: 5 } );

-- Essa operação corresponde à seguinte consulta no SQL :
SELECT * FROM bios WHERE _id = 5;

-- Agora, a operação abaixo retorna todos os documentos da coleção bios em que o campo last do subdocumento name é igual a "Hopper" :
db.bios.find( { "name.last": "Hopper" } )

-- Retornando apenas parâmetros específicos:

-- Através do segundo parâmetro do método find() , podemos especificar quais atributos serão retornados. O exemplo abaixo retorna todos os documentos da coleção bios , trazendo apenas o atributo name de cada documento:

db.bios.find({}, { name: 1 });

-- é o mesmo que: SELECT name FROM bios;

-- Limitando a quantidade de itens retornados:
-- Atrelado ao método find() , o método limit() especifica a quantidade de itens que serão retornados.
-- O exemplo abaixo retorna apenas os primeiros 10 documentosda coleção bios:

db.bios.find().limit(10);

-- Em MySQL, o método limit() é equivalente ao LIMIT;

-- O método .pretty() retorna o resultado da consulta em formato legível e identado.
db.bios.find().limit(5).pretty();

-- "Pulando" itens com o método skip():
-- O método skip() pula a quantidade de itens especificados.
-- Ele recebe um parâmetro que é o número de itens que serão pulados, antes de realmente
-- começar a contagem.
-- O exemplo abaixo retorna os documentos da coleção bios a partir do segundo documento:

db.bios.find().skip(1);

-- Pode-se combinar métodos, como por exemplo o método .skip() e o método .limit().
-- O exemplo abaixo retorna os documentos da coleção bios a partir do segundo documento, e traz apenas os primeiros 10 documentos:

db.bios.find().skip(1).limit(10);

Se fosse fazer em MySQL, o exemplo seria equivalente a:

SELECT * FROM bios LIMIT 10 OFFSET 1;