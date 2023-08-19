-- Función para insertar datos en la tabla "tab_kardex"
CREATE OR REPLACE FUNCTION insertKardex(
    zTipoMov tabKardex.tipoMov%type,
    zEanArt tabArticulo.eanArt%type,
    znomArt tabArticulo.nomArt%type,
    zcantArt tabKardex.cantArt%type,
    zvalCompra tabKardex.valCompra%type,
    zObservacion tabKardex.observacion%type,
    znitProv tabProveedor.nitProv%type,
	zIdAdmin tabAdministrador.idAdmin%type
) RETURNS void AS 

$$
DECLARE
    zFecMov timestamp := current_timestamp; --now(); puede ser current_timestamp o now();
    zValProm tabKardex.valProm%type;
    zValTotal tabKardex.valTotal%type;
	
BEGIN
    IF zTipoMov ='ENTRADA' THEN
        zValTotal := zCantArt * zValCompra;
        zValProm := zValTotal / zCantArt;
		
    	ELSIF zTipoMov ='SALIDA' THEN
        zValTotal := 0; -- No se realiza el cálculo para 'SALIDA', asignamos  un valor por defecto.
        zValProm := 0;  -- No se realiza el cálculo para 'SALIDA', asignamos un valor por defecto.
    END IF;

    INSERT INTO tabKardex( fecMov, tipoMov, eanArt, nomArt, cantArt, valCompra, valTotal, valProm, observacion, nitProv, idAdmin)
    VALUES (zFecMov, zTipoMov, zEanArt, zNomArt, zCantArt, zValCompra, zValTotal, zValProm, zObservacion, zNitProv, zIdAdmin);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$ 
LANGUAGE plpgsql;

/*
select insertKardex('ENTRADA','00000001','taladro',10,5000,'OK','0-1098235641',1095821827);
select insertKardex('SALIDA','00000001','taladro',10,5000,'OK',1);
select * from tabKardex;
select * from tabMarca;
select * from tabCategoria;
select * from tabProveedor;
select * from tabArticulo;
select * from tabProveedorArticulo;
select * from tabCliente;
ALTER TABLE tabArticulo
ALTER COLUMN marcaArt TYPE VARCHAR;
ALTER COLUMN categArt TYPE VARCHAR;

SELECT nomArt
FROM tabArticulo
JOIN tabMarca ON tabArticulo.consecMarca = tabMarca.nomMarca
JOIN tabCategoria ON tabArticulo.consecCateg = tabCategoria.nomCateg;

*/
/* utilizamos join para consultar datos de varias tablas:
SELECT  a.nomArt, c.nomMarca, m.nomCateg
FROM tabArticulo a
JOIN tabMarca c ON a.consecMarca = c.consecMarca 
JOIN tabCategoria m ON a.consecCateg = m.consecCateg ;
*/
--UPDATE tabKardex set tipoMov='ENTRADA' WHERE consecKardex=15;
--SELECT *from tabProveedorArticulo where nitProv=2
--alter table tabProveedorArticulo drop column valStock  ;