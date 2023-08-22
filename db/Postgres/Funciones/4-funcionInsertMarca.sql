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
select insertMarca('MAKITA');
select insertMarca('dewalt');
select * from tabMarca;
select * from tabProveedorMarca;
select * from tabProveedor;
UPDATE tabMarca
SET estado = 'ACTIVO'
WHERE consecMarca = 1;
alter table tabMarca drop column nitProv;
*/


/*SELECT 
    tpm.consecMarca, tpm.nitProv, tm.nomMarca, tp.nomProv,
    tpm.consecProvMarca
FROM 
    tabProveedorMarca tpm
LEFT JOIN  
    tabProveedor tp ON tpm.nitProv = tp.nitProv 
LEFT JOIN  
    tabMarca tm ON tpm.consecMarca = tm.consecMarca;*/
	
	
