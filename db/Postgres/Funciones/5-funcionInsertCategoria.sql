
-- Función para insertar datos en la tabla "tabCategoria"

CREATE OR REPLACE FUNCTION insertCategoria( 
    zNomCateg tabCategoria.nomCateg%type,
    zCedulaAdmin tabAdministrador.cedulaAdmin%type)
RETURNS void AS 

$$
DECLARE
    --zAdmin INTEGER;
BEGIN
    --SELECT idAdmin INTO ZAdmin FROM tabAdministrador;
    INSERT INTO tabCategoria(nomCateg, cedulaAdmin)
    VALUES (zNomCateg, zCedulaAdmin);
    --RETURNING idAdmin INTO zAdmin;
    RAISE NOTICE 'Registro exitoso ';
END;
$$ 
LANGUAGE plpgsql;

/*
select insertCategoria('Herramientas',1098821827);
select * from tabCategoria;
select * from tabregBorrados;
select * from tabAdministrador
delete from tabCategoria where consecCateg=1;

UPDATE tabCategoria
SET estado = 'INACTIVO'
WHERE consecCateg = 1;

*/