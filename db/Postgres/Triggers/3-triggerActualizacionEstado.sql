-- funcion trigger para actualizar el estado

CREATE OR REPLACE FUNCTION actualizarEstado()
RETURNS TRIGGER AS 

$$
BEGIN
    IF NEW.estado = FALSE THEN
        NEW.estado := FALSE;
    END IF;
	
RETURN NEW;
END;
$$ 
LANGUAGE plpgsql;


/*en este caso cuando el usuario seleccione la opcion de 
cambiar el estado activo a inactivo, entonces este trigger se activa y actualiza la
tabla en la base de datos dependiendo del registro que seleccione el usuario.
para eso hay que incluir una condicional seguida de :

importatante= esta funcion la debo llamar desde el servidor 
app.js de nodejs, para q actualice el estado en la base de datos.
UPDATE tabUsuario
SET estado = FALSE
WHERE idProveedor = '1095821827'; */

-- Crear el trigger en la tabla tabProveedor
CREATE TRIGGER triggerActualizarEstadotabProveedor
BEFORE UPDATE ON tabProveedor
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




