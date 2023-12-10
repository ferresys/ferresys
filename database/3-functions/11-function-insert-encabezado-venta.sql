
--IMPORTANTE: hay que insertar un encabezado de venta y un detalle de venta a la vez.
--select insertEncVenta(TRUE, '1095847854', 'Bucaramanga');
--select insertEncVenta(FALSE, '62294335', 'Medellin');


-- Función para insertar encabezado de venta

CREATE OR REPLACE FUNCTION insertEncVenta(
    IN zTipoFactura BOOLEAN,
       zIdCli VARCHAR,
       zCiudad VARCHAR,
    OUT zConsecFactura BIGINT,
    OUT zConsecCotizacion BIGINT
    
)
AS 
$$

DECLARE 


BEGIN
    IF zTipoFactura = TRUE THEN -- Factura legal
        
        INSERT INTO tabEncabezadoVenta (tipoFactura, idCli, ciudad)
        VALUES (zTipoFactura, zIdCli, zCiudad )
        RETURNING consecFactura INTO zConsecFactura;
        zConsecCotizacion:= NULL;
        
    ELSE -- Cotización
       
        INSERT INTO tabEncabezadoVenta  (tipoFactura, idCli, ciudad)
        VALUES (zTipoFactura, zIdCli, zCiudad)
        RETURNING consecCotizacion INTO zConsecCotizacion;
        zConsecFactura := NULL; -- No asignar consecutivo para cotizaciones
    END IF;
END;
$$ 
LANGUAGE plpgSQL;




