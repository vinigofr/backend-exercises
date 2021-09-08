-- Este arquivo refere-se ao conteúdo do dia 22.3
-- que trata sobre a transformação de ideias em um
-- modelo de banco de dados.

-- Habilidades que foram adquiridas:
-- Clonar tabelas existentes;
-- Lidar com VIEWs;
-- Alterar tabelas existentes;
-- Deletar uma tabela;
-- Usar um INDEX.

-- Clonando tabelas existentes
-- O método abaixo copia apenas a estrutura
-- Sintaxe:
USE [BANCO]
CREATE TABLE nome_para_nova_tabela LIKE tabela_a_ser_clonada;
-- Caso de uso:
CREATE TABLE actor_clone LIKE sakila.actor;
-- Mais um caso de uso:
-- Caso o banco de dados não seja especificado, a nova tabela
-- será inserida no banco de dados que está em uso.
-- Sendo assim, é importante sempre usar o comando USE [banco]
USE nome_do_banco_de_dados;
CREATE TABLE nome_para_nova_tabela LIKE tabela_a_ser_clonada;


-- Lidando com VIEWs:
-- Esse método cria uma tabela temporária no próprio banco de dados
-- Essa tabela pode ser consultada como uma tabela normal
-- Ela é criada a partir de uma QUERY SQL

-- Além disso um VIEW permite:
-- Ter uma tabela que pode ser usada em relatórios;
-- Ter uma tabela para usar como base para montar novas queries;
-- Reduzir a necessidade de recriar queries utilizadas com frequência.

-- Caso de uso:
-- Defina em qual banco a view será criada
USE nome_do_banco_de_dados;
-- Comando para criar a view
CREATE VIEW nome_da_view AS query;

-- Um exemplo de uso
-- Suponha que a gerência quer ter uma maneira simples para sempre saber
-- quem são os top 10 clientes que mais compram com a empresa.
-- Pode-se criar uma view para resolver isso!
CREATE VIEW top_10_customers AS
    SELECT c.customer_id, c.first_name, SUM(p.amount) AS total_amount_spent
    FROM sakila.payment p
    INNER JOIN sakila.customer c ON p.customer_id = c.customer_id
    GROUP BY customer_id
    ORDER BY total_amount_spent DESC
    LIMIT 10;

-- Para acessar, basta acessar com um SELECT
SELECT * FROM top_10_customers;

-- Para excluir uma VIEW, basta executar o comando
DROP VIEW nome_da_view;

-- Conteúdo sobre ALTER TABLE
-- Tabela usada como referência para os exemplo:
USE sakila;
CREATE TABLE noticia(
    noticia_id INT PRIMARY KEY,
    titulo VARCHAR(100),
    historia VARCHAR(300)
) engine = InnoDB;

-- Adicionar uma nova coluna
ALTER TABLE noticia ADD COLUMN data_postagem date NOT NULL;

-- Modificar o tipo e propriedades de uma coluna
ALTER TABLE noticia MODIFY noticia_id BIGINT;

-- Adicionar incremento automático a uma coluna
-- (especifique o tipo da coluna + auto_increment)
ALTER TABLE noticia MODIFY noticia_id BIGINT auto_increment;

-- Alterar o tipo e nome de uma coluna
ALTER TABLE noticia CHANGE historia conteudo_postagem VARCHAR(1000) NOT NULL;

-- Dropar/Excluir uma coluna
ALTER TABLE noticia DROP COLUMN data_postagem;

-- Adicionar uma nova coluna após outra
ALTER TABLE noticia ADD COLUMN data_postagem DATETIME NOT NULL AFTER titulo;

-- DROPando uma tabela
DROP TABLE nome_da_tabela; -- Para excluir uma tabela existente

-- PONTO IMPORTANTE:
-- Você não conseguirá dropar (excluir) uma tabela que é referenciada por uma
-- restrição de chave estrangeira. A chave estrangeira ou a tabela que a contém
-- deve ser excluída antes.

-- Ao executar o comando, você verá que ele não funciona, retornando a seguinte mensagem de erro:
-- Cannot drop table 'language' referenced by a foreign key constraint 'fk_film_language' on table 'film'
-- Isso acontece em função de as informações da tabela language serem utilizadas na tabela film . Caso tente
-- dropar a tabela film , você perceberá que ela também possui restrições. Essas restrições estão relacionadas ao
-- conceito de integridade referencial , que deve ser considerado quando se cria um banco de dados. Elas têm o 
-- intuito de evitar que tabelas sejam excluídas acidentalmente.
-- Integridade referencial : Propriedade que afirma que todas as referências de chaves estrangeiras devem ser válidas.

-- Sobre INDEX
-- FULLTEXT INDEX:  são usados para busca nos textos baseados na coluna, ou o nome da própria colula.
-- INDEX: Somente para números.
-- UNIQUE INDEX: 
-- É uma maneira de estruturar o banco de dados, permitindo que você acesse rapidamente
-- Há três mandeiras de atribuir índices.

-- Criando um índice em uma coluna
CREATE [INDEX | FULLTEXT INDEX | UNIQUE INDEX] nome_indice ON tabela (coluna);

-- Criando um índice composto, em duas ou mais colunas
CREATE [INDEX | FULLTEXT INDEX | UNIQUE INDEX] nome_indice ON tabela (coluna1, coluna2);

-- Excluindo índices
DROP INDEX nome_do_indice ON tabela;

-- Também é possível criar índices no momento em que a tabela é criada
-- EX:
CREATE TABLE nome_da_tabela (
    coluna1 INT,
    coluna2 INT,
    INDEX (coluna1, coluna2)
) engine = InnoDB;

-- Também é possível criar índices na alteração da tabela.
-- EX:
ALTER TABLE nome_da_tabela ADD INDEX (coluna1, coluna2);