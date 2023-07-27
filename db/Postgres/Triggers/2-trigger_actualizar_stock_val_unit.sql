/*esta funcion trigger es importante para:
cuando el usuario ingrese datos en el kardex ya sea de entrada o de salida
debo llamar esta funcion para que me actualice los datos 
val_stock y val_unit en la tab_articulo*/

CREATE OR REPLACE FUNCTION actualizar_stock_val_unit()
RETURNS TRIGGER AS 

$$
DECLARE
  zval_stock tab_articulo.val_stock%type;
  zval_unit tab_articulo.val_unit%type;
  
BEGIN

  IF NEW.tipo_mov = 'ENTRADA' THEN
    	zval_stock := (SELECT COALESCE(val_stock, 0) + NEW.cant_art FROM tab_articulo WHERE ean_art = NEW.ean_art);
    	zval_unit := NEW.val_prom * 1.20;
	
  	 ELSIF NEW.tipo_mov = 'SALIDA' THEN
    	zval_stock := (SELECT COALESCE(val_stock, 0) - NEW.cant_art FROM tab_articulo WHERE ean_art = NEW.ean_art);
    	zval_unit := (SELECT val_unit FROM tab_articulo WHERE ean_art = NEW.ean_art);
  END IF;

  UPDATE tab_articulo SET val_stock = zval_stock, val_unit = zval_unit WHERE ean_art = NEW.ean_art;

RETURN NEW;
END;
$$ 
LANGUAGE plpgsql;

CREATE TRIGGER trigger_actualizar_stock_val_unit
AFTER INSERT ON tab_kardex
FOR EACH ROW
EXECUTE FUNCTION actualizar_stock_val_unit();

