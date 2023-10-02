/*esta función trigger es importante para:
cuando el usuario ingrese datos en el kardex ya sea de entrada o de salida
debemos llamar esta función para que me actualice los datos 
valStock y valUnit en la tabArticulo*/

CREATE OR REPLACE FUNCTION actualizarStockValUnitEntradas()
RETURNS TRIGGER AS 

$$
DECLARE
  zValStock tabArticulo.valStock%type;
  zValUnit tabArticulo.valUnit%type;
  zPorcentaje tabArticulo.porcentaje%type;
  zValPromedio tabKardex.valprom%type;
  
BEGIN

select sum(valProm ) into zValPromedio from tabKardex WHERE eanArt = NEW.eanArt;
select Porcentaje into zPorcentaje from tabArticulo where eanArt = NEW.eanArt;
 
zValStock := (SELECT COALESCE(valStock, 0) + NEW.cantArt FROM tabArticulo WHERE eanArt = NEW.eanArt);
zValUnit :=zValPromedio* zPorcentaje ;
  	

UPDATE tabArticulo SET valStock = zValStock, valUnit = zValUnit WHERE eanArt = NEW.eanArt;

RETURN NEW;
END;
$$ 
LANGUAGE plpgsql;

--Creamos el trigger 
CREATE TRIGGER triggerActualizarStockValUnitEntradas
AFTER INSERT ON tabReciboMercancia
FOR EACH ROW
EXECUTE FUNCTION actualizarStockValUnitEntradas();

-------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION actualizarStockValUnitSalidas()
RETURNS TRIGGER AS 

$$
DECLARE
  zValStock tabArticulo.valStock%type;
  zValUnit tabArticulo.valUnit%type;
  --zPorcentaje tabArticulo.porcentaje%type;

BEGIN
--select Porcentaje into zPorcentaje from tabArticulo where eanArt = NEW.eanArt;
 -- IF NEW.tipoMov = TRUE THEN
    	--zValStock := (SELECT COALESCE(valStock, 0) + NEW.cantArt FROM tabArticulo WHERE eanArt = NEW.eanArt);
    	--zValUnit := NEW.valProm * zPorcentaje ; --(el porcentaje debe ser ingresado como 1.20, 1.30, 1.10..etc)
	--zValUnit :=(select valProm from tabKardex where consecKardex= consecKardex)* zPorcentaje ;
  	-- ELSIF NEW.tipoMov = FALSE THEN
    	zValStock := (SELECT COALESCE(valStock, 0) - NEW.cantArt FROM tabArticulo WHERE eanArt = NEW.eanArt);
    	zValUnit := (SELECT valUnit FROM tabArticulo WHERE eanArt = NEW.eanArt);
  --END IF;*/

  UPDATE tabArticulo SET valStock = zValStock, valUnit = zValUnit WHERE eanArt = NEW.eanArt;

RETURN NEW;
END;
$$ 
LANGUAGE plpgsql;

--creamos el trigger
CREATE TRIGGER triggerActualizarStockValUnitSalidas
AFTER INSERT ON tabDetalleVenta
FOR EACH ROW
EXECUTE FUNCTION actualizarStockValUnitSalidas();

-------------------------------------------------------------------------------------------------------------------

-- TRIGGER para control del stock en Kardex

/*
No permitir la salida de un artículo si el stock es menor al valor stockmin

Y no permitir el ingreso de artículos si la cantidad supera el stockmax.

Tenga presente que el stock no puede quedar en 0. Ya que la idea del sistema es que el administrador elija un stockmin por ejemplo 10. Y que cuando el stock llegue a 10, no deje sacar más artículos.
https://github.com/Yocser/InvAdso2023/blob/main/PROYECTO_INVENTARIO-VENTAS/Funciones/1-KARDEX%20CORRECTO.sql
*/

CREATE OR REPLACE FUNCTION ControlKardex () RETURNS BOOLEAN AS

DECLARE
  zValStock tabArticulo.valStock%type;
  zStockMin tabArticulo.stockMin%type;
  zStockMax tabArticulo.stockMax%type;
  zCantArt tabDetalleVenta.cantArt%type;
  zTipoMov tabKardex.tipoMov%type;

$$
BEGIN
-- newStock := zValStock - zCantArt

SELECT tipoMov INTO zTipoMov FROM tabKardex WHERE eanArt = NEW.e nArt;
SELECT valStock, stockMin, stockMax INTO zValStock, zStockMin, zStockMax FROM tabArticulo WHERE zEanArt = NEW.eanArt;
SELECT cantArt INTO zCantArt FROM tabDetalleVenta WHERE zEanArt = NEW.eanArt;
 
-- ENTRADA / tipoMov = TRUE
  IF ztipoMov = TRUE THEN

    ELSIF zCantArt <= zValStock AND => zStockMin THEN
      RAISE EXCEPTION 'Operación completa';
      RAISE NOTICE 'Exitoso'
      RETURN TRUE;

  -- SALIDA / tipoMov = FALSE
  IF zCantArt > zValStock THEN
    RAISE EXCEPTION 'La cantidad de salida supera el stock disponible.';
    RETURN NULL;
  END IF;
      
  IF zCantArt > zValStock AND zStockMax THEN
    RAISE EXCEPTION 'No se puede realizar la operación, la compra supera el stock y stock maximo';
    RAISE NOTICE 'Error 1'
    RETURN NULL;

  ELSIF zCantArt > (zValStock - zStockMin) THEN
    RAISE EXCEPTION 'La salida de este artículo hará que el stock sea menor que stockMin.';
    RAISE NOTICE 'Error 2'
    RETURN NULL;

  ELSIF zValStock <= 0 THEN
    RAISE EXCEPTION 'No se puede realizar la operacion, stock negativo';
    RAISE NOTICE 'Error 3'
    RETURN NULL;

  ELSIF (zCantArt - zValStock) < zStockMin THEN
    RAISE EXCEPTION 'No se puede realizar la operacion, el stock hara que sea menor que el stock minimo';
    RAISE NOTICE 'Error 4'
    RETURN NULL;

  ELSE
    RETURN TRUE;

  UPDATE tabArticulo SET valStock = zValStock, valUnit = zValUnit WHERE eanArt = NEW.eanArt;

RETURN NEW;
END; 
$$
LANGUAGE plpgsql;

CREATE TRIGGER ControlKardex
BEFORE INSERT ON tabKardex
FOR EACH ROW
EXECUTE FUNCTION ControlKardex();