-- funcion trigger para actualizar el estado

CREATE OR REPLACE FUNCTION actualizarEstado()
RETURNS TRIGGER AS 

$$
BEGIN
    IF NEW.estado = 'INACTIVO' THEN
        NEW.estado := 'INACTIVO';
    END IF;
	
RETURN NEW;
END;
$$ 
LANGUAGE plpgsql;

-- Crear el trigger en la tabla tabAdministrador
CREATE TRIGGER triggerActualizarEstadotabAdministrador
BEFORE UPDATE ON tabAdministrador
FOR EACH ROW
EXECUTE FUNCTION actualizarEstado();

/*en este caso cuando el usuario seleccione la opcion de 
cambiar el estado activo a inactivo, entonces este trigger se activa y actualiza la
tabla en la base de datos dependiendo del registro que seleccione el usuario.
para eso hay que incluir una condicional seguida de :

importatante= esta funcion la debo llamar desde el servidor 
app.js de nodejs, para q actualice el estado en la base de datos.
UPDATE tab_usuario
SET estado = 'INACTIVO'
WHERE idAdmin = 3; */

-- Crear el trigger en la tabla tabProveedor
CREATE TRIGGER triggerActualizarEstadotabProveedor
BEFORE UPDATE ON tabProveedor
FOR EACH ROW
EXECUTE FUNCTION actualizarEstado();

-- Crear el trigger en la tabla tabCategoria
CREATE TRIGGER triggerActualizarEstadotabCategoria
BEFORE UPDATE ON tabCategoria
FOR EACH ROW
EXECUTE FUNCTION actualizarEstado();

-- Crear el trigger en la tabla tabMarca
CREATE TRIGGER triggerActualizarEstadotabMarca
BEFORE UPDATE ON tabMarca
FOR EACH ROW
EXECUTE FUNCTION actualizarEstado();

-- Crear el trigger en la tabla tabArticulo
CREATE TRIGGER triggerActualizarEstadotabArticulo
BEFORE UPDATE ON tabArticulo
FOR EACH ROW
EXECUTE FUNCTION actualizarEstado();

-- Crear el trigger en la tabla tabEncabezadoVenta
CREATE TRIGGER triggerActualizarEstadotabEncabezadoVenta
BEFORE UPDATE ON tabEncabezadoVenta
FOR EACH ROW
EXECUTE FUNCTION actualizarEstado();

-- Crear el trigger en la tabla tabDetalleVenta
CREATE TRIGGER triggerActualizarEstadotabDetalleVenta
BEFORE UPDATE ON tabDetalleVenta
FOR EACH ROW
EXECUTE FUNCTION actualizarEstado();


