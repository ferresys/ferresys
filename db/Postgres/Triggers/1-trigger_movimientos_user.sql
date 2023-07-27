/*cada movimiento que el usuario realice en la base de datos 
se vera reflejado en cada una de las tablas dependiendo de la 
tabla donde se realizo la insercion, actualizacion o borrado*/

CREATE OR REPLACE FUNCTION movimientos_user()
RETURNS TRIGGER AS 

$$
BEGIN
	IF TG_OP='INSERT' THEN
    	NEW.fec_insert := now();
    	NEW.user_insert := current_user;
		RETURN NEW;
	END IF;
	
	IF TG_OP='UPDATE' THEN
		NEW.fec_update := now();
		NEW.user_update := current_user;
		RETURN NEW;
	END IF;
	
	IF TG_OP= 'DELETE' THEN
	  INSERT INTO reg_borrados (fec_delete,user_delete,nom_tabla)
	  VALUES(current_timestamp,current_user,TG_RELNAME);
	
	  RETURN OLD;
	END IF ;

END;

$$ 
LANGUAGE plpgsql;

-- Crear el trigger en la tabla tab_usuario
CREATE TRIGGER trigger_tab_usuario
BEFORE INSERT OR UPDATE ON tab_usuario
FOR EACH ROW
EXECUTE FUNCTION movimientos_user();

CREATE TRIGGER trigger_reg_borrados
after delete on tab_usuario for each row execute procedure movimientos_user();

-- Crear el trigger en la tabla tab_cliente
CREATE TRIGGER trigger_tab_cliente
BEFORE INSERT OR UPDATE ON tab_cliente
FOR EACH ROW
EXECUTE FUNCTION movimientos_user();

CREATE TRIGGER trigger_reg_borrados
after delete on tab_cliente for each row execute procedure movimientos_user();

-- Crear el trigger en la tabla tab_proveedor
CREATE TRIGGER trigger_tab_proveedor
BEFORE INSERT OR UPDATE ON tab_proveedor
FOR EACH ROW
EXECUTE FUNCTION movimientos_user();

CREATE TRIGGER trigger_reg_borrados
after delete on tab_proveedor for each row execute procedure movimientos_user();

-- Crear el trigger en la tabla tab_categoria
CREATE TRIGGER trigger_tab_categoria
BEFORE INSERT OR UPDATE ON tab_categoria
FOR EACH ROW
EXECUTE FUNCTION movimientos_user();

CREATE TRIGGER trigger_reg_borrados
after delete on tab_categoria for each row execute procedure movimientos_user();

-- Crear el trigger en la tabla tab_marca
CREATE TRIGGER trigger_tab_marca
BEFORE INSERT OR UPDATE ON tab_marca
FOR EACH ROW
EXECUTE FUNCTION movimientos_user();

CREATE TRIGGER trigger_reg_borrados
after delete on tab_marca for each row execute procedure movimientos_user();

-- Crear el trigger en la tabla tab_articulo
CREATE TRIGGER trigger_tab_articulo
BEFORE INSERT OR UPDATE ON tab_articulo
FOR EACH ROW
EXECUTE FUNCTION movimientos_user();

CREATE TRIGGER trigger_reg_borrados
after delete on tab_articulo for each row execute procedure movimientos_user();

-- Crear el trigger en la tabla tab_kardex
CREATE TRIGGER trigger_tab_kardex
BEFORE INSERT OR UPDATE ON tab_kardex
FOR EACH ROW
EXECUTE FUNCTION movimientos_user();

CREATE TRIGGER trigger_reg_borrados
after delete on tab_kardex for each row execute procedure movimientos_user();

-- Crear el trigger en la tabla tab_artxprov
CREATE TRIGGER trigger_tab_artxprov
BEFORE INSERT OR UPDATE ON tab_artxprov
FOR EACH ROW
EXECUTE FUNCTION movimientos_user();

CREATE TRIGGER trigger_reg_borrados
after delete on tab_artxprov for each row execute procedure movimientos_user();

-- Crear el trigger en la tabla tab_encabezado_venta
CREATE TRIGGER trigger_tab_encabezado_venta
BEFORE INSERT OR UPDATE ON tab_encabezado_venta
FOR EACH ROW
EXECUTE FUNCTION movimientos_user();

CREATE TRIGGER trigger_reg_borrados
after delete on tab_encabezado_venta for each row execute procedure movimientos_user();

-- Crear el trigger en la tabla tab_detalle_venta
CREATE TRIGGER trigger_tab_detalle_venta
BEFORE INSERT OR UPDATE ON tab_detalle_venta
FOR EACH ROW
EXECUTE FUNCTION movimientos_user();

CREATE TRIGGER trigger_reg_borrados
after delete on tab_detalle_venta for each row execute procedure movimientos_user();