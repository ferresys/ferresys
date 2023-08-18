/*cada movimiento que el usuario realice en la base de datos 
se vera reflejado en cada una de las tablas dependiendo de la 
tabla donde se realizo la insercion, actualizacion o borrado*/

CREATE OR REPLACE FUNCTION movimientosAdmin()
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
	  INSERT INTO tabRegBorrados (fec_delete,user_delete,nom_tabla)
	  VALUES(current_timestamp,current_user,TG_RELNAME);
	
	  RETURN OLD;
	END IF ;

END;

$$ 
LANGUAGE plpgsql;

-- Crear el trigger en la tabla tabAdmin
CREATE TRIGGER triggerTabAdmin
BEFORE INSERT OR UPDATE ON tabAdmin
FOR EACH ROW
EXECUTE FUNCTION movimientosAdmin();

CREATE TRIGGER triggertabRegBorrados
after delete on tabAdmin for each row execute procedure movimientosAdmin();

-- Crear el trigger en la tabla tabCliente
CREATE TRIGGER triggerTabCliente
BEFORE INSERT OR UPDATE ON tabCliente
FOR EACH ROW
EXECUTE FUNCTION movimientosAdmin();

CREATE TRIGGER triggertabRegBorrados
after delete on tabCliente for each row execute procedure movimientosAdmin();

-- Crear el trigger en la tabla tabProveedor
CREATE TRIGGER triggertabProveedor
BEFORE INSERT OR UPDATE ON tabProveedor
FOR EACH ROW
EXECUTE FUNCTION movimientosAdmin();

CREATE TRIGGER triggertabRegBorrados
after delete on tabProveedor for each row execute procedure movimientosAdmin();

-- Crear el trigger en la tabla tabCategoria
CREATE TRIGGER triggertabCategoria
BEFORE INSERT OR UPDATE ON tabCategoria
FOR EACH ROW
EXECUTE FUNCTION movimientosAdmin();

CREATE TRIGGER triggertabRegBorrados
after delete on tabCategoria for each row execute procedure movimientosAdmin();

-- Crear el trigger en la tabla tabMarca
CREATE TRIGGER triggertabMarca
BEFORE INSERT OR UPDATE ON tabMarca
FOR EACH ROW
EXECUTE FUNCTION movimientosAdmin();

CREATE TRIGGER triggertabRegBorrados
after delete on tabMarca for each row execute procedure movimientosAdmin();

-- Crear el trigger en la tabla tabArticulo
CREATE TRIGGER triggertabArticulo
BEFORE INSERT OR UPDATE ON tabArticulo
FOR EACH ROW
EXECUTE FUNCTION movimientosAdmin();

CREATE TRIGGER triggertabRegBorrados
after delete on tabArticulo for each row execute procedure movimientosAdmin();

-- Crear el trigger en la tabla tabKardex
CREATE TRIGGER triggertabKardex
BEFORE INSERT OR UPDATE ON tabKardex
FOR EACH ROW
EXECUTE FUNCTION movimientosAdmin();

CREATE TRIGGER triggertabRegBorrados
after delete on tabKardex for each row execute procedure movimientosAdmin();

-- Crear el trigger en la tabla tabproveedorArticulo
CREATE TRIGGER triggertabproveedorArticulo
BEFORE INSERT OR UPDATE ON tabproveedorArticulo
FOR EACH ROW
EXECUTE FUNCTION movimientosAdmin();

CREATE TRIGGER triggertabRegBorrados
after delete on tabproveedorArticulo for each row execute procedure movimientosAdmin();

-- Crear el trigger en la tabla tabEncabezadoVenta
CREATE TRIGGER triggertabEncabezadoVenta
BEFORE INSERT OR UPDATE ON tabEncabezadoVenta
FOR EACH ROW
EXECUTE FUNCTION movimientosAdmin();

CREATE TRIGGER triggertabRegBorrados
after delete on tabEncabezadoVenta for each row execute procedure movimientosAdmin();

-- Crear el trigger en la tabla tabDetalleVenta
CREATE TRIGGER triggertabDetalleVenta
BEFORE INSERT OR UPDATE ON tabDetalleVenta
FOR EACH ROW
EXECUTE FUNCTION movimientosAdmin();

CREATE TRIGGER triggertabRegBorrados
after delete on tabDetalleVenta for each row execute procedure movimientosAdmin();