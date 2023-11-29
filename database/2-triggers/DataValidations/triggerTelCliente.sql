/*CREATE OR REPLACE FUNCTION validaciontelCli()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.telCli ~ '^[0-9]{1,10}$' THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'El número de teléfono debe contener solo números de 10 digitos max';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validacionTelefono
BEFORE INSERT OR UPDATE ON tabCliente
FOR EACH ROW
EXECUTE FUNCTION validaciontelCli();*/
