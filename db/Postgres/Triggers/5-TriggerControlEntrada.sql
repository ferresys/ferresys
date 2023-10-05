CREATE OR REPLACE FUNCTION validacionEntrada() RETURNS TRIGGER AS $$
DECLARE
    zStockMax tabArticulo.stockMax%type;
BEGIN
    -- obtenemos el valor del stock máximo de la tabArticulo
    SELECT stockMax INTO zStockMax FROM tabArticulo WHERE eanArt = NEW.eanArt;

    -- Verificar si la cantidad ingresada supera el stock máximo
    IF NEW.cantArt > zStockMax THEN
        RAISE EXCEPTION 'La cantidad ingresada supera el stock máximo establecido para: %', NEW.eanArt;
    END IF;

    -- Si la validación es exitosa, permite la inserción
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Creamos el trigger 
CREATE TRIGGER validacionEntrada
BEFORE INSERT ON tabReciboMercancia
FOR EACH ROW EXECUTE FUNCTION validacionEntrada();
--select * from tabArticulo;