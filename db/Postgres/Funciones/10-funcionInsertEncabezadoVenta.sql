
-- Función para insertar encabezado de venta
CREATE OR REPLACE FUNCTION insertEncabezadoVenta(
    zTipoFactura tabEncabezadoVenta.tipoFactura%type,
    zIdCli tabCliente.idCli%type,
    zCiudad tabEncabezadoVenta.ciudad%type
)

RETURNS VOID AS 
$$

DECLARE
    zVenta BIGINT;

BEGIN
    -- Insertar en la tabla tabEncabezadoVenta
    IF zTipoFactura = TRUE THEN -- LEGAL
        INSERT INTO tabEncabezadoVenta (idCli, ciudad)
        VALUES (zIdCli, zCiudad);
        RETURNING consecEncVenta INTO zVenta;
        RAISE NOTICE 'Encabezado de venta registrado con éxito.';
    END IF;

    ELSIF zTipoFactura = FALSE THEN -- COTIZACION
        INSERT INTO tabEncabezadoVenta (idCli, ciudad)
        VALUES (zIdCli, zCiudad);
        --ALERTA: Tener en cuenta para pasar una cotización a venta.
        -- Yo sugiero que si la cotizacion pasa a ser venta se agrege a consecEncVenta 
        -- pero como un nuevo(ultimo) registro de venta
        RAISE NOTICE 'Encabezado de venta registrado con éxito.';
    END IF;
    RETURN;
END;
$$
LANGUAGE PLPGSQL;