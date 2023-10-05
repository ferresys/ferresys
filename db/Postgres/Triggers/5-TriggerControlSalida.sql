CREATE OR REPLACE FUNCTION validacionSalida() 
RETURNS TRIGGER AS 

$$
DECLARE
    zValStock tabArticulo.valStock%type;
    zStockMin tabArticulo.stockMin%type;
    zStockMax tabArticulo.stockMax%type;

BEGIN
    -- obtenemos el valor del stock máximo de la tabArticulo
    SELECT valStock, stockMin, stockMax INTO zValStock, zStockMin, zStockMax FROM tabArticulo WHERE eanArt = NEW.eanArt;
    zCantArtZvalStock := NEW.cantArt + zValStock;

        CASE
            -- Verificar que el valor ingresado corresponda a una cantidad contable positiva
            WHEN NEW.cantArt <= 0 THEN
                RAISE NOTICE 'Debe ingresar una cantidad';
            
            -- Verifica que el valor ingresado no supere al atributo StockMax (Stock Máximo)
            WHEN NEW.cantArt > zStockMax THEN
                RAISE NOTICE 'La cantidad de salida supera el stock máximo';

            -- No puede sacar la misma cantidad de stock actual ya que viola la restricción del stock mínimo 
            WHEN NEW.cantArt = zValStock AND zValStock <= zStockMin THEN
                RAISE NOTICE 'La cantidad supera las existencias mínimas en stock';
            
            -- Verificar el valor de stock no esté en mínimo o sea menor/igual que cero
            WHEN zValStock IS NULL OR zValStock <= 0 THEN
                RAISE EXCEPTION 'No se puede realizar la operación, stock negativo o en cero';
            ELSE

        END CASE;

    -- Si la validación es exitosa, permite la inserción
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Creamos el trigger
CREATE TRIGGER validacionSalida
BEFORE INSERT ON tabDetalleVenta
FOR EACH ROW
EXECUTE FUNCTION validacionSalida();

--SELECT * from tabArticulo
--SELECT insertDetalleVenta ('00000001', 50, 0);
--SELECT insertDetalleVenta ('00000002', 50, 0);