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
    zVar := NEW.cantArt + zValStock;

        --Estas son las restricciones
        CASE
            
            WHEN NEW.cantArt <= 0 THEN -- Verificar que el valor ingresado corresponda a una cantidad contable positiva
                RAISE EXCEPTION 'Debe ingresar una cantidad';

            WHEN zVar > 0 AND zVar < zStockMin THEN -- La salida no puede ser menor que el stock mínimo
                RAISE EXCEPTION 'La cantidad de salida no puede ser menor que el stock mínimo';

            -- No puede sacar la misma cantidad de stock actual o mayor ya que viola la restricción del stock mínimo
            -- Verifica que el valor ingresado no supere al atributo StockMax (Stock Máximo)
            WHEN NEW.cantArt >= zValStock OR NEW.cantArt > zStockMax THEN
                RAISE EXCEPTION 'La cantidad supera las existencias en stock / stock máximo';
            
            WHEN zValStock IS NULL OR zValStock <= 0 THEN -- Verificar el valor de stock no esté en mínimo o sea menor/igual que cero
                RAISE EXCEPTION 'No se puede realizar la operación, stock negativo o en cero';
            ELSE

        END CASE;

        -- Este es el caso valido
        CASE 
            -- Que sea la salida sea mayor al stock mínimo
            WHEN zVar <= 0 THEN
                RAISE NOTICE 'Exitoso mayor del stock mínimo';
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

/*
CREATE OR REPLACE FUNCTION validacionSalida() 
RETURNS TRIGGER AS 
$$
DECLARE
    zValStock tabArticulo.valStock%type;
    zStockMin tabArticulo.stockMin%type;
    zStockMax tabArticulo.stockMax%type;
    zVar NUMERIC;

BEGIN
    -- Obtenemos el valor del stock actual de la tabArticulo
    SELECT valStock, stockMin, stockMax INTO zValStock, zStockMin, zStockMax FROM tabArticulo WHERE eanArt = NEW.eanArt;
    
    -- Calculamos la diferencia entre la cantidad actual y el stock mínimo
    zVar := zValStock - NEW.cantArt;

    -- Estas son las restricciones
    CASE
        -- Verificar que el valor ingresado corresponda a una cantidad contable positiva
        WHEN NEW.cantArt <= 0 THEN
            RAISE EXCEPTION 'Debe ingresar una cantidad positiva';

        -- La salida no puede ser menor que el stock mínimo
        WHEN zVar > 0 AND zVar < zStockMin THEN
            RAISE EXCEPTION 'La cantidad de salida no puede ser menor que el stock mínimo';

        -- Verifica que el valor ingresado no supere al atributo StockMax (Stock Máximo)
        WHEN NEW.cantArt > zStockMax THEN
            RAISE EXCEPTION 'La cantidad supera el stock máximo';

        -- Verificar el valor de stock no esté en mínimo o sea menor/igual que cero
        WHEN zValStock IS NULL OR zValStock <= 0 THEN
            RAISE EXCEPTION 'No se puede realizar la operación, stock negativo o en cero';

        ELSE
            -- Esto se ejecutará si no se cumple ninguna de las condiciones anteriores
    END CASE;

    -- Este es el caso válido
    CASE 
        -- Que la salida sea mayor o igual al stock mínimo
        WHEN zVar <= 0 THEN
            RAISE NOTICE 'Salida válida';
    END CASE;

    -- Si la validación es exitosa, permite la inserción
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
*/