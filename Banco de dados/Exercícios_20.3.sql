-- Filtrar resultados de consultas com o WHERE.
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
-- 1. Precisamos identificar os dados do cliente com o e-mail LEONARD.SCHOFIELD@sakilacustomer.org.
USE sakila;
SELECT * FROM customer
WHERE email = 'LEONARD.SCHOFIELD@sakilacustomer.org';
-- 2. Precisamos de um relatório dos nomes dos clientes, em ordem alfabética , 
-- que não estão mais ativos no nosso sistema e pertencem à loja com o id = 2 , e não inclua o cliente KENNETH no resultado.
SELECT * FROM customer
WHERE first_name NOT LIKE 'KENNETH'
AND active IS FALSE
AND store_id LIKE 2
ORDER BY first_name;
-- 3. O setor financeiro quer saber título, descrição, ano de lançamento e 
-- valor do custo de substituição ( replacement_cost ), dos 100 filmes com o maior custo de substituição, 
-- do valor mais alto ao mais baixo, entre os filmes feitos para menores de idade e que têm o custo mínimo 
-- de substituição de $18,00 dólares. Em caso de empate, ordene em ordem alfabética pelo título.
SELECT * FROM film
WHERE (rating = 'G'
OR rating = 'PG'
OR rating = 'PG'
OR rating = 'PG-13'
OR rating = 'R')
AND replacement_cost >= 18
ORDER BY replacement_cost DESC
LIMIT 100;
-- 4. Quantos clientes estão ativos e na loja 1 ?
SELECT COUNT(*) FROM customer
WHERE active IS TRUE;
-- 5. Mostre todos os detalhes dos clientes que não estão ativos na loja 1 .
SELECT * FROM customer
WHERE active IS FALSE
AND store_id = 1;
-- 6. Precisamos descobrir quais são os 50 filmes feitos apenas para adultos com a menor taxa de 
-- aluguel, para que possamos fazer uma divulgação melhor desses filmes. Em caso de empate, ordene em ordem alfabética pelo título.
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

--Atividade para busco específico de string:
--1 Mostre todos os detalhes dos filmes que contêm a palavra ace no nome.
SELECT * FROM sakila.film
WHERE title LIKE '%ace%';
--2 Mostre todos os detalhes dos filmes cujas descrições finalizam com china.
SELECT * FROM sakila.film
WHERE title LIKE 'china%';
--3 Mostre todos os detalhes dos dois filmes cujas descrições contêm a palavra girl e o título finaliza com a palavra lord .
SELECT * FROM sakila.film
WHERE description LIKE '%girl%'
AND title LIKE '%lord';
--4 Mostre os dois casos em que, a partir do 4° caractere no título do filme, tem-se a palavra gon.
SELECT * FROM sakila.film
WHERE title LIKE '___gon%';
--5 Mostre o único caso em que, a partir do 4° caractere no título do filme, tem-se a palavra gon e a descrição contém a palavra Documentary.
SELECT * FROM sakila.film
WHERE title LIKE '___gon%'
AND description LIKE '%Documentary%';
--6 Mostre os dois filmes cujos títulos ou finalizam com academy ou iniciam com mosquito.
SELECT * FROM sakila.film
WHERE title LIKE '%academy' OR title LIKE 'mosquito%';
--7 Mostre os seis filmes que contêm as palavras monkey e sumo em suas descrições.
SELECT * FROM sakila.film
WHERE description LIKE '%monkey%' 
AND description LIKE '%sumo%';

----------------------------------------------------------------------------

-- Englobando uma faixa de resultados com IN e BETWEEN
-- Operador IN: Um OR e AND melhorados.
-- Exemplo:
SELECT * FROM sakila.actor
WHERE first_name IN ('PENELOPE','NICK','ED','JENNIFER');
-- O mesmo procedimento funciona para números.
SELECT * FROM sakila.customer
WHERE customer_id in (1, 2, 3, 4, 5);

-- Operador BETWEEN - Uma outra opção quando queremos trabalhar com faixas de resultados é o BETWEEN.
-- Torna possível fazer pesquisas dentro de uma faixa inicial e final.
-- Ex: 1 a 1000 ou A à Z;
(expressão BETWEEN valor1 AND valor2);
-- Então, quando você faz uma query como essa, você terá o resultado da imagem a seguir:
SELECT title, length FROM sakila.film
WHERE length BETWEEN 50 AND 120;
-- Para encontrar uma faixa de valores em que os valores são strings
SELECT * FROM sakila.language
WHERE name BETWEEN 'Italian' AND 'Mandarin'
ORDER BY name;
-- Usando o BETWEEN com datas (LEMBRANDO DO PADRÃO YYYY-MM-DD)
SELECT rental_id, rental_date FROM sakila.rental
WHERE rental_date
BETWEEN '2005-05-27' AND '2005-07-17';

-- A melhor forma de você não chutar é clicar no botão Execution Plan no MySQL
-- Workbench e verificar o tempo de execução para tomar a decisão de qual tem o
-- menor custo de execução - o que significa que a query finalizará mais rápido.
--
-- Exercício de fixação IN e BETWEEN usando sakila;
-- Mostre o nome, sobrenome e e-mail dos clientes com os seguintes sobrenomes: hicks, crawford, henry, boyd, mason, morales e kennedy , ordenados por nome em ordem alfabética.
SELECT `last_name`, last_name, email FROM sakila.customer
WHERE last_name IN ('hicks', 'crawford', 'henry', 'boyd', 'mason', 'morales', 'kennedy')
ORDER BY last_name;
-- Mostre o e-mail dos clientes com os address_id 172, 173, 174, 175 e 176 , ordenados em ordem alfabética.
SELECT email FROM sakila.customer
WHERE address_id BETWEEN 172 AND 173
ORDER BY first_name;
-- Descubra quantos pagamentos foram feitos entre 01/05/2005 e 01/08/2005.
SELECT payment_date FROM sakila.payment
WHERE payment_date BETWEEN '2005/05/01' AND '2005/08/01';
-- Mostre o título, ano de lançamento e duração do empréstimo de todos os filmes
-- com a duração de empréstimo de 3 a 6 . Os resultados devem ser classificados em
-- filmes com maior duração de empréstimo primeiro. Em caso de empate, ordene em ordem
-- alfabética pelo título.
SELECT title, release_year, rental_duration FROM sakila.film
WHERE rental_duration BETWEEN 3 AND 6;

----------------------------------------------------------------------------
-- Encontrando e separando resultados que incluem datas
-- No MySQL, o tipo DATE faz parte dos tipos de dados temporais
-- mas quando datas, o formato é sempre ANO-MÊS-DIA (NÃO É POSSÍVEL ALTERÁ-LA)
-- Comandos SQL p/ DATAS de 
DATE -> ('1001/01/01' BETWEEN '9999-12-31'); -- FORMATO YYYY-MM-DD
DATETIME -> ('1000-01-01 00:00:00' BETWEEN '9999-12-31 23:59:59') -- FORMATO YYYY-MM-DD HH:MM:SS
--
-- Modos de encontrar itens por DATA
SELECT * FROM sakila.payment
WHERE DATE(payment_date) = '2005-07-31';
--
-- Modos de encontrar itens por LIKE
-- Encontra todos pagamentos deste dia, ignorando horas, minutos e segundos
SELECT * FROM sakila.payment
WHERE payment_date LIKE '2005-07-31%';
-- Encontra um pagamento com dia e hora exatos
SELECT * FROM sakila.payment
WHERE payment_date LIKE '2005-08-20 00:30:52';
-- Encontra pagamentos especificando um valor mínimo e um valor máximo para a data
SELECT *
FROM sakila.payment
WHERE payment_date BETWEEN '2005-05-26 00:00:00' AND '2005-05-27 23:59:59';
--
-- Pegando informações específicas de DATA
-- Teste cada um dos comandos a seguir:
SELECT DATE(payment_date) FROM sakila.payment; -- YYYY-MM-DD
SELECT YEAR(payment_date) FROM sakila.payment; -- Ano
SELECT MONTH(payment_date) FROM sakila.payment; -- Mês
SELECT DAY(payment_date) FROM sakila.payment; -- Dia
SELECT HOUR(payment_date) FROM sakila.payment; -- Hora
SELECT MINUTE(payment_date) FROM sakila.payment; -- Minuto
SELECT SECOND(payment_date) FROM sakila.payment; -- Segundo

-- Atividade final de fixação
-- 1 Quantos pagamentos temos com a data de retorno 2005-05-25 ? Há múltiplas maneiras possíveis de encontrar a resposta.
SELECT payment_date FROM sakila.payment
WHERE DATE(payment_date) = '2005/05/25';
-- 2 Quantos pagamentos foram feitos entre 01/07/2005 e 22/08/2005 ?
SELECT payment_date FROM sakila.payment
WHERE DATE(payment_date) BETWEEN '2005/07/01' AND '2005/08/22';
-- 3 Usando a tabela rental , extraia data, ano, mês, dia, hora, minuto e segundo dos registros com rental_id = 10330. Utilize a coluna rental_date para extrair as informações.
SELECT CONCAT(
DATE(rental_date),
' ',
DAY(rental_date),
' ',
MONTH(rental_date),
' ',
YEAR(rental_date),
' ',
TIME(rental_date),
' ',
MINUTE(rental_date),
' ',
SECOND(rental_date)
) AS 'Specific Infos' FROM sakila.rental
WHERE rental_id = 10330;
-- 4 Monte uma query que retorne todos os dados do pagamento feito no dia 28/07/2005 a partir das 22 horas.
SELECT * FROM sakila.payment
WHERE DATE(payment_date) = '2005/07/28'
AND HOUR(payment_date) >= 22;

----------------------------------------------------------------------------
