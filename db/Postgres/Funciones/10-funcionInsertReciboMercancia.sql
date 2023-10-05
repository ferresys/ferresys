--SELECT insertReciboMercancia('00000001', 1000, 5000, '0-12', '1', '1', 'pulidora en buen estado');
--SELECT insertReciboMercancia('00000002', 30, 1000, '0-12', '2', '2', 'Alambre eléctrico');
--SELECT insertReciboMercancia('00000002', 10, 8000, '0-12', '2', '2', 'Alambre eléctrico');
--select * from tabReciboMercancia;
--select * from tabproveedor;
--select * from tabMarca;
--select * from tabArticulo;
--select * from tabKardex;
--DELETE FROM tabKardex;
--DELETE FROM tabReciboMercancia;

CREATE OR REPLACE FUNCTION insertReciboMercancia(
    zEanArt tabReciboMercancia.eanArt%type,
    zCantArt tabReciboMercancia.cantArt%type,
    zValCompra tabReciboMercancia.valCompra%type,
    zIdProv tabProveedor.idProv%type,
    zConsecMarca tabMarca.consecMarca%type,
	zConsecCateg tabCategoria.consecCateg%type,
    zObservacion tabReciboMercancia.observacion%type
) RETURNS void AS 
$$
DECLARE
    zMarca tabMarca.consecMarca%type;
    zValTotal tabReciboMercancia.valTotal%type;

BEGIN

SELECT consecMarca INTO zMarca FROM tabMarca WHERE consecMarca = zConsecMarca;
zValTotal := zCantArt * zValCompra;

IF EXISTS (SELECT 1 FROM tabReciboMercancia WHERE eanArt = zEanArt) THEN

   INSERT INTO tabReciboMercancia(eanArt, cantArt, valCompra, valTotal, idProv, consecMarca, observacion)
        VALUES (zEanArt, zCantArt, zValCompra, zValTotal, zIdProv, zConsecMarca, zObservacion);
	
ELSE     
        -- Insertar el nuevo registro de recibo de mercancia.
   INSERT INTO tabReciboMercancia(eanArt, cantArt, valCompra, valTotal, idProv, consecMarca, observacion)
   VALUES (zEanArt, zCantArt, zValCompra, zValTotal, zIdProv, zConsecMarca, zObservacion);

   RAISE NOTICE 'Artículo registrado con éxito';
		
END IF;	
END;
$$ 
LANGUAGE plpgsql;
