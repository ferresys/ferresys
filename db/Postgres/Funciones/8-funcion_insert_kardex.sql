-- Función para insertar datos en la tabla "tab_kardex"
CREATE OR REPLACE FUNCTION insert_kardex(
    ztipo_mov tab_kardex.tipo_mov%type,
    zean_art tab_articulo.ean_art%type,
    znom_art tab_articulo.nom_art%type,
    zcant_art tab_kardex.cant_art%type,
    zval_compra tab_kardex.val_compra%type,
    zobservacion tab_kardex.observacion%type,
    zconsec_prov tab_kardex.consec_prov%type
) RETURNS void AS 

$$
DECLARE
    zfec_mov timestamp := current_timestamp; --now(); puede ser current_timestamp o now();
    zval_prom tab_kardex.val_prom%type;
    zval_total tab_kardex.val_total%type;
	
BEGIN
    IF ztipo_mov ='ENTRADA' THEN
        zval_total := zcant_art * zval_compra;
        zval_prom := zval_total / zcant_art;
		
    	ELSIF ztipo_mov ='SALIDA' THEN
        zval_total := 0; -- No se realiza el cálculo para 'SALIDA', asignamos  un valor por defecto.
        zval_prom := 0;  -- No se realiza el cálculo para 'SALIDA', asignamos un valor por defecto.
    END IF;

    INSERT INTO tab_kardex( fec_mov, tipo_mov, ean_art, nom_art, cant_art, val_compra, val_total, val_prom, observacion, consec_prov)
    VALUES (zfec_mov, ztipo_mov, zean_art, znom_art, zcant_art, zval_compra, zval_total, zval_prom, zobservacion, zconsec_prov);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$ 
LANGUAGE plpgsql;

/*
select insert_kardex('ENTRADA','00000001','taladro',10,5000,'OK',1);
select insert_kardex('SALIDA','00000001','taladro',10,5000,'OK',1);
select * from tab_kardex;
select * from tab_marca;
select * from tab_categoria;
select * from tab_proveedor;
select * from tab_articulo;
select * from tab_artxprov;
select * from tab_cliente;
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
--UPDATE tab_kardex set tipo_mov='ENTRADA' WHERE consec_kardex=15;
--SELECT *from tab_artxprov where consec_prov=2
--alter table tab_artxprov drop column val_stock  ;