-- Función para insertar datos en la tabla "tabArticulo"
CREATE OR REPLACE FUNCTION insertArticulo(
    
    zEanArt tabArticulo.eanArt%type,
    zNomArt tabArticulo.nomArt%type,
	zConsecMarca tabMarca.consecMarca%type,
	zConsecCateg tabCategoria.consecCateg%type,
    zDescripArt tabArticulo.descripArt%type,  
	zPorcentaje tabArticulo.Porcentaje%type,
    zFecVence tabArticulo.fecVence%type
	
	
) RETURNS void AS 

$$
DECLARE
    zFecReg TIMESTAMP:= current_timestamp;--now(); puede ser current_timestamp o now();
	zMarca tabMarca.consecMarca%type;
	zCategoria tabCategoria.consecCateg%type;
	
BEGIN

SELECT consecMarca INTO zMarca FROM tabMarca WHERE consecMarca=zConsecMarca;
SELECT consecCateg INTO zCategoria FROM tabCategoria WHERE consecCateg=zConsecCateg; 
    
	INSERT INTO tabArticulo(eanArt, fecReg, nomArt,consecMarca, consecCateg, descripArt, porcentaje, fecVence)
    VALUES (zEanArt, zFecReg, zNomArt, zMarca, zCategoria, zDescripArt, zPorcentaje, zFecVence);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$ 
LANGUAGE plpgsql;





/*
select insertArticulo('0-0000001','pulidora',1,1,'taladro amarillo',1.20, '2023-11-21');
select insertArticulo('0-0000002','pulidora',2,1,'verde', 1.20, '2023-11-21');
select * from tabArticulo;
select * from tabMarca;
select * from tabCategoria;
select * from tabKardex;

ALTER TABLE tabArticulo
ALTER COLUMN marcaArt TYPE VARCHAR;
ALTER COLUMN categArt TYPE VARCHAR;

SELECT nomArt
FROM tabArticulo
JOIN tab_marca ON tabArticulo.consecMarca = tab_marca.nom_marca
JOIN tab_categoria ON tabArticulo.consecCateg = tab_categoria.nom_categ;

*/
/* utilizamos join para consultar datos de varias tablas:
SELECT  a.nomArt, c.nom_marca, m.nom_categ
FROM tabArticulo a
JOIN tab_marca c ON a.consecMarca = c.consecMarca 
JOIN tab_categoria m ON a.consecCateg = m.consecCateg ;
*/
