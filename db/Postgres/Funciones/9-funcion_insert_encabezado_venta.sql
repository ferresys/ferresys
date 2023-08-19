/*creamos la funcion para insertar datos del cliente al encabezado*/
CREATE OR REPLACE FUNCTION insertEncabezadoVenta(
zConsecCli tabCliente.consecCli%type)
RETURNS VOID AS 

$$
DECLARE 
zFecVenta timestamp:= current_timestamp;

BEGIN
	insert into tabEncabezadoVenta (fecVenta,consecCli)
	values(zFecVenta, zConsecCli);

RETURN ;
END;
$$
LANGUAGE PLPGSQL;

/*luego creamos una funcion trigger para actualizar la columna val_pagar dependiendo de la tabDetalleVenta*/

CREATE OR REPLACE FUNCTION updateEncabezadoVentaValPagar()
RETURNS TRIGGER AS $$
DECLARE
    ZTotalPagar numeric(10);
BEGIN
    -- Obtener el "TotalPagar" de "tabDetalleVenta" para el consecVenta correspondiente
    SELECT SUM(totalPagar) INTO ZTotalPagar FROM tabDetalleVenta WHERE consecVenta = NEW.consecVenta;

    -- Actualizar el campo "valPagar" en "tabEncabezadoVenta" con el valor calculado
    UPDATE tabEncabezadoVenta AS enc
    SET valPagar = ZTotalPagar
    WHERE enc.consecVenta = NEW.consecVenta;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;




CREATE TRIGGER triggerUpdateEncabezadoVenta
AFTER INSERT ON tabDetalleVenta
FOR EACH ROW
EXECUTE FUNCTION updateEncabezadoVentaValPagar();


/*
select * from tabEncabezadoVenta;
select * from tabCliente
select insertEncabezadoVenta('1098121845');
select * from tabDetalleVenta;
*/

