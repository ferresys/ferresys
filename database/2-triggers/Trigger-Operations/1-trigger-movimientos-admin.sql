/*cada movimiento que el usuario realice en la base de datos 
se vera reflejado en cada una de las tablas dependiendo de la 
tabla donde se realizó la inserción, actualización o eliminación*/

CREATE OR REPLACE FUNCTION movimientosUsuario()
RETURNS TRIGGER AS 

$$
BEGIN
	IF TG_OP='INSERT' THEN
    	NEW.fecInsert := now();
    	NEW.userInsert := current_user;
		RETURN NEW;
	END IF;
	
	IF TG_OP='UPDATE' THEN
		NEW.fecUpdate := now();
		NEW.userUpdate := current_user;
		RETURN NEW;
	END IF;
	
	IF TG_OP= 'DELETE' THEN
	  INSERT INTO tabRegBorrados (fecDelete,userDelete,nomTabla)
	  VALUES(current_timestamp,current_user,TG_RELNAME);--cambiar por usuario de la pagina
	
	  RETURN OLD;
	END IF ;
END;

$$ 
LANGUAGE plpgsql;

CREATE TRIGGER triggertabUsuario -- Crear el trigger en la tabla tabUsuario
BEFORE INSERT OR UPDATE ON tabUsuario
FOR EACH ROW
EXECUTE FUNCTION movimientosUsuario();

CREATE TRIGGER triggertabRegBorrados
AFTER DELETE ON tabUsuario FOR EACH ROW EXECUTE PROCEDURE movimientosUsuario();
--------------------------------------------------------------------------------------------------

CREATE TRIGGER triggertabPermiso -- Crear el trigger en la tabla tabPermiso
BEFORE INSERT OR UPDATE ON tabPermiso
FOR EACH ROW
EXECUTE FUNCTION movimientosUsuario();

CREATE TRIGGER triggertabRegBorrados
AFTER DELETE ON tabPermiso FOR EACH ROW EXECUTE PROCEDURE movimientosUsuario();
--------------------------------------------------------------------------------------------------

CREATE TRIGGER triggertabUsuarioPermiso -- Crear el trigger en la tabla tabUsuarioPermiso
BEFORE INSERT OR UPDATE ON tabUsuarioPermiso
FOR EACH ROW
EXECUTE FUNCTION movimientosUsuario();

CREATE TRIGGER triggertabRegBorrados
AFTER DELETE ON tabUsuarioPermiso FOR EACH ROW EXECUTE PROCEDURE movimientosUsuario();
--------------------------------------------------------------------------------------------------

CREATE TRIGGER triggertabCliente -- Crear el trigger en la tabla tabCliente
BEFORE INSERT OR UPDATE ON tabCliente
FOR EACH ROW
EXECUTE FUNCTION movimientosUsuario();

CREATE TRIGGER triggertabRegBorrados
AFTER DELETE ON tabCliente FOR EACH ROW EXECUTE PROCEDURE movimientosUsuario();
--------------------------------------------------------------------------------------------------

CREATE TRIGGER triggertabProveedor -- Crear el trigger en la tabla tabProveedor
BEFORE INSERT OR UPDATE ON tabProveedor
FOR EACH ROW
EXECUTE FUNCTION movimientosUsuario();

CREATE TRIGGER triggertabRegBorrados
AFTER DELETE ON tabProveedor FOR EACH ROW EXECUTE PROCEDURE movimientosUsuario();
--------------------------------------------------------------------------------------------------

CREATE TRIGGER triggertabCategoria -- Crear el trigger en la tabla tabCategoria
BEFORE INSERT OR UPDATE ON tabCategoria
FOR EACH ROW
EXECUTE FUNCTION movimientosUsuario();

CREATE TRIGGER triggertabRegBorrados
AFTER DELETE ON tabCategoria 
FOR EACH ROW EXECUTE PROCEDURE movimientosUsuario();
--------------------------------------------------------------------------------------------------

CREATE TRIGGER triggertabMarca -- Crear el trigger en la tabla tabMarca
BEFORE INSERT OR UPDATE ON tabMarca
FOR EACH ROW
EXECUTE FUNCTION movimientosUsuario();

CREATE TRIGGER triggertabRegBorrados
AFTER DELETE ON tabMarca 
FOR EACH ROW EXECUTE PROCEDURE movimientosUsuario();
--------------------------------------------------------------------------------------------------

CREATE TRIGGER triggertabArticulo -- Crear el trigger en la tabla tabArticulo
BEFORE INSERT OR UPDATE ON tabArticulo
FOR EACH ROW
EXECUTE FUNCTION movimientosUsuario();

CREATE TRIGGER triggertabRegBorrados
AFTER DELETE ON tabArticulo 
FOR EACH ROW EXECUTE PROCEDURE movimientosUsuario();
--------------------------------------------------------------------------------------------------

CREATE TRIGGER triggertabKardex -- Crear el trigger en la tabla tabKardex
BEFORE INSERT OR UPDATE ON tabKardex
FOR EACH ROW
EXECUTE FUNCTION movimientosUsuario();

CREATE TRIGGER triggertabRegBorrados
AFTER DELETE ON tabKardex 
FOR EACH ROW EXECUTE PROCEDURE movimientosUsuario();
--------------------------------------------------------------------------------------------------

CREATE TRIGGER triggertabReciboMercancia -- Crear el trigger en la tabla tabReciboMercancia
BEFORE INSERT OR UPDATE ON tabReciboMercancia
FOR EACH ROW
EXECUTE FUNCTION movimientosUsuario();

CREATE TRIGGER triggertabRegBorrados
AFTER DELETE ON tabReciboMercancia 
FOR EACH ROW EXECUTE PROCEDURE movimientosUsuario();
--------------------------------------------------------------------------------------------------

CREATE TRIGGER triggertabEncabezadoVenta -- Crear el trigger en la tabla tabEncabezadoVenta
BEFORE INSERT OR UPDATE ON tabEncabezadoVenta
FOR EACH ROW
EXECUTE FUNCTION movimientosUsuario();

CREATE TRIGGER triggertabRegBorrados
AFTER DELETE ON tabEncabezadoVenta 
FOR EACH ROW EXECUTE PROCEDURE movimientosUsuario();
--------------------------------------------------------------------------------------------------

CREATE TRIGGER triggertabDetalleVenta -- Crear el trigger en la tabla tabDetalleVenta
BEFORE INSERT OR UPDATE ON tabDetalleVenta
FOR EACH ROW
EXECUTE FUNCTION movimientosUsuario();

CREATE TRIGGER triggertabRegBorrados
AFTER DELETE ON tabDetalleVenta 
FOR EACH ROW EXECUTE PROCEDURE movimientosUsuario();