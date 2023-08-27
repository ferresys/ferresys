
-- Función para insertar encabezado de venta para cliente natural

CREATE OR REPLACE FUNCTION insertEncabezadoVentaNatural(
    zTipoFactura tabEncabezadoVenta.tipoFactura%type,
    zCedulaCliNat tabClienteNatural.cedulaCliNat%type,
    zCedulaAdmin tabAdministrador.cedulaAdmin%type
)
RETURNS VOID AS 
$$
DECLARE 
    zFecVenta TIMESTAMP:= current_timestamp;
    zIdClis INTEGER;
	
BEGIN
    IF zTipoFactura = 'PRELIMINAR' OR zTipoFactura = 'LEGAL' THEN
        -- Obtener el consecutivo del cliente natural
        SELECT cedulaCliNat INTO zIdClis FROM tabClienteNatural WHERE cedulaCliNat = zCedulaCliNat;

        -- Insertar en la tabla tabEncabezadoVenta
        INSERT INTO tabEncabezadoVenta (fecVenta, tipoFactura, cedulaAdmin, cedulaCliNat)
        VALUES (zFecVenta, zTipoFactura,  zcedulaAdmin, zIdClis);

        RAISE NOTICE 'Encabezado de Venta para cliente natural registrado con éxito.';
    END IF;
    
    RETURN;
END;
$$
LANGUAGE PLPGSQL;




-- Función para insertar encabezado de venta para cliente jurídico
CREATE OR REPLACE FUNCTION insertEncabezadoVentaJuridico(
    zTipoFactura tabEncabezadoVenta.tipoFactura%type,
    zNitCliJur tabClienteJuridico.nitCliJur%type,
    zcedulaAdmin tabAdministrador.cedulaAdmin%type
)
RETURNS VOID AS 
$$
DECLARE 
    zFecVenta TIMESTAMP := current_timestamp;
    zNitClis VARCHAR;
BEGIN
    IF zTipoFactura = 'PRELIMINAR' OR zTipoFactura = 'LEGAL' THEN
        -- Obtener el consecutivo del cliente jurídico
        SELECT nitCliJur INTO zNitClis FROM tabClienteJuridico WHERE nitCliJur = zNitCliJur;

        -- Insertar en la tabla tabEncabezadoVenta
        INSERT INTO tabEncabezadoVenta (fecVenta, tipoFactura, cedulaAdmin, nitCliJur)
        VALUES (zFecVenta, zTipoFactura, zCedulaAdmin, zNitClis);

        RAISE NOTICE 'Encabezado de Venta para cliente jurídico registrado con éxito.';
    END IF;
    
    RETURN;
END;
$$
LANGUAGE PLPGSQL;



/*luego creamos una funcion trigger para actualizar la columna totalPagar dependiendo de la tabDetalleVenta*/

CREATE OR REPLACE FUNCTION updateEncabezadoVentaValPagar()
RETURNS TRIGGER AS $$
DECLARE
    ZTotalPagar numeric(10);
BEGIN
    -- Obtener el "TotalPagar" de "tabDetalleVenta" para el consecVenta correspondiente
    SELECT SUM(totalPagar) INTO ZTotalPagar FROM tabDetalleVenta WHERE consecVenta = NEW.consecVenta;

    -- Actualizar el campo "valPagar" en "tabEncabezadoVenta" con el valor calculado
    UPDATE tabEncabezadoVenta AS enc
    SET totalPagar = ZTotalPagar
    WHERE enc.consecVenta = NEW.consecVenta;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;



--creamos el trigger para que se dispare despues de insertar un registro en ta tabDetalleVenta.
CREATE TRIGGER triggerUpdateEncabezadoVenta
AFTER INSERT ON tabDetalleVenta
FOR EACH ROW
EXECUTE FUNCTION updateEncabezadoVentaValPagar();


/*
select insertEncabezadoVentaNatural('PRELIMINAR', 63294565, 1098821827)
select insertEncabezadoVentaJuridico('LEGAL', '0-123456' , 1098821827)
alter table tabencabezadoVenta drop column nitCli;
alter table tabencabezadoVenta add idCli Integer ;
alter table tabencabezadoVenta add column nitCli varchar ;
select * from tabEncabezadoVenta;
select * from tabClienteNatural;
select * from tabClienteJuridico;
*/