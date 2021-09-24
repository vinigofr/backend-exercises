-- 1a Forma Normal
-- Cada coluna possui um nome único
-- Cada coluna usa o mesmo tipo de dado
-- Ordem dos dados não afetam a integridade
-- Colunas devem possuir apenas um valor

-- 2a Forma Normal
-- A segunda forma normal busca resolver problemas de colunas desnecessárias
-- em algumas tebelas.
-- Ou seja, não pode possuir dependências parcionais.

-- 3a Forma Normal
-- É a mesma coisa do segundo, só que menos específico.

-- Agora vamos aprender sobre as diversas formas de fazer um DUMP de um banco de dados.

-- Recuperar banco de dados completo + estrutura:
mysqldump -u [user] -p [nome do banco de dados] > [nome para arquivo de saida].sql
-- Após isso será exigida a senha.

-- Recuperar somente a estrutura: útil para quando os dados não são requeridos.
-- Utilizando --no-data
mysqldump -u [user] -p `--no-data` [nome do banco de dados] > [nome para arquivo de saida].sql

-- Para recuperar Banco de Dados a partir de um arquivo específico gerado anteriomente.
-- 1. É preciso ter um banco de dados criado, do mesmo nome do anterior de preferênca.
-- 2. Com ele criado, pelas instâncias do MySQL, use o comando exit para sair.
-- 3. Depois, o comando a seguir deve ser inserido:
mysqldump -u [user] -p [nome do banco de dados] < [nome do arquivo].sql
-- 4. É bom observar a direção do sinal de menor/maior que. Ele indica a direção do dado.