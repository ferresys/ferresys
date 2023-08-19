-- Función para insertar datos en la tabla "tab_categoria"
CREATE OR REPLACE FUNCTION insertCategoria( 
    zNomCateg tabCategoria.nomCateg%type,
    ZIdAdmin tabAdministrador.idAdmin%type)
RETURNS void AS 

$$
DECLARE
    --zAdmin INTEGER;
BEGIN
    --SELECT idAdmin INTO ZAdmin FROM tabAdministrador;
    INSERT INTO tabCategoria(nomCateg, idAdmin)
    VALUES (zNomCateg, ZIdAdmin);
    --RETURNING idAdmin INTO zAdmin;
    RAISE NOTICE 'Registro exitoso ';
END;
$$ 
LANGUAGE plpgsql;

/*
select insertCategoria('Herramientas','1095821827');
select * from tabCategoria;
select * from tabregBorrados;

delete from tabCategoria where consecCateg=1;

UPDATE tabCategoria
SET estado = 'INACTIVO'
WHERE consecCateg = 1;

*/