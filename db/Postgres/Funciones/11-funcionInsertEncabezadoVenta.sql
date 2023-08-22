-- Función para insertar encabezado de venta para cliente natural
CREATE OR REPLACE FUNCTION insertEncabezadoVentaNatural(
    zTipoFactura tabEncabezadoVenta.tipoFactura%type,
    zIdCli tabClienteNatural.idCli%type,
    zIdAdmin tabAdministrador.idAdmin%type
)
RETURNS VOID AS 
$$
DECLARE 
    zFecVenta TIMESTAMP:= current_timestamp;
    zIdClis INTEGER;
	
BEGIN
    IF zTipoFactura = 'PRELIMINAR' OR zTipoFactura = 'LEGAL' THEN
        -- Obtener el consecutivo del cliente natural
        SELECT idCli INTO zIdClis FROM tabClienteNatural WHERE idCli = zIdCli;

        -- Insertar en la tabla tabEncabezadoVenta
        INSERT INTO tabEncabezadoVenta (fecVenta, tipoFactura, idAdmin, idCli)
        VALUES (zFecVenta, zTipoFactura,  zIdAdmin, zIdClis);

        RAISE NOTICE 'Encabezado de Venta para cliente natural registrado con éxito.';
    END IF;
    
    RETURN;
END;
$$
LANGUAGE PLPGSQL;

-- Función para insertar encabezado de venta para cliente jurídico
CREATE OR REPLACE FUNCTION insertEncabezadoVentaJuridico(
    zTipoFactura tabEncabezadoVenta.tipoFactura%type,
    zNitCli tabClienteJuridico.nitCli%type,
    zIdAdmin tabAdministrador.idAdmin%type
)
RETURNS VOID AS 
$$
DECLARE 
    zFecVenta TIMESTAMP := current_timestamp;
    zNitClis VARCHAR;
BEGIN
    IF zTipoFactura = 'PRELIMINAR' OR zTipoFactura = 'LEGAL' THEN
        -- Obtener el consecutivo del cliente jurídico
        SELECT nitCli INTO zNitClis FROM tabClienteJuridico WHERE nitCli = zNitCli;

        -- Insertar en la tabla tabEncabezadoVenta
        INSERT INTO tabEncabezadoVenta (fecVenta, tipoFactura, idAdmin, nitCli)
        VALUES (zFecVenta, zTipoFactura, zIdAdmin, zNitClis);

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




CREATE TRIGGER triggerUpdateEncabezadoVenta
AFTER INSERT ON tabDetalleVenta
FOR EACH ROW
EXECUTE FUNCTION updateEncabezadoVentaValPagar();


/*
select insertEncabezadoVentaNatural('PRELIMINAR', 63294565, 1095821827)
select insertEncabezadoVentaJuridico('LEGAL', '0-123456' , 1095821827)
alter table tabencabezadoVenta drop column nitCli;
alter table tabencabezadoVenta add idCli Integer ;
alter table tabencabezadoVenta add column nitCli varchar ;
select * from tabEncabezadoVenta;
select * from tabClienteNatural;
select * from tabClienteJuridico;
*/