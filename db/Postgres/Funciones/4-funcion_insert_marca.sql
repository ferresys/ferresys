-- Función para insertar datos en la tabla "tab_marca"
CREATE OR REPLACE FUNCTION insertMarca(
    zNomMarca tabMarca.nomMarca%type) 
RETURNS void AS 

$$
DECLARE
    
BEGIN

    INSERT INTO tabMarca(nomMarca)
    VALUES (zNomMarca);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$ 
LANGUAGE plpgsql;

/*
select insertMarca('dewalt');
select * from tabMarca;


UPDATE tabMarca
SET estado = 'ACTIVO'
WHERE consecMarca = 1;

*/