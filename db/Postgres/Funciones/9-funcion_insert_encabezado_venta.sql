/*creamos la funcion para insertar datos del cliente al encabezado*/
CREATE OR REPLACE FUNCTION insert_encabezado_venta(
zid_cli tab_cliente.id_cli%type)
RETURNS VOID AS 

$$
DECLARE 
zfec_venta timestamp:= current_timestamp;

BEGIN
	insert into tab_encabezado_venta (fec_venta,id_cli)
	values(zfec_venta, zid_cli);

RETURN ;
END;
$$
LANGUAGE PLPGSQL;

/*luego creamos una funcion trigger para actualizar la columna val_pagar dependiendo de la tab_detalle_venta*/

CREATE OR REPLACE FUNCTION update_encabezado_venta_val_pagar()
RETURNS TRIGGER AS $$
DECLARE
    Ztotal_pagar numeric(10);
BEGIN
    -- Obtener el "Total_Pagar" de "tab_detalle_venta" para el consec_venta correspondiente
    SELECT SUM(total_pagar) INTO Ztotal_pagar FROM tab_detalle_venta WHERE consec_venta = NEW.consec_venta;

    -- Actualizar el campo "val_pagar" en "tab_encabezado_venta" con el valor calculado
    UPDATE tab_encabezado_venta AS enc
    SET val_pagar = Ztotal_pagar
    WHERE enc.consec_venta = NEW.consec_venta;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;




CREATE TRIGGER trigger_update_encabezado_venta
AFTER INSERT ON tab_detalle_venta
FOR EACH ROW
EXECUTE FUNCTION update_encabezado_venta_val_pagar();


/*
select * from tab_encabezado_venta;
select * from tab_cliente
select insert_encabezado_venta('1098121845');
select * from tab_detalle_venta;
*/

