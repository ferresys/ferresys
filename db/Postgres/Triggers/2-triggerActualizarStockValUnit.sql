/*esta funcion trigger es importante para:
cuando el usuario ingrese datos en el kardex ya sea de entrada o de salida
debo llamar esta funcion para que me actualice los datos 
val_stock y val_unit en la tab_articulo*/



CREATE OR REPLACE FUNCTION actualizarStockValUnit()
RETURNS TRIGGER AS 

$$
DECLARE
  zValStock tabArticulo.valStock%type;
  zValUnit tabArticulo.valUnit%type;
  zPorcentaje NUMERIC(10,2);
	zValPromedio NUMERIC(10);
BEGIN
select valProm  into zValPromedio from tabKardex WHERE consecKardex =consecKardex ;
select Porcentaje into zPorcentaje from tabArticulo where eanArt = NEW.eanArt;
 
    	zValStock := (SELECT COALESCE(valStock, 0) + NEW.cantArt FROM tabArticulo WHERE eanArt = NEW.eanArt);
    	--zValUnit := NEW.valProm * zPorcentaje ; --(el porcentaje debe ser ingresado como 1.20, 1.30, 1.10..etc)
	zValUnit :=zValPromedio* zPorcentaje ;
  	/*-- ELSIF NEW.tipoMov = FALSE THEN
    	zValStock := (SELECT COALESCE(valStock, 0) - NEW.cantArt FROM tabArticulo WHERE eanArt = NEW.eanArt);
    	zValUnit := (SELECT valUnit FROM tabArticulo WHERE eanArt = NEW.eanArt);
  --END IF;*/

  UPDATE tabArticulo SET valStock = zValStock, valUnit = zValUnit WHERE eanArt = NEW.eanArt;

RETURN NEW;
END;
$$ 
LANGUAGE plpgsql;

CREATE TRIGGER triggerActualizarStockValUnit1
AFTER INSERT ON tabReciboMercancia
FOR EACH ROW
EXECUTE FUNCTION actualizarStockValUnit();


-------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION actualizarStockValUnit2()
RETURNS TRIGGER AS 

$$
DECLARE
  zValStock tabArticulo.valStock%type;
  zValUnit tabArticulo.valUnit%type;
  zPorcentaje NUMERIC(10,2);

BEGIN
select Porcentaje into zPorcentaje from tabArticulo where eanArt = NEW.eanArt;
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

CREATE TRIGGER triggerActualizarStockValUnit2
AFTER INSERT ON tabDetalleVenta
FOR EACH ROW
EXECUTE FUNCTION actualizarStockValUnit2();

