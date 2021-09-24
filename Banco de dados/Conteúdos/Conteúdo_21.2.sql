-- Algumas funções iniciais do 21.2:
-- INNER JOIN para combinar dados de duas ou mais tabelas
-- LEFT JOIN e RIGHT JOIN para combinar dados de duas ou mais tabelas
-- SELF JOIN para fazer join de uma tabela com ela própria
-- Unir resultados de queries com UNION e UNION ALL
-- Utilizar SUBQUERIES, uma espécie de sub-consulta.
-- Criar queries mais eficientes através do EXISTS, para verificar se dados existem.

-- 1. Exemplos de JOIN's:
SELECT t1.coluna, t2.coluna
FROM tabela1 AS t1
INNER JOIN tabela2 AS t2
ON t1.coluna_em_comum = t2.coluna_em_comum;

-- O AS pode ser omitido, desde que o caminho ta tabela seja especificado
-- como por exemplo: sakila.film.title. E outra, o nome não pode ser igual,
-- pois causa ambiguidade
-- Um segundo caso pode ser usado como exemplo abaixo:
SELECT a.first_name, a.actor_id, f.actor_id
FROM sakila.actor a
INNER JOIN film_actor f
ON a.actor_id = f.actor_id;

-- Exercício:
-- Monte uma query que exiba o id do ator , nome do ator e id do filme em que ele já atuou usando as tabelas actor e film_actor .
select t1.actor_id, t1.first_name, t2.film_id
FROM sakila.actor AS t1
INNER JOIN sakila.film_actor AS t2
ON t1.actor_id = t2.actor_id;

-- Use o JOIN para exibir o nome , sobrenome e endereço de cada um dos funcionários do banco. Use as tabelas staff e address .
SELECT staff.first_name, staff.last_name, location.address
FROM sakila.staff AS staff
INNER JOIN sakila.address AS location
ON staff.address_id = location.address_id;

-- Exiba o id do cliente, nome e email dos primeiros 100 clientes, ordenados pelo nome em ordem decrescente, juntamente com o id
-- do endereço e o nome da rua onde o cliente mora. Essas informações podem ser encontradas nas tabelas customer e address.
SELECT 
cliente.customer_id, cliente.first_name, cliente.email,
address.address_id, address.address
FROM sakila.customer AS cliente
INNER JOIN sakila.address AS address
ON address.address_id = cliente.address_id
ORDER BY cliente.first_name DESC
LIMIT 100;

-- Exiba o nome , email , id do endereço , endereço e distrito dos clientes que moram no distrito da California e que contêm
-- "rene" em seus nomes. As informações podem ser encontradas nas tabelas address e customer.
SELECT
cliente.first_name, cliente.email, cliente.address_id,
address.address_id, address.district, address.address
FROM sakila.customer AS cliente
INNER JOIN sakila.address AS address
ON address.district = 'California' 
AND cliente.first_name LIKE '%rene'
AND cliente.address_id = address.address_id;

-- Exiba o nome e a quantidade de endereços dos clientes cadastrados. Ordene seus resultados por nomes de forma decrescente.
-- Exiba somente os clientes ativos. As informações podem ser encontradas na tabela address e customer.
SELECT
cliente.first_name, COUNT(address.address_id)
FROM sakila.customer AS cliente
INNER JOIN sakila.address
ON cliente.address_id = address.address_id
WHERE cliente.active = 1
group by cliente.first_name;

-- Monte uma query que exiba o nome , sobrenome e a média de valor ( amount ) paga aos funcionários no ano de 2006. Use as
-- tabelas payment e staff . Os resultados devem estar agrupados pelo nome e sobrenome do funcionário.
SELECT func.first_name, func.last_name, AVG(pay.amount)
FROM sakila.staff AS func
INNER JOIN sakila.payment AS pay
ON func.staff_id = pay.staff_id
WHERE YEAR(payment_date) = 2006
GROUP BY func.first_name;

-- Monte uma query que exiba o
-- id do ator, nome, id do filme e título do filme, usando as tabelas actor, film_actor e film.
-- Dica: você precisará fazer mais de um JOIN na mesma query.
SELECT A.actor_id, A.first_name, F.film_id, F.title
FROM sakila.actor AS A
INNER JOIN sakila.film_actor AS FA
ON A.actor_id = FA.actor_id
INNER JOIN sakila.film AS F
ON F.film_id = FA.film_id;

-- Utilizando LEFT JOIN e o RIGTH JOIN:
-- Basicamente, dependendo da condicional do ON, o RIGTH JOIN e LEFT JOIN trabalharão de formas
-- diferentes.
-- Quando utilizando LEFT JOIN, a quary se baseará na tabela da esquerda para exibir os dados.
-- Quando utilizando RIGTH JOIN, a quary se baseará na tabela da direita para exibir os dados.
-- Onde não houver dados satisfatórios utilizando a condição ON, ele retornará NULL na tabela
-- oposta à selecionada.
-- Isto é, se selecionar RIGHT JOIN, os dados não encontrados serão retornados NULL's na tabala da esquerda.

-- Exemplo: LEFT
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    a.actor_id,
    a.first_name,
    a.last_name
FROM customer AS c
LEFT JOIN actor AS a
ON c.last_name = a.last_name
ORDER BY c.last_name;

-- Exemplo: RIGHT
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    a.actor_id,
    a.first_name,
    a.last_name
FROM customer AS c
RIGHT JOIN actor AS a
ON c.last_name = a.last_name
ORDER BY c.last_name;

-- Sobre o SELF JOIN:
-- fazer pesquisas e comparações dentro da própria tabela através do SELF JOIN . Lembre-se dessa opção sempre que a
-- informação que você precisa filtrar ou comparar para encontrar algo estiver em uma única tabela.
-- Note que um SELF JOIN não é um tipo diferente de JOIN . É apenas um caso em que uma tabela faz join consigo mesma.

-- Sintaxe:
SELECT t1.title, t1.replacement_cost, t2.title, t2.replacement_cost
FROM sakila.film AS t1, sakila.film AS t2
WHERE t1.length = t2.length;
-- Ou seja, ele cria uma espécia de 'cópia' da mesma tabela.

-- Exercicio de SELF JOIN:
-- Queremos saber os ids e custos de substituição dos filmes que possuem o mesmo custo de substituição.
SELECT t1.film_id, t1.title, t1.replacement_cost, t2.film_id, t2.replacement_cost
FROM sakila.film AS t1, sakila.film AS t2
WHERE t1.replacement_cost = t2.replacement_cost;
-- Exiba o título e a duração de empréstimo dos filmes que possuem a mesma duração. Exiba apenas os filmes com a duração de empréstimo entre 2 e 4 dias.
SELECT t1.title, t1.rental_duration, t2.title, t2.rental_duration
FROM sakila.film AS t1, sakila.film AS t2
WHERE
t1.rental_duration BETWEEN 2 AND 4
AND
t2.rental_duration BETWEEN 2 AND 4;

-- Unindo resultados com o UNION e o UNION ALL:
-- O UNION é uma forma de unir registros de uma tabela com registros de outra tabela.
-- Utilizando comente UNION, os dados duplicados serão removidos.
-- Sintaxe:
select first_name, last_name from sakila.actor
UNION
select first_name, last_name from sakila.staff;
-- Já o UNION ALL não remove os registros duplicados.
select first_name, last_name from sakila.actor
UNION ALL
select first_name, last_name from sakila.staff;

-- OBS: O Número de colunas deve ser o mesmo.
-- Uma alternativa é inserir o mesmo número de colunas na tabela de origem e na tabela de destino.
-- Exemplo: INSERIR UM VALOR VAZIO:
-- Adicionar um campo vazio para a tabela de destino.

-- Caso seja de gosto do programador usar uma função de ordenação no UNION ou UNION ALL,
-- o mesmo deve englobar o SELECT com parênteses, quando utilizando o UNION ORDER BY.
(select first_name, last_name from sakila.actor)
UNION ALL
(select first_name, last_name from sakila.staff)
ORDER BY first_name;

-- Exercícios com UNION e UNION ALL:
-- Todos os funcionários foram promovidos a atores. Monte uma query que exiba a união da tabela
-- staff com a tabela actor , exibindo apenas o nome e o sobrenome . Seu resultado não deve excluir
-- nenhum funcionário ao unir as tabelas.
SELECT first_name, last_name FROM sakila.staff
UNION ALL
SELECT first_name, last_name FROM sakila.actor;

-- Monte uma query que una os resultados das tabelas customer e actor, exibindo os nomes que contêm
-- a palavra "tracy" na tabela customer e os que contêm "je" na tabela actor. Exiba apenas os
-- resultados únicos.
SELECT first_name, last_name FROM sakila.customer
WHERE first_name LIKE '%tracy%'
UNION ALL
SELECT first_name, last_name FROM sakila.actor
WHERE first_name LIKE '%je%';
-- Monte uma query que exiba a união dos cinco últimos nomes da tabela actor, o primeiro nome
-- da tabela staff e cinco nomes a partir da 15ª posição da tabela customer . Não permita que
-- dados repetidos sejam exibidos. Ordene os resultados em ordem alfabética.
(SELECT first_name FROM sakila.actor ORDER BY first_name DESC LIMIT 5)
UNION
(SELECT first_name FROM sakila.staff ORDER BY first_name LIMIT 1)
UNION
(SELECT first_name FROM sakila.customer ORDER BY first_name LIMIT 15 OFFSET 5)
ORDER BY first_name;
-- Você quer exibir uma lista paginada com os nomes e sobrenomes de todos os clientes e atores do
-- banco de dados, em ordem alfabética. Considere que a paginação está sendo feita de 15 em 15resultados
-- e que você está na 4ª página. Monte uma query que simule esse cenário.
(SELECT first_name, last_name FROM sakila.customer
ORDER BY first_name , last_name LIMIT 60)
UNION
(SELECT first_name, last_name FROM sakila.actor
ORDER BY first_name , last_name LIMIT 60)
ORDER BY first_name , last_name LIMIT 15 OFFSET 45;

-- Sobre SUBQUERY:
-- Uma SUBQUERY é uma query aninhada que é avaliada dentro de um par de parênteses.
-- Ela pode conter expressões simples, como adições e subtrações, mas não se limita a isso,
-- uma vez que podemos utilizar praticamente todos os comandos já vistos até o momento dentro de uma SUBQUERY.

-- Usando uma SUBQUERY como fonte de dados para o WHERE
SELECT first_name, last_name FROM sakila.customer
WHERE first_name LIKE (SELECT first_name FROM sakila.staff);

-- Usando uma SUBQUERY como fonte de dados para o FROM.
SELECT f.title, f.rating FROM (
    SELECT *
    FROM sakila.film
    WHERE rating = 'R'
)
  AS f;

-- Preenchendo uma coluna de um SELECT por meio de uma SUBQUERY.
SELECT
    address,
    district,
    (
        SELECT city
        FROM sakila.city
        WHERE city.city_id = sakila.address.city_id
    ) AS city
FROM sakila.address;

-- Filtrando resultados com WHERE usando como base os dados retornados de uma SUBQUERY.
SELECT address, district
FROM sakila.address
WHERE city_id in (
    SELECT city_id
    FROM sakila.city
    WHERE city in ('Sasebo', 'San Bernardino', 'Athenai', 'Myingyan')
);

-- Usando uma tabela externa, de fora da SUBQUERY, dentro dela.
SELECT
    first_name,
    (
        SELECT address
        FROM sakila.address
        WHERE address.address_id = tabela_externa.address_id
    ) AS address
FROM sakila.customer AS tabela_externa;

-- Sobre performarce: é importante saber medir o tempo de execução de uma query. Assim, podendo
-- saber qual método de busca usar isso em grandes aplicações, vale a pena pelo tempo e processamento.
-- O SELECT puro irá buscar por todas as linhas da tabela.
-- O SELETE com WHERE irá otimizar o processamento, pois irá buscar apenas as linhas que atendem ao filtro.

-- Usando o EXISTS para criação de queries mais dinâmicas.
-- Retorna dados de uma tabela T1 onde existe relacionamento com uma tabela T2. 
-- O EXISTS espera uma SUBQUERY como parâmetro.

-- 1. Usando o EXISTS na tabela books_lent e books, exiba o id e título dos livros que ainda não foram emprestados.
SELECT Id, Title FROM hotel.Books
WHERE EXISTS (
SELECT book_rental FROM hotel.Books_Lent where returned = 1 AND book_rental = Id
);

-- 2. Usando o EXISTS na tabela books_lent e books , exiba o id e título dos livros estão atualmente
-- emprestados e que contêm a palavra "lost" no título.
SELECT b.Id, b.Title FROM hotel.Books AS b
WHERE EXISTS (
SELECT book_rental
FROM hotel.Books_Lent
WHERE returned = 0
AND book_rental = b.Id
AND b.Title
LIKE '%lost%'
);
-- 3. Usando a tabela carsales e customers , exiba apenas o nome dos clientes que ainda não compraram um carro.
SELECT Name FROM hotel.Customers AS c
WHERE NOT EXISTS (
	SELECT CustomerID FROM hotel.CarSales WHERE CustomerID = c.CustomerId
);
-- 4. Usando o comando EXISTS em conjunto com JOIN e as tabelas cars, customers e carsales,
-- exiba o nome do cliente e o modelo do carro de todos os clientes que fizeram compras de carros.
SELECT cus.Name, car.Name FROM hotel.Customers AS cus
INNER JOIN hotel.Cars AS car
WHERE EXISTS (
	select * from hotel.CarSales
    WHERE CustomerID = cus.CustomerID AND CarID = car.ID
);