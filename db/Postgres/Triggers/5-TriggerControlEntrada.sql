CREATE OR REPLACE FUNCTION validacionEntrada() RETURNS TRIGGER AS $$
DECLARE
    zStockMax tabArticulo.stockMax%type;
    zValStock tabArticulo.valStock%type;
    zCantArtZvalStock NUMERIC;

BEGIN
    -- obtenemos el valor del stock máximo de la tabArticulo
    SELECT stockMax, valStock INTO zStockMax, zValStock FROM tabArticulo WHERE eanArt = NEW.eanArt;
    zCantArtZvalStock := NEW.cantArt + zValStock;

    CASE
        -- Verificar si la cantidad ingresada supera el stock máximo
        WHEN NEW.cantArt > zStockMax THEN
            RAISE EXCEPTION 'La cantidad ingresada supera el stock máximo establecido para: %', NEW.eanArt;

        WHEN zCantArtZvalStock > zStockMax THEN
            RAISE EXCEPTION 'Las cantidades de entrada superaron el stock máximo';
        ELSE

    END CASE;

    -- Si la validación es exitosa, permite la inserción
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Creamos el trigger 
CREATE TRIGGER triggerValidacionEntrada
BEFORE INSERT ON tabReciboMercancia
FOR EACH ROW EXECUTE FUNCTION validacionEntrada();

--SELECT * from tabArticulo
--SELECT insertReciboMercancia('00000001', 300, 5000, '0-12', '1', '1', 'pulidora en buen estado');
--SELECT insertReciboMercancia('00000002', 30, 1000, '0-12', '2', '2', 'Alambre eléctrico');