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
-- Criar consultas mais dinâmicas e maleáveis com LIKE .
-- Fazer consultas que englobam uma faixa de resultados com IN e BETWEEN .
-- Encontrar e separar resultados que incluem datas.