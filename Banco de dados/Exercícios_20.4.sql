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

