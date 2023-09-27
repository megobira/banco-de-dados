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

-- 05 
DELIMITER //
CREATE PROCEDURE sp_LivrosAteAno(IN anoLimite INT)
BEGIN
    SELECT * FROM Livro WHERE Ano_Publicacao <= anoLimite;
END; //
DELIMITER ;

CALL sp_LivrosAteAno(2016);

-- 06
DELIMITER //
CREATE PROCEDURE sp_TitulosPorCategoria(IN categoriaNome VARCHAR(100))
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE livroTitulo VARCHAR(255);
    DECLARE cur CURSOR FOR
        SELECT Livro.Titulo
        FROM Livro
        INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
        WHERE Categoria.Nome = categoriaNome;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO livroTitulo;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT livroTitulo;
    END LOOP;

    CLOSE cur;
END; //
DELIMITER ;

CALL sp_TitulosPorCategoria('Ficção Científica');

-- 07
drop PROCEDURE sp_AdicionarLivro;
DELIMITER //
CREATE PROCEDURE sp_AdicionarLivro(IN novoTitulo VARCHAR(255), IN novaEditoraID INT, IN novoAno INT, IN novoNumPaginas INT, IN novaCategoriaID INT, OUT mensagem VARCHAR(255))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET mensagem = 'Erro ao adicionar o livro!';
    END;

    START TRANSACTION;
    INSERT INTO Livro (Titulo, Editora_ID, Ano_Publicacao, Numero_Paginas, Categoria_ID)
    VALUES (novoTitulo, novaEditoraID, novoAno, novoNumPaginas, novaCategoriaID);
    COMMIT;

    SET mensagem = 'Livro adicionado!';
END //
DELIMITER ;

CALL sp_AdicionarLivro('Novo Livro', 1, 2023, 300, 2, @mensagem);
SELECT @mensagem;
