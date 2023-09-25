--IMPORTANTE: hay que insertar un encabezado de venta y un detalle de venta a la vez.
--select insertEncVenta(TRUE, '1095847854', 'Bucaramanga');
--select insertEncVenta(FALSE, '1095847854', 'Bucaramanga');
--select insertEncVenta(TRUE, '1002567842', 'Bucaramanga');
--select insertEncVenta(FALSE, '1002567842', 'Bucaramanga');

--select * from tabEncabezadoVenta;
--select * from  tabCliente;

-- Función para insertar encabezado de venta

CREATE OR REPLACE FUNCTION insertEncVenta(
    IN zTipoFactura BOOLEAN,
       zIdCli VARCHAR,
       zCiudad VARCHAR,
    OUT zConsecFactura BIGINT,
	OUT zConsecCotizacion BIGINT
	
)
AS $$

DECLARE 
zCliente VARCHAR;

BEGIN
    IF zTipoFactura = TRUE THEN -- Factura legal
	    SELECT idCli INTO zCliente from tabCliente where idCli=zIdCli;
        INSERT INTO tabEncabezadoVenta (tipoFactura, idCli, ciudad)
        VALUES (zTipoFactura, zCliente, zCiudad )
        RETURNING consecFactura INTO zConsecFactura;
	    zConsecCotizacion:= NULL;
		
    ELSE -- Cotización
	    SELECT idCli INTO zCliente from tabCliente where idCli=zIdCli;
        INSERT INTO tabEncabezadoVenta  (tipoFactura, idCli, ciudad)
        VALUES (zTipoFactura, zCliente, zCiudad)
        RETURNING consecCotizacion INTO zConsecCotizacion;
		zConsecFactura := NULL; -- No asignar consecutivo para cotizaciones
    END IF;
END;
$$ LANGUAGE plpgSQL;

--ALERTA: Tener en cuenta para pasar una cotización a venta.
        -- Yo sugiero que si la cotizacion pasa a ser venta se agrege a consecEncVenta 
        -- pero como un nuevo(ultimo) registro de venta
       
