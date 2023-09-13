-- 01
SELECT titulo FROM livros;

-- 02 
SELECT nome FROM autores WHERE nascimento < '1900-01-01';

-- 03
SELECT livros.titulo, autores.nome FROM livros
INNER JOIN autores ON livros.autor_id = autores.id
WHERE autores.nome = 'J.K. Rowling';

-- 04
SELECT alunos.nome, matriculas.curso FROM alunos
INNER JOIN matriculas ON alunos.id = matriculas.aluno_id
WHERE matriculas.curso = 'Engenharia de Software';

-- 05 
SELECT produto, SUM(receita) AS receita_total FROM vendas
GROUP BY produto;

-- 06
SELECT autores.nome AS autor, COUNT(livros.id) AS livros_total FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id
GROUP BY autores.id ORDER BY autores.id;

-- 07
SELECT curso, COUNT(aluno_id) AS aulonos_matriculados FROM matriculas
GROUP BY curso ORDER BY curso;

-- 08
SELECT produto, AVG(receita) AS media_de_receita FROM vendas
GROUP BY produto ORDER BY produto;

-- 09
SELECT produto, SUM(receita) AS total_receita FROM vendas
GROUP BY produto HAVING SUM(receita) > '10.000' ORDER BY produto;

-- 10
SELECT autores.nome AS autor, COUNT(livros.id) AS quantidade_livros FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id 
GROUP BY autores.id HAVING COUNT(livros.id) > '2';

-- 11
SELECT livros.titulo AS livro, autores.nome AS autor FROM livros
JOIN autores ON livros.autor_id = autores.id ORDER BY autor, livro;

-- 12
SELECT alunos.nome AS aluno, matriculas.curso FROM alunos 
JOIN matriculas ON alunos.id = matriculas.aluno_id ORDER BY aluno, curso;

-- 13
SELECT autores.nome AS autor, livros.titulo AS livro FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id ORDER BY autor, livro;
