/*función trigger para validar el ID Usuario, 
de tal manera que solo permita el ingreso de numeros */

CREATE OR REPLACE FUNCTION validacionIdUsuario()
RETURNS TRIGGER AS
$$
BEGIN
    
    IF NEW.idUsuario ~ '^[0-9]{1,10}$' THEN
            RETURN NEW;
        ELSE
            RAISE EXCEPTION 'EL ID debe contener formato numerico de hasta 10 digitos';
        END IF;
   
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER NitValidacionUsuario
BEFORE INSERT OR UPDATE ON tabUsuario
FOR EACH ROW
EXECUTE FUNCTION validacionIdUsuario();