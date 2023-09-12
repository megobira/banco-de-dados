-- 01
SELECT titulo FROM livros;

-- 02 
SELECT nome FROM autores WHERE nascimento < '1900-01-01';

-- 03
SELECT livros.titulo, autores.nome FROM livros
INNER JOIN autores ON livros.autor_id = autores.id
WHERE autores.nome = 'J.K. Rowling';
