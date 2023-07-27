-- Función para insertar datos en la tabla "tab_articulo"
CREATE OR REPLACE FUNCTION insert_articulo(
    
    zean_art tab_articulo.ean_art%type,
    znom_art tab_articulo.nom_art%type,
	zconsec_marca tab_marca.consec_marca%type,
	zconsec_categ tab_categoria.consec_categ%type,
    zdescrip_art tab_articulo.descrip_art%type,  
    zunid_med tab_articulo.unid_med%type, 
    ziva tab_articulo.iva%type,
    zfec_vence tab_articulo.fec_vence%type
) RETURNS void AS 

$$
DECLARE
    zfec_reg timestamp := current_timestamp;--now(); puede ser current_timestamp o now();
	zmarca tab_marca.consec_marca%type;
	zcategoria tab_categoria.consec_categ%type;
BEGIN

SELECT consec_marca INTO zmarca FROM tab_marca WHERE consec_marca=zconsec_marca;
SELECT consec_categ INTO zcategoria FROM tab_categoria WHERE consec_categ=zconsec_categ; 
    
	INSERT INTO tab_articulo(ean_art, fec_reg, nom_art,consec_marca, consec_categ, descrip_art, unid_med, iva, fec_vence)
    VALUES (zean_art, zfec_reg, znom_art, zmarca, zcategoria, zdescrip_art, zunid_med, ziva, zfec_vence);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$ 
LANGUAGE plpgsql;

/*
select insert_articulo('00000001','taladro',1,1,'taladro amarillo','N/A',19,'2023-11-21');
select * from tab_articulo;
select * from tab_marca;
select * from tab_categoria;

ALTER TABLE tab_articulo
ALTER COLUMN marca_art TYPE VARCHAR;
ALTER COLUMN categ_art TYPE VARCHAR;

SELECT nom_art
FROM tab_articulo
JOIN tab_marca ON tab_articulo.consec_marca = tab_marca.nom_marca
JOIN tab_categoria ON tab_articulo.consec_categ = tab_categoria.nom_categ;

*/
/* utilizamos join para consultar datos de varias tablas:
SELECT  a.nom_art, c.nom_marca, m.nom_categ
FROM tab_articulo a
JOIN tab_marca c ON a.consec_marca = c.consec_marca 
JOIN tab_categoria m ON a.consec_categ = m.consec_categ ;
*/
