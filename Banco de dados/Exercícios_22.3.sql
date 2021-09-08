-- Exercícios relacionados ao [Bloco 22, Dia 3].

-- Desafios sobre VIEW
-- Crie uma view chamada film_with_categories utilizando as tabelas category , film_category e film do banco de dados sakila . Essa view deve exibir o título do filme, o id da categoria e o nome da categoria, conforme a imagem abaixo. Os resultados devem ser ordenados pelo título do filme.

CREATE VIEW film_with_categories AS
SELECT
f.title, c.category_id, cy.name
FROM sakila.film AS f
INNER JOIN sakila.film_category AS c
ON c.film_id = f.film_id
INNER JOIN sakila.category AS cy
ON cy.category_id = c.category_id
ORDER BY f.title;

select * from film_with_categories;


-- Os exercícios seguintes sobre VIEW seguem a mesma lógica, logo, não serão feitos.

