CREATE OR REPLACE FUNCTION validacionSalida() 
RETURNS TRIGGER AS 

$$
DECLARE
    zValStock tabArticulo.valStock%type;
    zStockMin tabArticulo.stockMin%type;
    zStockMax tabArticulo.stockMax%type;
    zVar NUMERIC;

BEGIN
    
    SELECT valStock, stockMin, stockMax INTO zValStock, zStockMin, zStockMax FROM tabArticulo WHERE eanArt = NEW.eanArt;
    zVar := ABS(NEW.cantArt - zValStock);

        --Estas son las restricciones
        CASE
            
            WHEN NEW.cantArt <= 0 THEN
                RAISE EXCEPTION 'Debe ingresar una cantidad válida';

            WHEN zVar > 0 AND zVar < zStockMin THEN
                RAISE EXCEPTION 'La cantidad de salida hace que el stock actual quede por debajo del stock mínimo';

            WHEN NEW.cantArt > zStockMax THEN
                RAISE EXCEPTION 'La cantidad supera las existencias en stock máximo';

            WHEN NEW.cantArt >= zValStock THEN
                RAISE EXCEPTION 'La cantidad supera las existencias en stock';
            
            WHEN zValStock IS NULL OR zValStock <= 0 THEN
                RAISE EXCEPTION 'No se puede realizar la operación, stock en cero';
            ELSE

        END CASE;

        CASE 
            -- Que sea la salida sea mayor al stock mínimo
            WHEN zVar <= 0 THEN
                RAISE NOTICE 'Exitoso mayor del stock mínimo';
            ELSE

        END CASE;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validacionSalida
BEFORE INSERT ON tabDetalleVenta
FOR EACH ROW
EXECUTE FUNCTION validacionSalida();

--SELECT * from tabArticulo
--SELECT insertDetalleVenta ('00000001', 50, 0);
--SELECT insertDetalleVenta ('00000002', 50, 0);