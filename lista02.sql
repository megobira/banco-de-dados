-- 01
DELIMITER //
CREATE PROCEDURE sp_ListarAutores()
BEGIN
    SELECT Autor.Nome FROM Autor;
END; //
DELIMITER ;

CALL sp_ListarAutores();
