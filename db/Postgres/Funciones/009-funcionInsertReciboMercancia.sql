--SELECT insertReciboMercancia('00000001', 20, 5000, '0-12', '1', '1', 'pulidora en buen estado');
--select * from tabReciboMercancia;
--select * from tabproveedor;
--select * from tabMarca;

CREATE OR REPLACE FUNCTION insertReciboMercancia(
    zEanArt tabArticulo.eanArt%type,
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
   -- zCategoria tabCategoria.consecCateg%type;
    zValTotal tabReciboMercancia.valTotal%type;

BEGIN
        SELECT consecMarca INTO zMarca FROM tabMarca WHERE consecMarca = zConsecMarca;
        --SELECT consecCateg INTO zCategoria FROM tabCategoria WHERE consecCateg = zConsecCateg;
        zValTotal := zCantArt * zValCompra;
            
        -- Insertar el nuevo registro de recibo de mercancia.
        INSERT INTO tabReciboMercancia(eanArt, cantArt, valCompra, valTotal, idProv, consecMarca, observacion)
        VALUES (zEanArt, zCantArt, zValCompra, zValTotal, zIdProv, zConsecMarca, zObservacion);

        RAISE NOTICE 'Artículo registrado con éxito';
    
END;
$$ 
LANGUAGE plpgsql;
