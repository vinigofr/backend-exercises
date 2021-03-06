-- Tabela vazia ? Vamos resolver isso ae! INSERT na prática
-- Inserindo dados em uma coluna específica:
INSERT INTO nome_da_tabela (coluna1, coluna2)
VALUES ('valor_coluna1', 'valor_coluna2');

-- Caso mais de algum valor precise ser inserido, a seperação
-- ocorrerá por vírgulas.
INSERT INTO nome_da_tabela (coluna1, coluna2) VALUES
('valor_coluna1', 'valor_coluna2'),
('valor2_coluna1', 'valor_2_coluna2'),
('valor3_coluna1', 'valor_3_coluna2');

-- Ignorando linhas existentes com o IGNORE
-- Basicamente, ele serve para IGNORAR problemas, como linhas iguais, por exemplo.
-- Considerando a seguinte tabela
----------------------
-- |  id | name      |
-- |  1  | Nissim    |
-- |  2  | Garrison  |
-- |  3  | Benjamin  |
-- |  4  | Gloria    |
----------------------

INSERT IGNORE INTO pessoas (id, name) VALUES
(4,'Gloria'), -- Sem o IGNORE, essa linha geraria um erro e o INSERT não continuaria.
(5,'Amanda');

-- Pesquisando agora, você verá que a informação duplicada não foi inserida.
-- Porém os dados corretos foram inseridos com sucesso.
SELECT * FROM pessoas;

----------------------
-- |  id | name      |
-- |  1  | Nissim    |
-- |  2  | Garrison  |
-- |  3  | Benjamin  |
-- |  4  | Gloria    |
-- |  5  | Amanda    |
----------------------

--------------------------

-- Inserindo valores em colunas com o auto_increment, será N+1.
INSERT INTO sakila.actor (first_name, last_name)
VALUES('Marcelo','Santos');
-- Ta script acima tem como primeira coluna, actor_id, porém, o auto_increment está ativo.
-- Tal coluna pode ser omitida no INSERT.

--------------------------

-- Inserindo dados de outra tabela com o INSERT SELECT
-- É possível inserir dados a partir de outra tabela usando INSERT INTO SELECT
INSERT INTO tabelaA (coluna1, coluna2)
    SELECT tabelaB.coluna1, tabelaB.coluna2
    FROM tabelaB
    WHERE tabelaB.nome_da_coluna <> 'algumValor'
    ORDER BY tabelaB.coluna_de_ordenacao;

--É possível usar também SELECT * FROM e copiar todos os dados de 
-- todas as colunas de uma tabela para outra, mas nessa situação a 
-- tabelaA e a tabelaB precisam obrigatoriamente possuir a mesma quantidade
-- de colunas, e os tipos de dados das colunas correspondentes devem ser iguais.

-- Outro exemplo;
INSERT INTO sakila.actor (first_name, last_name)
  SELECT first_name, last_name FROM sakila.staff;

-- Atividade de fixação
--1 Insira um novo funcionário na tabela sakila.staff.
INSERT INTO sakila.staff 
(first_name, last_name, address_id, email, store_id, active, username, password)
VALUES 
('Vinicius', 'Gouveia', 2, 'hahaha.com.br', 1, 1, 'vinigofr', 'password');
--2 Feito o exercício anterior, vamos agora para o nível 2. Insira dois funcionários novos em apenas uma query.
INSERT INTO sakila.staff 
(first_name, last_name, address_id, email, store_id, active, username, password)
VALUES 
('Augusto', 'Almeida', 2, 'hahaha.com.br', 1, 1, 'vinigofr', 'password'),
('Junior', 'Mizerable', 2, 'hahaha.com.br', 1, 1, 'vinigofr', 'password');
--3 Selecione os cinco primeiros nomes e sobrenomes da tabela sakila.customer
-- e cadastre essas pessoas como atores na tabela sakila.actor.
INSERT INTO sakila.actor (first_name, last_name)
SELECT first_name, last_name FROM sakila.customer
LIMIT 5;
--4 Cadastre três categorias de uma vez só na tabela sakila.category.
SELECT * FROM sakila.category;
SELECT * FROM sakila.customer;

INSERT INTO sakila.category (name)
VALUES ('CatA'), ('CatB'), ('CatB');
--5 Cadastre uma nova loja na tabela sakila.store.
USE sakila;
SELECT * from store;

INSERT INTO store (manager_staff_id, address_id)
VALUES (3, 3);

--------------------------
-- O UPDATE permite alterar valores de uma tabela com base em alguma condição!
-- exemplo:
-- 1 Seleção da tabela a ser atualizada:
UPDATE sakila.staff
-- 2 Parâmetro para adição, selecionando a coluna
SET first_name = 'Rannveig'
-- 3 Parâmetro condincional, selecionando coluna
WHERE first_name = 'Ravein';
-- importantíssimo aplicar o WHERE para não alterar a tabela inteira!

-- Uma curiosidade sobre o UPDATE e o DELETE no MySQL Server é que, por padrão, 
-- existe uma configuração chamada safe updates mode que só vai te permitir executá-los 
-- caso eles incluam quais IDs devem ser modificados. Então, caso você tente fazer 
-- a query abaixo, ela não funcionaria por não incluir o ID.

-- Para evitar essa restrição, rode o seguinte comando em uma janela de query dentro 
-- do MySQL Workbench sempre que abri-lo para desabilitar essa funcionalidade, antes de 
-- executar seus comandos de UPDATE ou DELETE :
SET SQL_SAFE_UPDATES = 0;

-- Tá, mas e pra atualizar mais de uma coluna?
UPDATE sakila.staff
SET first_name = 'Rannveig', last_name = 'Jordan'
WHERE staff_id = 4;

-- Pode-se também fazer um update em massa, isso evita gasto desnecessário de dados e não
-- sobrecarrega o servidor
-- Opção 1 - Incluindo a lista de condições fixas
UPDATE sakila.actor
SET first_name = 'JOE'
WHERE actor_id IN (1,2,3);

-- Opção 2 - Especificando como cada entrada será alterada individualmente
UPDATE sakila.actor
SET first_name = (
CASE actor_id 
    WHEN 1 THEN 'JOE' -- se actor_id = 1, alterar first_name para 'JOE'
    WHEN 2 THEN 'DAVIS' -- se actor_id = 2, alterar first_name para 'DAVIS'
    WHEN 3 THEN 'CAROLINE' -- se actor_id = 3, alterar first_name para 'CAROLINE'
      ELSE first_name -- em todos os outros casos, mantém-se o first_name
END);

-- Fazendo UPDATE de forma sequencial, pera, pera.... Mas o que isso significa?
-- Se o comando ORDER BY for usado juntamente com o UPDATE , os resultados serão alterados na ordem em que forem encontrados.
-- Se o comando LIMIT for usado em conjunto com o UPDATE , um limite será imposto na quantidade de resultados que podem ser alterados.
-- Caso contrário, todos os resultados que satisfizerem a condição serão atualizados.
-- Exemplo:
UPDATE nome_da_tabela
SET coluna1 = valor1, coluna2 = valor2
[WHERE condições]
[ORDER BY expressao [ ASC | DESC ]]
[LIMIT quantidade_resultados];

-- Exemplo prático:
UPDATE sakila.staff
SET password = 'FavorResetarSuaSenha123'
WHERE active = 1
ORDER BY last_update
LIMIT 2;

--------------------------

-- Atividade de UPDATE
-- 1. Atualize o primeiro nome de todas as pessoas da tabela sakila.actor que possuem o primeiro nome "JULIA" para "JULES".
UPDATE sakila.actor
SET first_name = 'JULES'
WHERE first_name = 'JULIA';

-- 2. Foi exigido que a categoria "Sci-Fi" seja alterada para "Science Fiction".
UPDATE sakila.category
SET name = 'Science Fiction'
WHERE name = 'Sci-Fi';
-- Atualize o valor do aluguel para $25 de todos os filmes com duração maior que 100 minutos e que possuem a
--classificações "G" , "PG" ou "PG-13" e um custo de substituição maior que $20.
UPDATE sakila.film
SET replacement_cost = 25
WHERE `length` > 100 AND rating IN ('PG', 'PG-13', 'G');

-- Foi determinado pelo setor financeiro que haverá um reajuste em todos os 
-- preços dos filmes, com base em sua duração. Para todos os filmes com duração 
-- entre 0 e 100, o valor do aluguel passará a ser $10,00, e o aluguel dos filmes
-- com duração acima de 100 passará a ser de $20,00.
UPDATE sakila.film
SET rental_rate = (
	CASE WHEN LENGTH <= 100 THEN 10
    WHEN LENGTH > 100 THEN 20
    ELSE rental_rate
    END);

-- Agora, vamos aprender a manipular tabelas usando o DELETE!

-- Excluindo de forma básica:
DELETE FROM banco_de_dados.tabela
WHERE coluna = 'valor';
-- O WHERE é opcional. Porém, sem ele, todas as linhas da tabela seriam excluídas.

-- Exemplo prático:
DELETE FROM sakila.film_text
WHERE title = 'ACADEMY DINOSAUR';

-- Restrição / Restrições com o DELETE
-- Caso haja relações entre as tabelas ( primary key e foreign keys ) e 
-- existam restrições aplicadas a elas, ao executar o DELETE ocorrerá 
-- uma ação de acordo com a restrição que tiver sido imposta na criação 
-- da foreign key . Essas restrições podem ser as seguintes:

-- Rejeita o comando DELETE.
ON DELETE NO ACTION;

-- Rejeita o comando DELETE.
ON DELETE RESTRICT;

-- Permite a exclusão dos registros da tabela pai, e seta para NULL os registros da tabela filho.
ON DELETE SET NULL;

-- Exclui a informação da tabela pai e registros relacionados.
ON DELETE CASCADE;

-- Vamos analisar um exemplo prático:
DELETE FROM sakila.actor
WHERE first_name = 'GRACE';
-- Se tentar rodar essa query , você vai se deparar com o erro exibido: Erro ON DELETE RESTRICT

-- O banco de dados não vai permitir que você delete o ator chamado "GRACE". 
-- Isso acontece porque a coluna actor_id da tabela film_actor é uma chave 
-- estrangeira ( foreign key ) que aponta para a coluna actor_id na tabela actor 
-- , e essa chave estrangeira possui a restrição ON DELETE RESTRICT . Se essa 
-- restrição não existisse, o ator seria deletado, deixando nosso banco de dados 
-- em um estado inconsistente, pois haveria linhas na tabela film_actor com um 
-- actor_id que não mais existiria! Para conseguir excluir este ator em actors , 
-- precisamos primeiro excluir todas as referências a ele na tabela sakila.film_actor :

DELETE FROM sakila.film_actor
WHERE actor_id = 7; -- actor_id = 7 é o Id de GRACE

-- Após excluir as referências, podemos excluir o ator com o nome "GRACE":
DELETE FROM sakila.actor
WHERE first_name = 'GRACE';

-- Diferença de DELETE vs TRUNCATE
-- TRUNCATE: Sem possiblidade de regras condicionais, possibilitando apenas apagar
-- uma tabela por completo, sem deixar "rastros". Cenário TRUNCATE:
TRUNCATE banco_de_dados.tabela;

-- DELETE: Permite condicionais de exclusão de locais mais específicos.
-- Famoso DELETE com WHERE

-- Atividade de fixação sobre DELETE:
-- 1. Exclua do banco de dados o ator com o nome de "KARL".
-- Primeiro, desafivar atualizações seguras.
SET SQL_SAFE_UPDATES = 0;

-- Segundo, deletar informações daquele autor em chaves estrangeiras.
DELETE FROM sakila.film_actor
WHERE actor_id = 12;

-- Depois deletar ta tabela de atores, pois a partir dali a informação ficou inconsistente.
DELETE FROM sakila.actor
WHERE first_name = 'KARL';

-- 2. Exclua do banco de dados os atores com o nome de "MATTHEW".
DELETE FROM sakila.film_actor
WHERE actor_id IN (SELECT actor_id FROM sakila.actor WHERE first_name = 'MATTHEW');

DELETE from sakila.actor
WHERE first_name = 'MATTHEW';
-- 3. Exclua da tabela film_text todos os registros que possuem a palavra "saga" em suas descrições.
DELETE FROM sakila.film_text
WHERE description
-- 4. Apague da maneira mais performática possível todos os registros das tabelas film_actor e film_category .
DELETE FROM sakila.film_text
where description LIKE '%saga%';
-- 5. Inspecione todas as tabelas do banco de dados sakila e analise quais restrições ON DELETE foram impostas 
-- em cada uma. Use o Table Inspector para fazer isso (aba DDL).
sakila.inventory
sakila.address
sakila.city
sakila.customer
sakila.film
sakila.film_actor
sakila.film_category
sakila.payment
sakila.rental
sakila.staff
sakila.store
-- 6. Exclua o banco de dados e o recrie (use as instruções no início desta aula).
drop database sakila;

-- Atividade final dia 20.4

-- DB Utilizado:
DROP SCHEMA IF EXISTS Pixar;
CREATE SCHEMA Pixar;
USE Pixar;

CREATE TABLE Movies (
  id INTEGER auto_increment PRIMARY KEY NOT NULL,
  title VARCHAR(30) NOT NULL,
  director VARCHAR(30) NULL,
  year INT NOT NULL,
  length_minutes INT NOT NULL
);

CREATE TABLE BoxOffice (
  movie_id INTEGER,
  FOREIGN KEY (movie_id) REFERENCES Movies (id),
  rating DECIMAL(2,1) NOT NULL,
  domestic_sales INT NOT NULL,
  international_sales INT NOT NULL
);

INSERT INTO Movies(title, director, year, length_minutes)
  VALUES ('Toy Story', 'John Lasseter', 1995, 81),
         ('Vida de inseto', 'Andrew Staton', 1998, 95),
         ('ratatui', 'Brad Bird', 2010, 115),
         ('UP', 'Pete Docter', 2009, 101),
         ('Carros', 'John Lasseter', 2006, 117),
         ('Toy Story 2', 'John Lasseter', 1999, 93),
         ('Valente', 'Brenda Chapman', 2012, 98);


INSERT INTO BoxOffice(movie_id, rating, domestic_sales, international_sales)
  VALUES (1, 8.3, 190000000, 170000000),
         (2, 7.2, 160000000, 200600000),
         (3, 7.9, 245000000, 239000000),
         (4, 6.1, 330000000, 540000000),
         (5, 7.8, 140000000, 310000000),
         (6, 5.8, 540000000, 600000000),
         (7, 7.5, 250000000, 190000000);

-- Questões:
-- Exercício 1 : Insira as produções da Pixar abaixo na tabela Movies:
INSERT INTO Pixar.Movies 
(title, director, year, length_minutes)
VALUES
('Monstros SA', 'Pete Docter', 2001, 92),
('Procurando Nemo', 'John Lasseter', 2003, 107),
('Os Incríveis', 'Brad Bird', 2004, 116),
('WALL-E', 'Pete Docter', 2008, 104);

-- Exercício 2 : Procurando Nemo foi aclamado pela crítica! Foi classificado em 6.8,
-- fez 450 milhões no mercado interno e 370 milhões no mercado internacional.
-- Adicione as informações à tabela BoxOffice.
INSERT INTO Pixar.BoxOffice (movie_id, rating, domestic_sales, international_sales)
VALUES
((SELECT id FROM Pixar.Movies WHERE title LIKE '%nemo%' ) - 1, 6.8, 450000000, 370000000);

-- Exercício 3 : O diretor do filme "Procurando Nemo" está incorreto,
-- na verdade ele foi dirigido por Andrew Staton. Corrija esse dado utilizando o UPDATE.
SET SQL_SAFE_UPDATES = 0;
UPDATE Pixar.Movies
SET director = 'Andrew Staton'
WHERE title = 'Procurando Nemo';

-- Exercício 4 : O título do filme "Ratatouille" esta escrito de forma incorreta 
-- na tabela Movies , além disso, o filme foi lançado em 2007 e não em 2010.
SET SQL_SAFE_UPDATES = 0;
UPDATE Pixar.Movies
SET title = 'Rato Tulho', year = 2007
WHERE title = 'ratatui';

-- Exercício 5 : Insira as novas classificações abaixo na tabela BoxOffice,
-- lembre-se que a coluna movie_id é uma foreign key referente a coluna id da tabela Movies :
INSERT INTO BoxOffice(movie_id, rating, domestic_sales, international_sales)
  VALUES (8, 8.5, 300000000, 250000000),
         (10, 7.4, 460000000, 510000000),
         (11, 9.9, 290000000, 280000000);

--  Exercício 6 : Exclua da tabela Movies o filme "WALL-E".
DELETE FROM BoxOffice
WHERE movie_id = 11; -- este é o id do filme WALL-E

DELETE FROM Movies 
WHERE title = 'WALL-E';

-- Exercício 7 : Exclua da tabela Movies todos os filmes dirigidos por "Andrew Staton".
SELECT id FROM Movies
WHERE director = 'Andrew Staton';
-- primeiro é utilizada essa query para selecionar os ids dos filmes a serem excluídos (2 e 9)

DELETE FROM BoxOffice
WHERE movie_id IN (2, 9);
 
DELETE FROM Movies
WHERE director = 'Andrew Staton';
