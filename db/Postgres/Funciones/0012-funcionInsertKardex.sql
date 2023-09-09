/* Funcion para insertar un registro en la tabla kardex 'SALIDA',
cada vez que se realice una insercion en la tabDetalleVenta*/

--esto permite que se actualice el stock en la tabArticulo cada vez que se haga una venta.

CREATE OR REPLACE FUNCTION insertKardex()
RETURNS TRIGGER AS $$
BEGIN
    /* Si el tipo de movimiento es entrada*/
    IF zTipoMov = TRUE THEN
        zValProm := zValTotal / zCantArt;
        INSERT INTO tabKardex (
        tipoMov, eanArt, cantArt, valProm) 
        VALUES (TRUE, NEW.eanArt, NEW.cantArt, zValProm);
        RETURN NEW;
    END IF;

    /* Si el tipo de movimiento es salida*/
    IF zTipoMov = FALSE THEN
        INSERT INTO tabKardex (
        tipoMov, eanArt, cantArt) 
        VALUES (FALSE, NEW.eanArt, NEW.cantArt;
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insertEntradaKardex
AFTER INSERT ON tabReciboMercancia
FOR EACH ROW
EXECUTE FUNCTION insertKardex();

CREATE TRIGGER insertSalidaKardex
AFTER INSERT ON tabDetalleVenta
FOR EACH ROW
EXECUTE FUNCTION insertKardex();