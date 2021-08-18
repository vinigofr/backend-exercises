-- Primeiros passos com SELECT.
-- Select é o primeiro passo. É o comando que será amplamente utilizado.

SELECT 'Olá, bem-vindo ao SQL!';
SELECT 10;
SELECT now();
SELECT 20 * 2;
SELECT 50 / 2;
SELECT 18 AS idade;
SELECT 2019 AS ano;
SELECT 'Rafael', 'Martins', 25, 'Desenvolvedor Web';
SELECT 'Rafael' AS nome, 'Martins' AS sobrenome, 25 AS idade, 'Desenvolvedor Web' AS 'Área de atuação';

-- Realização de buscas em um banco de dados.
-- DB Utilizada: sakila.
USE sakila;

-- Escreva uma query que selecione todas as colunas da tabela city ;
SELECT * FROM city;

-- Escreva uma query que exiba apenas as colunas first_name e last_name da tabela customer ;
SELECT first_name e last_name FROM customer;

-- Escreva uma query que exiba todas as colunas da tabela rental ;
SELECT * FROM rental;

-- Escreva uma query que exiba o título, a descrição e a data de lançamento dos filmes registrados na tabela film ;
SELECT title, description, release_year FROM film;

-- Utilize o SELECT para explorar todas as tabelas do banco de dados.
SELECT * FROM actor;
SELECT * FROM address;
SELECT * FROM category;
SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM customer;
SELECT * FROM film;
SELECT * FROM film_actor;
SELECT * FROM film_category;
SELECT * FROM film_text;
SELECT * FROM *inúmeros que não foram citados*;
-------------------------------------------------


-- Unificando coisas com o CONCAT
-- Habilita o uso do DB Salika
USE salika;

-- Seleciona as colunas a serem "misturadas". Elas serão passadas como parâmetro
-- da função CONCAT.
-- A palavra reservada AS serve como um apelido para o novo nome de coluna.
SELECT CONCAT(first_name, ' ', last_name) AS 'Nome Completo' FROM actor;
SELECT CONCAT(first_name, ' ', last_name) FROM actor;

-- Seleciona as colunas título e ano_de_lançamento e faz uma nova coluna.
SELECT CONCAT('Título: ', title,' - ', release_year) AS Lançamento do filme FROM film;
-------------------------------------------------
