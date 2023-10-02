-- TRIGGER para control del stock en Kardex

/*
No permitir la salida de un artículo si el stock es menor al valor stockmin

Y no permitir el ingreso de artículos si la cantidad supera el stockmax.

Tenga presente que el stock no puede quedar en 0. Ya que la idea del sistema es que el administrador elija un stockmin por ejemplo 10. Y que cuando el stock llegue a 10, no deje sacar más artículos.
https://github.com/Yocser/InvAdso2023/blob/main/PROYECTO_INVENTARIO-VENTAS/Funciones/1-KARDEX%20CORRECTO.sql
*/

CREATE OR REPLACE FUNCTION ControlKardex ()
RETURNS TRIGGER AS

$$
DECLARE
  zValStock tabArticulo.valStock%type;
  zStockMin tabArticulo.stockMin%type;
  zStockMax tabArticulo.stockMax%type;
  zCantArt tabDetalleVenta.cantArt%type;
  zTipoMov tabKardex.tipoMov%type;

BEGIN

    --SELECT tipoMov INTO zTipoMov FROM tabKardex WHERE eanArt = NEW.enArt;
    SELECT valStock, stockMin, stockMax INTO zValStock, zStockMin, zStockMax FROM tabArticulo WHERE zEanArt = NEW.eanArt;
    SELECT cantArt INTO zCantArt FROM tabDetalleVenta WHERE zEanArt = NEW.eanArt;

    -- SELECT ztipoMov WHERE ztipoMov = TRUE
    IF ztipoMov = TRUE THEN -- ENTRADA / tipoMov = TRUE

        IF CantArt <= zValStock AND CantArt <= zStockMax AND CantArt > zStockMin  THEN
            RAISE EXCEPTION 'Operación completa';
            RAISE NOTICE 'Exitoso';
        END IF;
    END IF;

    IF ztipoMov = FALSE THEN -- SALIDA / tipoMov = FALSE

        IF zCantArt > zValStock THEN
            RAISE EXCEPTION 'La cantidad de salida supera el stock disponible.';
            RAISE NOTICE 'Error 1';
        END IF;

        IF (zCantArt - zValStock) < zStockMin THEN
            RAISE EXCEPTION 'No se puede realizar la operacion, el stock hara que sea menor que el stock minimo';
            RAISE NOTICE 'Error 4';
        END IF;

        IF zValStock IS NULL OR zValStock <= 0 THEN
            RAISE EXCEPTION 'No se puede realizar la operacion, stock negativo';
            RAISE NOTICE 'Error NULL';
        END IF;
    END IF;

    -- UPDATE tabArticulo SET valStock = zValStock, valUnit = zValUnit WHERE eanArt = NEW.eanArt;

  RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER ControlKardex
BEFORE INSERT ON tabKardex
FOR EACH ROW
EXECUTE FUNCTION ControlKardex();