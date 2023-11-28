CREATE OR REPLACE FUNCTION validaciontelProv()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.telProv ~ '^[0-9]{1,10}$' THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'El número de teléfono debe contener solo números de 10 digitos max';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validacionTelefonoProv
BEFORE INSERT OR UPDATE ON tabProveedor
FOR EACH ROW
EXECUTE FUNCTION validaciontelProv();

