/* Función para insertar un registro en la tabla kardex 'ENTRADA',
cada vez que se realice una inserciÓn en la tabReciboMercancia.

esto a su vez permite que se actualice el stock y el valUnit en la 
tabArticulo cada vez que se haga una entrada(ReciboMercancia).*/

CREATE OR REPLACE FUNCTION insertKardexEntrada()
RETURNS TRIGGER AS 
$$
DECLARE
zValProm tabKardex.valProm%type;
zValTotal tabReciboMercancia.valTotal%type;
zReciboMcia tabReciboMercancia.consecReciboMcia%type;
--zCantArt INTEGER;
BEGIN
    /* Si el tipo de movimiento es entrada*/
	SELECT valTotal INTO zValTotal FROM tabReciboMercancia where consecReciboMcia= new.consecReciboMcia;
    SELECT consecReciboMcia INTO zReciboMcia FROM tabReciboMercancia  where consecReciboMcia= new.consecReciboMcia;
	--SELECT cantArt INTO zCantArt FROM tabReciboMercancia where consecReciboMcia= new.consecReciboMcia;
	--IF zTipoMov = TRUE THEN
    zValProm := zValTotal / new.cantArt;
    
	INSERT INTO tabKardex (consecReciboMcia,tipoMov, eanArt, cantArt, valProm) 
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

--creamos el trigger
CREATE TRIGGER insertEntradaKardexEntrada
AFTER INSERT ON tabReciboMercancia
FOR EACH ROW
EXECUTE FUNCTION insertKardexEntrada();
---------------------------------------------------------------------------

/* Función para insertar un registro en la tabla kardex 'SALIDA',
cada vez que se realice una inserciÓn en la tabDetalleVenta.

esto a su vez permite que se actualice el stock y el valUnit en la 
tabArticulo cada vez que se haga una salida(venta).*/

CREATE OR REPLACE FUNCTION insertKardexSalida()
RETURNS TRIGGER AS 
$$
DECLARE
zValProm tabKardex.valProm%type :=0;
--zValTotal NUMERIC;
--zReciboMcia BIGINT;
zConsecDetVenta tabDetalleVenta.consecDetVenta%type;
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


--creamos el trigger
CREATE TRIGGER insertSalidaKardexSalida
AFTER INSERT ON tabDetalleVenta
FOR EACH ROW
EXECUTE FUNCTION insertKardexSalida();