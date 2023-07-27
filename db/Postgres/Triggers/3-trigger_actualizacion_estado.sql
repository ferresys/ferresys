-- funcion trigger para actualizar el estado

CREATE OR REPLACE FUNCTION actualizar_estado()
RETURNS TRIGGER AS 

$$
BEGIN
    IF NEW.estado = 'inactivo' THEN
        NEW.estado := 'inactivo';
    END IF;
	
RETURN NEW;
END;
$$ 
LANGUAGE plpgsql;

-- Crear el trigger en la tabla tab_usuario
CREATE TRIGGER trigger_actualizar_estado_tab_usuario
BEFORE UPDATE ON tab_usuario
FOR EACH ROW
EXECUTE FUNCTION actualizar_estado();

/*en este caso cuando el usuario seleccione la opcion de 
cambiar el estado activo a inactivo, entonces este trigger se activa y actualiza la
tabla en la base de datos dependiendo del registro que seleccione el usuario.
para eso hay que incluir una condicional seguida de :

importatante= esta funcion la debo llamar desde el servidor 
app.js de nodejs, para q actualice el estado en la base de datos.
UPDATE tab_usuario
SET estado = 'INACTIVO'
WHERE consec_usu = 3; */

-- Crear el trigger en la tabla tab_proveedor
CREATE TRIGGER trigger_actualizar_estado_tab_proveedor
BEFORE UPDATE ON tab_proveedor
FOR EACH ROW
EXECUTE FUNCTION actualizar_estado();

-- Crear el trigger en la tabla tab_categoria
CREATE TRIGGER trigger_actualizar_estado_tab_categoria
BEFORE UPDATE ON tab_categoria
FOR EACH ROW
EXECUTE FUNCTION actualizar_estado();

-- Crear el trigger en la tabla tab_marca
CREATE TRIGGER trigger_actualizar_estado_tab_marca
BEFORE UPDATE ON tab_marca
FOR EACH ROW
EXECUTE FUNCTION actualizar_estado();

-- Crear el trigger en la tabla tab_articulo
CREATE TRIGGER trigger_actualizar_estado_tab_articulo
BEFORE UPDATE ON tab_articulo
FOR EACH ROW
EXECUTE FUNCTION actualizar_estado();

-- Crear el trigger en la tabla tab_encabezado_venta
CREATE TRIGGER trigger_actualizar_estado_tab_encabezado_venta
BEFORE UPDATE ON tab_encabezado_venta
FOR EACH ROW
EXECUTE FUNCTION actualizar_estado();

-- Crear el trigger en la tabla tab_detalle_venta
CREATE TRIGGER trigger_actualizar_estado_tab_detalle_venta
BEFORE UPDATE ON tab_detalle_venta
FOR EACH ROW
EXECUTE FUNCTION actualizar_estado();


