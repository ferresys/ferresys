CREATE OR REPLACE FUNCTION validarEmail () 

RETURNS BOOLEAN AS
$$
DECLARE
    zEmailUsuario tabUsuario.emailUsuario%type;
    zEmailCli tabCliente.emailCli%type;
    zEmailProv tabProveedor.emailProv%type;
    zEmailValido BOOLEAN;

BEGIN
    SELECT TRUE 
	INTO zEmailValido 
	FROM tabUsuario, tabCliente, tabProveedor 
    WHERE zEmailUsuario = emailUsuario;
	
	SELECT TRUE 
	INTO zEmailValido 
	FROM tabCliente
    WHERE zEmailCli = emailCli;
	
    SELECT TRUE 
	INTO zEmailValido 
	FROM tabProveedor 
    WHERE zEmailProv = emailProv;

    CASE 
        WHEN NEW.emailUsuario = '' AND NEW.emailCli = '' AND NEW.emailProv = '' THEN
            RAISE EXCEPTION 'Debes proporcionar al menos un correo electrónico.';

        -- Verificar el formato del correo electrónico
        WHEN NEW.emailUsuario IS NOT NULL AND NEW.emailUsuario !~ '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$' THEN
            RAISE EXCEPTION 'El formato del correo electrónico de Usuario no es válido.';

        WHEN NEW.emailCli IS NOT NULL AND NEW.emailCli !~ '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$' THEN
            RAISE EXCEPTION 'El formato del correo electrónico de Cliente no es válido.';

        WHEN NEW.emailProv IS NOT NULL AND NEW.emailProv !~ '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$' THEN
            RAISE EXCEPTION 'El formato del correo electrónico de Proveedor no es válido.';
    END CASE;

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