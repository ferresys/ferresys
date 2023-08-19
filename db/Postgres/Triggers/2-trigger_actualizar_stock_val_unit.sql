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

BEGIN

  IF NEW.tipoMov = 'ENTRADA' THEN
    	zValStock := (SELECT COALESCE(valStock, 0) + NEW.cantArt FROM tabArticulo WHERE eanArt = NEW.eanArt);
    	zValUnit := NEW.ValProm * zPorcentaje; --(el porcentaje debe ser ingresado como 1.20, 1.30, 1.10..etc)
	
  	 ELSIF NEW.tipoMov = 'SALIDA' THEN
    	zValStock := (SELECT COALESCE(valStock, 0) - NEW.cantArt FROM tabArticulo WHERE eanArt = NEW.eanArt);
    	zValUnit := (SELECT valUnit FROM tabArticulo WHERE eanArt = NEW.eanArt);
  END IF;

  UPDATE tabArticulo SET valStock = zValStock, valUnit = zValUnit WHERE eanArt = NEW.eanArt;

RETURN NEW;
END;
$$ 
LANGUAGE plpgsql;

CREATE TRIGGER triggerActualizarStockValUnit
AFTER INSERT ON tabKardex
FOR EACH ROW
EXECUTE FUNCTION actualizarStockValUnit();

