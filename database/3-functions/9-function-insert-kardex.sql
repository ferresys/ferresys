/*--------------------------------------------------------------------------
    Función Trigger para realizar un registro en la tabla kardex 'ENTRADA',
    cada vez que se realice una inserciÓn en la tabReciboMercancia.

    Esto a su vez permite que se actualice el stock y el valUnit en la 
    tabArticulo cada vez que se haga una entrada(ReciboMercancia).
----------------------------------------------------------------------------*/

CREATE OR REPLACE FUNCTION insertKardexEntrada()
RETURNS TRIGGER AS 
$$

DECLARE
zValProm tabKardex.valProm%type;
zValTotal tabReciboMercancia.valTotal%type;
zReciboMcia tabReciboMercancia.consecReciboMcia%type;

BEGIN
    /* Si el tipo de movimiento es entrada*/
    SELECT valTotal INTO zValTotal FROM tabReciboMercancia where consecReciboMcia= new.consecReciboMcia;
    SELECT consecReciboMcia INTO zReciboMcia FROM tabReciboMercancia  where consecReciboMcia= new.consecReciboMcia;
    
    zValProm := zValTotal / new.cantArt;
    
    INSERT INTO tabKardex (consecReciboMcia,tipoMov, eanArt, cantArt, valProm) 
    VALUES (zReciboMcia, TRUE, NEW.eanArt, NEW.cantArt, zValProm);
        
    RETURN NEW;
   
END;
$$ 
LANGUAGE plpgsql;

--creamos el trigger
CREATE TRIGGER insertEntradaKardexEntrada
AFTER INSERT ON tabReciboMercancia
FOR EACH ROW
EXECUTE FUNCTION insertKardexEntrada();


/*---------------------------------------------------------------------------
    Función Trigger para realizar un registro en la tabla kardex 'SALIDA',
    cada vez que se realice una inserciÓn en la tabDetalleVenta.

    Esto a su vez permite que se actualice el stock y el valUnit en la 
    tabArticulo cada vez que se haga una salida(venta).
-----------------------------------------------------------------------------*/

CREATE OR REPLACE FUNCTION insertKardexSalida()
RETURNS TRIGGER AS 
$$

DECLARE
zValProm tabKardex.valProm%type :=0;

zConsecDetVenta tabDetalleVenta.consecDetVenta%type;

BEGIN
    
    SELECT consecDetVenta INTO zConsecDetVenta FROM tabDetalleVenta  where consecDetVenta= new.consecDetVenta;
    
        INSERT INTO tabKardex (
        tipoMov, eanArt, cantArt, consecDetVenta) 
        VALUES (FALSE, NEW.eanArt, NEW.cantArt, zConsecDetVenta);
        RETURN NEW;
   
END;
$$ LANGUAGE plpgsql;


--creamos el trigger
CREATE TRIGGER insertSalidaKardexSalida
AFTER INSERT ON tabDetalleVenta
FOR EACH ROW
EXECUTE FUNCTION insertKardexSalida();