-- 01
DELIMITER //
CREATE PROCEDURE sp_ListarAutores()
BEGIN
    SELECT Autor.Nome FROM Autor;
END; //
DELIMITER ;

CALL sp_ListarAutores();

-- 02 
DELIMITER //
CREATE PROCEDURE sp_LivrosPorCategoria(IN categoriaNome VARCHAR(100))
BEGIN
    SELECT Livro.Titulo
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoriaNome;
END; //
DELIMITER ;

CALL sp_LivrosPorCategoria ('Romance');
CALL sp_LivrosPorCategoria ('Autoajuda');

-- 03
DELIMITER //
CREATE PROCEDURE sp_ContarLivrosPorCategoria(IN categoriaNome VARCHAR(100), OUT total INT)
BEGIN
    SELECT COUNT(*) INTO total
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoriaNome;
END //
DELIMITER ;

CALL sp_ContarLivrosPorCategoria('Autoajuda', @total);
SELECT @total;

-- 04
DELIMITER //
CREATE PROCEDURE sp_VerificarLivrosCategoria(IN categoriaNome VARCHAR(100), OUT possuiLivros BOOLEAN)
BEGIN
    SELECT EXISTS (
        SELECT 1
        FROM Livro
        INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
        WHERE Categoria.Nome = categoriaNome
    ) INTO possuiLivros;
END //
DELIMITER ;

CALL sp_VerificarLivrosCategoria('Ciência', @possuiLivros);
SELECT @possuiLivros;
