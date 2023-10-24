CREATE OR REPLACE FUNCTION validarEmail() 
RETURNS TRIGGER AS
$$
DECLARE
    zEmailValido BOOLEAN;
BEGIN
    zEmailValido := TRUE;

    -- Verificar el formato del correo electrónico del Usuario
    IF NEW.emailUsuario !~ '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,63}$' THEN
        zEmailValido := FALSE;
    END IF;

    IF NOT zEmailValido THEN
        RAISE EXCEPTION 'El formato del correo electrónico no es válido.';
    END IF;

    -- Si el correo es válido, permitimos la inserción
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validarEmailUsuario
BEFORE INSERT ON tabUsuario
FOR EACH ROW EXECUTE FUNCTION validarEmail();

CREATE TRIGGER validarEmailCliente
BEFORE INSERT ON tabCliente
FOR EACH ROW EXECUTE FUNCTION validarEmail();

CREATE TRIGGER validarEmailProveedor
BEFORE INSERT ON tabProveedor
FOR EACH ROW EXECUTE FUNCTION validarEmail();