-- Función para insertar datos en la tabla "tab_categoria"
CREATE OR REPLACE FUNCTION insert_categoria( 
    znom_categ tab_categoria.nom_categ%type) 
RETURNS void AS 

$$
DECLARE
      
BEGIN

    INSERT INTO tab_categoria(nom_categ)
    VALUES (znom_categ);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$ 
LANGUAGE plpgsql;

/*
select insert_categoria('Herramientas');
select * from tab_categoria;
select * from reg_borrados;

delete from tab_categoria where consec_categ=1;

UPDATE tab_categoria
SET estado = 'INACTIVO'
WHERE consec_categ = 1;

*/