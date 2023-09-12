/* Funcion para insertar un registro en la tabla kardex 'SALIDA',
cada vez que se realice una insercion en la tabDetalleVenta*/

--esto permite que se actualice el stock en la tabArticulo cada vez que se haga una venta.

CREATE OR REPLACE FUNCTION insertKardex()
RETURNS TRIGGER AS 
$$
DECLARE
zValProm NUMERIC;
zValTotal NUMERIC;
zReciboMcia BIGINT;
--zCantArt INTEGER;
BEGIN
    /* Si el tipo de movimiento es entrada*/
	SELECT valTotal INTO zValTotal FROM tabReciboMercancia where consecReciboMcia= new.consecReciboMcia;
    SELECT consecReciboMcia INTO zReciboMcia FROM tabReciboMercancia  where consecReciboMcia= new.consecReciboMcia;
	--SELECT cantArt INTO zCantArt FROM tabReciboMercancia where consecReciboMcia= new.consecReciboMcia;
	--IF zTipoMov = TRUE THEN
        zValProm := zValTotal / new.cantArt;
        INSERT INTO tabKardex (consecReciboMcia,
        tipoMov, eanArt, cantArt, valProm) 
        VALUES (zReciboMcia, TRUE, NEW.eanArt, NEW.cantArt, zValProm);
        RETURN NEW;
   -- END IF;

    /* Si el tipo de movimiento es salida*/
   -- IF zTipoMov = FALSE THEN
       /* INSERT INTO tabKardex (
        tipoMov, eanArt, cantArt) 
        VALUES (FALSE, NEW.eanArt, NEW.cantArt);
        RETURN NEW;
    --END IF;*/
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insertEntradaKardex
AFTER INSERT ON tabReciboMercancia
FOR EACH ROW
EXECUTE FUNCTION insertKardex();
---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION insertKardex2()
RETURNS TRIGGER AS 
$$
DECLARE
zValProm NUMERIC :=0;
--zValTotal NUMERIC;
--zReciboMcia BIGINT;
zConsecDetVenta BIGINT;
--zCantArt INTEGER;
BEGIN
    /* Si el tipo de movimiento es salida*/
	
	--SELECT valTotal INTO zValTotal FROM tabReciboMercancia where consecReciboMcia= new.consecReciboMcia;
    SELECT consecDetVenta INTO zConsecDetVenta FROM tabDetalleVenta  where consecDetVenta= new.consecDetVenta;
	--SELECT cantArt INTO zCantArt FROM tabReciboMercancia where consecReciboMcia= new.consecReciboMcia;
	--IF zTipoMov = TRUE THEN
       -- zValProm := zValTotal / new.cantArt;
        INSERT INTO tabKardex (
        tipoMov, eanArt, cantArt, consecDetVenta) 
        VALUES (FALSE, NEW.eanArt, NEW.cantArt, zConsecDetVenta);
        RETURN NEW;
   -- END IF;

    /* Si el tipo de movimiento es salida*/
   -- IF zTipoMov = FALSE THEN
       /* INSERT INTO tabKardex (
        tipoMov, eanArt, cantArt) 
        VALUES (FALSE, NEW.eanArt, NEW.cantArt);
        RETURN NEW;
    --END IF;*/
END;
$$ LANGUAGE plpgsql;



CREATE TRIGGER insertSalidaKardex2
AFTER INSERT ON tabDetalleVenta
FOR EACH ROW
EXECUTE FUNCTION insertKardex2();