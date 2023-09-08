
-- Función para insertar datos en la tabla "tabKardex"

CREATE OR REPLACE FUNCTION insertKardex(
    zTipoMov tabKardex.tipoMov%type,
    zEanArt tabArticulo.eanArt%type,
    zNomArt tabArticulo.nomArt%type,
    zCantArt tabKardex.cantArt%type,
    zValCompra tabKardex.valCompra%type,
    zObservacion tabKardex.observacion%type,
    zNitProv tabProveedor.nitProv%type,
	zConsecMarca tabMarca.consecMarca%type,
	zCedulaAdmin tabAdministrador.cedulaAdmin%type
) RETURNS void AS 

$$
DECLARE
    zFecMov TIMESTAMP := current_timestamp; --now(); puede ser current_timestamp o now();
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

    INSERT INTO tabKardex( fecMov, tipoMov, eanArt, nomArt, cantArt, valCompra, valTotal, valProm, observacion, nitProv, consecMarca, cedulaAdmin)
    VALUES (zFecMov, zTipoMov, zEanArt, zNomArt, zCantArt, zValCompra, zValTotal, zValProm, zObservacion, zNitProv, zConsecMarca, zCedulaAdmin);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$ 
LANGUAGE plpgsql;

/*
select insertKardex(TRUE,'0-0000001','Pulidora',15,5000,'OK','0-12', 1, 1098821827 );
select insertKardex('ENTRADA','0-0000001','Pulidora',20,5000,'OK','0-13', 1, 1098821827);
select insertKardex('ENTRADA','0-0000001','Pulidora',20,5000,'OK','0-13', 1, 1098821827);
select insertKardex('ENTRADA','0-0000002','Pulidora',10,5000,'OK','0-13', 2, 1098821827);

select * from tabKardex;
select * from tabMarca;
select * from tabCategoria;
select * from tabProveedorMarca;
select * from tabProveedor;
select * from tabArticulo;
select * from tabProveedorArticulo;
select * from tabCliente;
select * from tabAdministrador;
ALTER TABLE tabArticulo
ALTER COLUMN marcaArt TYPE VARCHAR;
ALTER COLUMN categArt TYPE VARCHAR;
alter table tabKardex add column consecMarca BIGINT;
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


