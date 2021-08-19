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

-- Tratando dados com o DISTINCT, como por exemplo, fazer uma remoção.
USE sakila;

-- Seleciona colunas para exibição.
SELECT first_name, last_name from actor;

-- Seleciona colunas, porém remove as que tem dados repetidos.
SELECT DISTINCT first_name, last_name FROM actor;

-- Script para criação do DB, para aproveitamento da atividade abaixo:
Create database escola;
USE escola;

CREATE TABLE IF NOT EXISTS escola.alunos (
    `Nome` VARCHAR(7) CHARACTER SET utf8,
    `Idade` INT
);

INSERT INTO escola.alunos VALUES
	('Rafael', 25),
    ('Amanda', 30),
    ('Roberto', 45),
    ('Carol', 19),
    ('Amanda', 25;
-- Pequena atividade de cinco questões.
USE escola;

-- Monte uma query para encontrar pares únicos de nomes e idades .
SELECT DISTINCT Nome, Idade FROM alunos;

-- Quantas linhas você encontraria na query anterior?
5;

-- Monte uma query para encontrar somente os nomes únicos.
SELECT DISTINCT Nome FROM alunos;

-- Quantas linhas você encontraria na query anterior?
4;

-- Monte uma query para encontrar somente as idades únicas.
SELECT DISTINCT Idade FROM alunos;

-- Quantas linhas você encontraria na query anterior?
4;

-------------------------------------------------

-- Contanto resultados com o COUNT
-- Começando por um exemplo básico:
-- MySQL, traga pra, em coluna x, palavras que tenham 'Alagoas'
SELECT COUNT(cidades) FROM brasil
WHERE cidades = 'Alagoas';
-- Provavelmente esse resultado retornará um valor 1
--
-- Sobre sakila: sakila.staff
USE sakila
-- Quantas senhas temos cadastradas nessa tabela?
SELECT count(password) FROM staff WHERE password != '';
1;

-- Quantas pessoas temos no total trabalhando para nossa empresa?
SELECT count(staff_id) FROM staff;
2;

-- Quantos emails temos cadastrados nessa tabela?
SELECT count(email) FROM staff;
2;

-------------------------------------------------

-- Limitando resultados com LIMIT
SELECT * FROM sakila.rental LIMIT 10;
-- O código acima faz uso da palavra reservada LIMITE, que
-- ao lado pode receber um número como fator limitante.

-- Limitando linhas, pulando outras.
-- Para pular uma certa quantidade de linhas do resultado -> OFFSET.
SELECT * FROM rental LIMIT 10 OFFSET 3;
-- Onde LIMIT é o limite de resultados e OFFSET é a
-- quantidade de primeiras linhas que queremos excluir. 
--
-- Quando queremos resultados específicos com o FROM, WHERE e LIMIT.
SELECT inventory_id FROM rental WHERE inventory_id = 4 LIMIT 1;

-------------------------------------------------

-- Agora, um pouco de ORDER BY:
-- Ordenando dados a partir de uma coluna;
SELECT * FROM sakila.address
ORDER BY address (ASC || DESC);
-- Dentro de parênteses, pode ir ASC ou DESC, dependendo da forma
-- como os dados serão organizados.
--
-- OK, ok, mas e por mais de uma columa?
-- É só passar a segunda coluna como parâmetro, como exemplo abaixo:
SELECT * FROM sakila.address
ORDER BY address(ASC || DESC), district(ASC || DESC);
-- As columas podem ser ordenadas separadamente.

