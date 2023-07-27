-- Función para insertar datos en la tabla "tab_marca"
CREATE OR REPLACE FUNCTION insert_marca(
    znom_marca tab_marca.nom_marca%type) 
RETURNS void AS 

$$
DECLARE
    
BEGIN

    INSERT INTO tab_marca(nom_marca)
    VALUES (znom_marca);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$ 
LANGUAGE plpgsql;

/*
select insert_marca('dewalt');
select * from tab_marca;


UPDATE tab_marca
SET estado = 'ACTIVO'
WHERE consec_marca = 1;

*/