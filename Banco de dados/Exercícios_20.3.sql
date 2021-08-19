-- Filtrar resultados de consultas com o WHERE .
-- Tirando como base o DB Sakila, famos filtar por filmes que não contenham
-- o nome 'ACADEMY' no título.
USE sakila;
SELECT * from film
SELECT * from film
WHERE title NOT LIKE '%ACADEMY%';

-- Ou podemos verificar filmes que tenham o custo maior que 20
SELECT * from film
WHERE cost > 20;
----------------------------------------------------------------------------
-- Utilizar operadores booleanos e relacionais em consultas.
-- Ou podemos verificar com condicionais AND e OR
SELECT * FROM film
WHERE title LIKE 'john o leião' AND rate = 'LIVRE PARA TODOS OS PÚBLICOS';  
--
--LEGENDA:

-- 1. Precisamos identificar os dados do cliente com o e-mail LEONARD.SCHOFIELD@sakilacustomer.org .
-- 2. Precisamos de um relatório dos nomes dos clientes, em ordem alfabética , 
-- que não estão mais ativos no nosso sistema e pertencem à loja com o id = 2 , e não inclua o cliente KENNETH no resultado.
-- 3. O setor financeiro quer saber título, descrição, ano de lançamento e 
-- valor do custo de substituição ( replacement_cost ), dos 100 filmes com o maior custo de substituição, 
-- do valor mais alto ao mais baixo, entre os filmes feitos para menores de idade e que têm o custo mínimo 
-- de substituição de $18,00 dólares. Em caso de empate, ordene em ordem alfabética pelo título.
-- 4. Quantos clientes estão ativos e na loja 1 ?
-- 5. Mostre todos os detalhes dos clientes que não estão ativos na loja 1 .
-- 6. Precisamos descobrir quais são os 50 filmes feitos apenas para adultos com a menor taxa de 
-- aluguel, para que possamos fazer uma divulgação melhor desses filmes. Em caso de empate, ordene em ordem alfabética pelo título.
-- 1
USE sakila;
SELECT * FROM customer
WHERE email = 'LEONARD.SCHOFIELD@sakilacustomer.org';
-- 2
SELECT * FROM customer
WHERE first_name NOT LIKE 'KENNETH'
AND active IS FALSE
AND store_id LIKE 2
ORDER BY first_name;
-- 3
SELECT * FROM film
WHERE (rating = 'G'
OR rating = 'PG'
OR rating = 'PG'
OR rating = 'PG-13'
OR rating = 'R')
AND replacement_cost >= 18
ORDER BY replacement_cost DESC
LIMIT 100;
-- 4
SELECT COUNT(*) FROM customer
WHERE active IS TRUE;
-- 5
SELECT * FROM customer
WHERE active IS FALSE
AND store_id = 1;
-- 6
SELECT * FROM film
WHERE rating = 'NC-17'
ORDER BY replacement_cost ASC;
----------------------------------------------------------------------------

-- Criar consultas mais dinâmicas e maleáveis com LIKE.
-- O LIKE é usado para buscar por meio de uma sequência específica de caracteres
-- % O sinal de percentual, que pode representar zero, um ou múltiplos caracteres
-- O underlin, que representa um único caractere
-- Resultado espefícico no final da string
SELECT * FROM sakila.film
WHERE title LIKE '%don';

-- Resultado específico no início da string
SELECT * FROM sakila.film
WHERE title LIKE 'don%';

-- Resultado que contenha qualquer coisa referente entre dois %
SELECT * FROM sakila.film
WHERE title LIKE '%plu%';

-- Encontra qualquer resultado que inicia com "p" e finaliza com "r"
SELECT * FROM sakila.film
WHERE title LIKE 'p%r';

-- Encontra qualquer resultado em que o segundo caractere da frase é "C"
SELECT * FROM sakila.film
WHERE title LIKE '_C%';

-- Encontra qualquer resultado em que o título possui exatamente 8 caracteres
SELECT * FROM sakila.film
WHERE title LIKE '________';

-- Encontra todas as palavras com no mínimo 3 caracteres e que iniciam com E
SELECT * FROM sakila.film
WHERE title LIKE 'E__%';
-- Fazer consultas que englobam uma faixa de resultados com IN e BETWEEN .
-- Encontrar e separar resultados que incluem datas.