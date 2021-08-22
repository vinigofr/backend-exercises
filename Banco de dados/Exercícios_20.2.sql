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

 INTO escola.alunos VALUES
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

-- Exercício de fixação 20.2
-- Para os exercícios a seguir, vamos usar a tabela sakila.film
USE sakila;
--
-- Escreva uma query que exiba todos os filmes cadastrados no banco de dados.
SELECT * from film;
--
-- Escreva uma query que exiba apenas o nome dos filmes, seu ano de lançamento e sua classificação.
SELECT title, release_year, rating from film;
--
-- Quantos filmes temos cadastrados?
SELECT COUNT(*) FROM film;

-- Para os exercícios a seguir, vamos usar a tabela sakila.actor
-- Escreva uma query que exiba apenas os sobrenomes únicos cadastrados.
SELECT DISTINCT last_name FROM actor;
-- Quantos sobrenomes únicos temos na tabela?
SELECT COUNT(DISTINCT last_name) FROM actor;
--
-- Ordene os valores na tabela em ordem crescente de sobrenomes e em ordem decrescente de nome.
SELECT last_name, first_name FROM actor
ORDER BY last_name ASC, first_name DESC;
--
-- Vá até a tabela language do sakila e crie uma pesquisa que mostre os 5 idiomas cadastrados,
-- mas não mostre o idioma english.
SELECT * FROM language
WHERE name <> 'english';
--
-- Agora vamos tentar fazer o seguinte: Crie uma query para encontrar os 20 primeiros filmes,
-- incluindo o título , o ano de lançamento , a duração , a classificação indicativa e o custo
-- de substituição . Ordene os resultados pelos filmes com a maior duração e depois pelo menor
-- custo de substituição.
SELECT title, release_year, rental_duration, rating, replacement_cost FROM film
ORDER BY rental_duration DESC, rating ASC
LIMIT 20;

-- Exercício final MySQL 20.2
-- Script Abaixo
DROP SCHEMA IF EXISTS Scientists;
CREATE SCHEMA Scientists;
USE Scientists;

CREATE TABLE Scientists (
  SSN INT,
  Name CHAR(30) NOT NULL,
  PRIMARY KEY (SSN)
);

CREATE TABLE Projects (
  Code CHAR(4),
  Name CHAR(50) NOT NULL,
  Hours INT,
  PRIMARY KEY (Code)
);

CREATE TABLE AssignedTo (
  Scientist INT NOT NULL,
  Project CHAR(4) NOT NULL,
  PRIMARY KEY (Scientist, Project),
  FOREIGN KEY (Scientist) REFERENCES Scientists (SSN),
  FOREIGN KEY (Project) REFERENCES Projects (Code)
);

INSERT INTO Scientists(SSN,Name)
  VALUES(123234877, 'Michael Rogers'),
    (152934485, 'Anand Manikutty'),
    (222364883, 'Carol Smith'),
    (326587417, 'Joe Stevens'),
    (332154719, 'Mary-Anne Foster'),
    (332569843, 'George ODonnell'),
    (546523478, 'John Doe'),
    (631231482, 'David Smith'),
    (654873219, 'Zacary Efron'),
    (745685214, 'Eric Goldsmith'),
    (845657245, 'Elizabeth Doe'),
    (845657246, 'Kumar Swamy');

 INSERT INTO Projects (Code, Name, Hours)
  VALUES ('AeH1' ,'Winds: Studying Bernoullis Principle', 156),
    ('AeH2', 'Aerodynamics and Bridge Design', 189),
    ('AeH3', 'Aerodynamics and Gas Mileage', 256),
    ('AeH4', 'Aerodynamics and Ice Hockey', 789),
    ('AeH5', 'Aerodynamics of a Football', 98),
    ('AeH6', 'Aerodynamics of Air Hockey', 89),
    ('Ast1', 'A Matter of Time', 112),
    ('Ast2', 'A Puzzling Parallax', 299),
    ('Ast3', 'Build Your Own Telescope', 6546),
    ('Bte1', 'Juicy: Extracting Apple Juice with Pectinase', 321),
    ('Bte2', 'A Magnetic Primer Designer', 9684),
    ('Bte3', 'Bacterial Transformation Efficiency', 321),
    ('Che1', 'A Silver-Cleaning Battery', 545),
    ('Che2', 'A Soluble Separation Solution', 778);

 INSERT INTO AssignedTo (Scientist, Project)
  VALUES (123234877, 'AeH1'),
    (152934485, 'AeH3'),
    (222364883, 'Ast3'),
    (326587417, 'Ast3'),
    (332154719, 'Bte1'),
    (546523478, 'Che1'),
    (631231482, 'Ast3'),
    (654873219, 'Che1'),
    (745685214, 'AeH3'),
    (845657245, 'Ast1'),
    (845657246, 'Ast2'),
    (332569843, 'AeH4');


-- 1 Escreva uma query para exibir a string "This is SQL Exercise, Practice and Solution".
SELECT 'This is SQL Exercise, Praactive and Solution' AS Presentation;
-- 2 Escreva uma query para exibir três números em três colunas.
SELECT 3 AS Three, 2 AS Two, 1 AS One;
-- 3 Escreva uma query para exibir a soma dos números 10 e 15.
SELECT 10 + 15;
-- 4 Escreva uma query para exibir o resultado de uma expressão aritmética qualquer.
SELECT 10 + 15;
-- 5 Escreva uma query para exibir todas as informações de todos os cientistas.
SELECT * FROM Scientists;
-- 6 Escreva uma query para exibir o nome como "Nome do Projeto" e as horas como "Tempo de Trabalho" de cada projeto.
SELECT Name AS 'Nome do Projeto', Hours AS 'Tempo de Trabalho' FROM Scientists.Projects;
-- 7 Escreva uma query para exibir o nome dos cientistas em ordem alfabética.
SELECT Name FROM Scientists.Projects ORDER BY Name ASC;
-- 8 Escreva uma query para exibir o nome dos Projetos em ordem alfabética descendente.
SELECT * FROM Scientists.Projects ORDER BY Name DESC;
-- 9 Escreva uma query que exiba a string "O projeto Name precisou de Hours horas para ser concluído." para cada projeto.
SELECT CONCAT('O projeto ', Name, ' precisou de ', Hours, ' horas para ser concluído') 
AS Resumo FROM Scientists.Projects;
-- 10 Escreva uma query para exibir o nome e as horas dos três projetos com a maior quantidade de horas.
SELECT * FROM Scientists.Projects ORDER BY Hours DESC LIMIT 3;
-- 11 Escreva uma query para exibir o código de todos os projetos da tabela AssignedTo sem que haja repetições.
SELECT DISTINCT(Code) FROM Scientists.Projects;
-- 12 Escreva uma query para exibir o nome do projeto com maior quantidade de horas.
SELECT * FROM Scientists.Projects ORDER BY Hours DESC LIMIT 1;
-- 13 Escreva uma query para exibir o nome do segundo projeto com menor quantidade de horas.
SELECT * FROM Scientists.Projects ORDER BY Hours LIMIT 1 OFFSET 1;
-- 14 Escreva uma query para exibir todas as informações dos cinco projetos com a menor quantidade de horas.
SELECT * FROM Scientists.Projects
ORDER BY Hours LIMIT 5;
-- 15 Escreva uma query que exiba a string "Existem Number cientistas na tabela Scientists.", em que Number se refira a quantidade de cientistas.
SELECT CONCAT('Existem ', COUNT(Name), ' cientistas na tabela de Scientists') AS INFO FROM Scientists.Scientists;