-- TRIGGER para control del stock en Kardex

/*
No permitir la salida de un artículo si el stock es menor al valor stockmin

Y no permitir el ingreso de artículos si la cantidad supera el stockmax.

Tenga presente que el stock no puede quedar en 0. Ya que la idea del sistema es que el administrador elija un stockmin por ejemplo 10. Y que cuando el stock llegue a 10, no deje sacar más artículos.
https://github.com/Yocser/InvAdso2023/blob/main/PROYECTO_INVENTARIO-VENTAS/Funciones/1-KARDEX%20CORRECTO.sql
*/

CREATE OR REPLACE FUNCTION controlKardex ()
RETURNS TRIGGER AS

$$
DECLARE
  zValStock tabArticulo.valStock%type;
  zStockMin tabArticulo.stockMin%type;
  zStockMax tabArticulo.stockMax%type;
  zCantArt tabDetalleVenta.cantArt%type;

BEGIN
    SELECT valStock, stockMin, stockMax INTO zValStock, zStockMin, zStockMax FROM tabArticulo WHERE eanArt = NEW.eanArt;
    SELECT cantArt INTO zCantArt FROM tabDetalleVenta WHERE eanArt = NEW.eanArt;

    IF FOUND THEN
        RAISE NOTICE '%', zValStock;

        -- ENTRADA / tipoMov = TRUE
        IF zCantArt <= zStockMax AND zCantArt > 0 THEN
            RAISE NOTICE 'Exitoso';
        -- SALIDA / tipoMov = FALSE
        ELSIF zCantArt <= 0 THEN
            RAISE NOTICE 'Debe ingresar una cantidad';
        ELSIF zCantArt > zValStock OR zCantArt > zStockMax THEN
            RAISE NOTICE 'La cantidad de salida supera el stock disponible';
        ELSIF ABS(zCantArt - zValStock) < zStockMin THEN
            RAISE NOTICE 'No se puede realizar la operación, el stock hará que sea menor que el stock mínimo';
        ELSIF zCantArt = zValStock AND zValStock <= zStockMin THEN
            RAISE NOTICE 'La cantidad supera las existencias mínimas en stock';
        ELSIF zValStock IS NULL OR zValStock <= 0 THEN
            RAISE EXCEPTION 'No se puede realizar la operación, stock negativo o en cero';
        END IF;
    END IF;

    --SELECT * from tabArticulo
    --SELECT insertReciboMercancia('00000001', 20, 5000, '0-12', '1', '1', 'pulidora en buen estado');
    --SELECT insertReciboMercancia('00000002', 30, 1000, '0-12', '2', '2', 'Alambre eléctrico');
    --SELECT insertReciboMercancia('00000002', 10, 8000, '0-12', '2', '2', 'Alambre eléctrico');
    --SELECT insertReciboMercancia('00000002', -700, 8000, '0-12', '2', '2', 'Alambre eléctrico');
	--SELECT insertReciboMercancia('00000002', 350, 8000, '0-12', '2', '2', 'Alambre eléctrico');
	--SELECT insertDetalleVenta ('00000002', 50, 0);

    --UPDATE tabArticulo SET valStock = zValStock WHERE eanArt = NEW.eanArt;

  RETURN NEW;
END;
$$
LANGUAGE plpgsql;

-- Trigger para tabReciboMercancia
CREATE TRIGGER ControlKardexReciboMercancia
BEFORE INSERT ON tabReciboMercancia
FOR EACH ROW
EXECUTE FUNCTION controlKardex();

-- Trigger para tabDetalleVenta
CREATE TRIGGER ControlKardexDetalleVenta
BEFORE INSERT ON tabDetalleVenta
FOR EACH ROW
EXECUTE FUNCTION controlKardex();