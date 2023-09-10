
-- Función para insertar encabezado de venta
--SELECT *FROM tabCliente;
--select insertEncabezadoVenta(TRUE, '1095847854');
CREATE OR REPLACE FUNCTION insertEncabezadoVenta(
   zTipoFactura tabEncabezadoVenta.tipoFactura%type,
   zIdCli tabCliente.idCli%type
  
)

RETURNS VOID AS 
$$

DECLARE
    zVenta BIGINT;

BEGIN
    -- Insertar en la tabla tabEncabezadoVenta
    IF zTipoFactura = TRUE THEN -- LEGAL
        INSERT INTO tabEncabezadoVenta (tipoFactura, idCli)
        VALUES (zTipoFactura, zIdCli);
		--RETURNING consecEncVenta INTO zVenta;
   
    ELSIF zTipoFactura = FALSE THEN -- COTIZACION
        INSERT INTO tabEncabezadoVenta (tipoFactura, idCli)
        VALUES (zTipoFactura, zIdCli);
        --ALERTA: Tener en cuenta para pasar una cotización a venta.
        -- Yo sugiero que si la cotizacion pasa a ser venta se agrege a consecEncVenta 
        -- pero como un nuevo(ultimo) registro de venta
        RAISE NOTICE 'Encabezado de venta registrado con éxito.';
    END IF;
    RETURN;
END;
$$
LANGUAGE PLPGSQL;


