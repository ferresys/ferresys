CREATE OR REPLACE FUNCTION insertReciboMercancia(
    zEanArt tabArticulo.eanArt%type,
    zCantArt tabArticulo.cantArt%type,
    zValCompra tabReciboMercancia.valCompra%type,
    zIdProv tabProveedor.idProv%type,
    zConsecMarca tabMarca.consecMarca%type,
    zObservacion tabReciboMercancia.observacion%type
) RETURNS void AS 
$$
DECLARE
    zMarca tabMarca.consecMarca%type;
    zCategoria tabCategoria.consecCateg%type;
    zValTotal tabReciboMercancia.valTotal%type,

BEGIN
        SELECT consecMarca INTO zMarca FROM tabMarca WHERE consecMarca = zConsecMarca;
        SELECT consecCateg INTO zCategoria FROM tabCategoria WHERE consecCateg = zConsecCateg;
        zValTotal := zCantArt * zValCompra;
            
        -- Insertar el nuevo registro de recibo de mercancia.
        INSERT INTO tabReciboMercancia(eanArt, cantArt, valCompra, valTotal, idProv, consecMarca, observacion)
        VALUES (zEanArt, zCantArt, zValCompra, zValTotal, zIdProv, zConsecMarca, zObservacion);

        RAISE NOTICE 'Artículo registrado con éxito';
    END IF;
END;
$$ 
LANGUAGE plpgsql;

-- zValTotal := zCantArt * zValCompra;