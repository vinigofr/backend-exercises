-- Stored Routines e Stored Functions, ferramentas que nos ajudarão a criar blocos de código reutilizáveis dentro do banco de dados.
-- TRIGGERS, que permite construir blocos de código que serão disparados de acordo com alguma ação (inserção, atualização, remoção).

-- Sintaxe padrão de um stored procedure:

-- Utilizando parâmetros:
USE banco_de_dados; -- obrigatório para criar a procedure no banco correto
DELIMITER $$ -- definindo delimitador

CREATE PROCEDURE nome_da_procedure(@parametro1, @parametro2, ..., @parametroN) -- parâmetros
BEGIN -- delimitando o início do código SQL
-- código SQL
END $$ -- delimitando o final do código SQL

DELIMITER ; -- muda o delimitador de volta para ; - o espaço entre DELIMITER e o ';' é necessário

-- Sem a utilização de parâmetros:
USE sakila;
DELIMITER $$

CREATE PROCEDURE ShowAllActors()
BEGIN
    SELECT * FROM sakila.actor;
END $$

DELIMITER ;

-- Depois:

CALL ShowAllActors();

-- Tipos de dados utilizados nos parâmetros da procedure:
-- 1. IN - parâmetro de entrada
-- 2. OUT - parâmetro de saída
-- 3. IN-OUT - parâmetro de entrada e saída
-- 4. Sem parâmetro - não é necessário definir o tipo de dado ou o do parâmetro.

-- OUT: O parâmetro OUT é útil quando você precisa que algo seja avaliado ou encontrado
-- dentro de uma query e te retorne esse valor para que algo adicional possa ser feito com ele.

-- Exemplo: Estamos recebendo aqui o título de um filme como valor de entrada e depois buscando
-- dentro da procedure a duração média de um empréstimo daquele filme. Feito isso, ele é inserido 
-- em uma variável que pode ser usada posteriormente.
USE sakila;
DELIMITER $$

CREATE PROCEDURE ShowAverageRentalDurationOfMovie(
    IN film_name VARCHAR(300),
    OUT media_aluguel_em_dias DOUBLE
)
BEGIN
    SELECT AVG(rental_duration) INTO media_aluguel_em_dias
    FROM sakila.film
    WHERE title = film_name;
END $$

DELIMITER ;

-- Como usar:

CALL ShowAverageRentalDurationOfMovie('ACADEMY DINOSAUR', @media_de_dias);
SELECT @media_de_dias;


-- IN-OUT: deve ser usado quando é necessário que um
-- parâmetro possa ser modificado tanto antes como durante a execução de uma procedure.

-- Exemplo: Estamos gerando um novo nome para um filme, usando como base a variável film_name,
-- que deve ser criada e passada como parâmetro para a procedure. O parâmetro sofrerá alterações
-- dentro da procedure, podendo ser usado posteriormente com o novo nome.

USE sakila;
DELIMITER $$

CREATE PROCEDURE NameGenerator(INOUT film_name VARCHAR(300))
BEGIN
    SELECT CONCAT('ULTRA ', film_name, ' THE BEST MOVIE OF THE CENTURY')
    INTO film_name;
END $$

DELIMITER ;

-- Como usar:

SELECT 'ACE GOLDFINGER' INTO @movie_title;
CALL NameGenerator(@movie_title);
SELECT @movie_title;

-- Procedimento armazenado - DESAFIO:
-- Monte uma procedure que exiba os 10 atores mais populares, baseado em sua quantidade
-- de filmes. Essa procedure não deve receber parâmetros de entrada ou saída e, quando
-- chamada, deve exibir o id do ator ou atriz e a quantidade de filmes em que atuaram.
USE sakila;
DELIMITER $$

create procedure top10()
begin
	SELECT actor_id, COUNT(*) AS `quantidade`
	FROM film_actor
	GROUP BY actor_id
	order by quantidade desc
	limit 10;
END $$

DELIMITER ;

call top10;

-- Monte uma procedure que receba como parâmetro de entrada o nome da categoria desejada em uma
-- string e que exiba o id do filme , seu titulo , o id de sua categoria e o nome da categoria
-- selecionada. Use as tabelas film , film_category e category para montar essa procedure.
USE sakila;
DELIMITER $$

CREATE PROCEDURE FilmInformation(IN film_name VARCHAR(200))
BEGIN
  SELECT film_name;
END $$
DEMILITER ;