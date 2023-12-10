

--SELECT insertReciboMercancia('00001', 20, 5000, '1234569825-4', 'pulidora en buen estado');


--Función para insertar Recibo de Mercancia

CREATE OR REPLACE FUNCTION insertReciboMercancia(
    zEanArt tabReciboMercancia.eanArt%type,
    zCantArt tabReciboMercancia.cantArt%type,
    zValCompra tabReciboMercancia.valCompra%type,
    zIdProv tabProveedor.idProv%type,
    zObservacion tabReciboMercancia.observacion%type
) RETURNS void AS 
$$
DECLARE
    zValTotal tabReciboMercancia.valTotal%type;

BEGIN

IF zCantArt <= 0 THEN
    RAISE EXCEPTION 'La cantidad debe ser un número positivo';
END IF;


zValTotal := zCantArt * zValCompra;

IF EXISTS (SELECT 1 FROM tabReciboMercancia WHERE eanArt = zEanArt) THEN

   INSERT INTO tabReciboMercancia(eanArt, cantArt, valCompra, valTotal, idProv, observacion)
        VALUES (zEanArt, zCantArt, zValCompra, zValTotal, zIdProv, zObservacion);
    
ELSE     
        -- Insertar el nuevo registro de recibo de mercancia.
   INSERT INTO tabReciboMercancia(eanArt, cantArt, valCompra, valTotal, idProv, observacion)
   VALUES (zEanArt, zCantArt, zValCompra, zValTotal, zIdProv, zObservacion);

   RAISE NOTICE 'Artículo registrado con éxito';
        
END IF; 
END;
$$ 
LANGUAGE plpgsql;
