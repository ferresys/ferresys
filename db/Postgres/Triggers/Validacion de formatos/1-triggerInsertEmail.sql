CREATE OR REPLACE FUNCTION validarEmailUsuarioTrigger()
RETURNS TRIGGER AS
$$
DECLARE
    zEmailValido BOOLEAN;
	
BEGIN
    zEmailValido := TRUE;

    IF NEW.emailUsuario !~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$' THEN
        zEmailValido := FALSE;
    END IF;

    IF NOT zEmailValido THEN
        RAISE EXCEPTION 'El formato del correo electrónico no es válido.';
    END IF;
	
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION validarEmailClienteTrigger()
RETURNS TRIGGER AS
$$
DECLARE
    zEmailValido BOOLEAN;
	
BEGIN
    zEmailValido := TRUE;

	IF NEW.emailCli !~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$' THEN
    	zEmailValido := FALSE;
    END IF;

    IF NOT zEmailValido THEN
        RAISE EXCEPTION 'El formato del correo electrónico no es válido.';
    END IF;
	
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION validarEmailProveedorTrigger()
RETURNS TRIGGER AS
$$
DECLARE
    zEmailValido BOOLEAN;
	
BEGIN
    zEmailValido := TRUE;

    IF NEW.emailProv !~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$' THEN
        zEmailValido := FALSE;
    END IF;

    IF NOT zEmailValido THEN
        RAISE EXCEPTION 'El formato del correo electrónico no es válido.';
    END IF;
	
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validarEmailUsuario
BEFORE INSERT ON tabUsuario
FOR EACH ROW EXECUTE FUNCTION validarEmailUsuarioTrigger();

CREATE TRIGGER validarEmailCliente
BEFORE INSERT ON tabCliente
FOR EACH ROW EXECUTE FUNCTION validarEmailClienteTrigger();

CREATE TRIGGER validarEmailProveedor
BEFORE INSERT ON tabProveedor
FOR EACH ROW EXECUTE FUNCTION validarEmailProveedorTrigger();

-- SELECT * FROM tabUsuario
-- SELECT insertUsuario('7005330671', 'Bonita', 'loco', 'ingespailas.com', 'Peto123', 'abcd1234');
-- SELECT insertUsuario('4005330671', 'Sr', 'Nigga', 'micorreoreal+aliasparausoeninternet@gmail.com', 'Peto321', 'abcd1234');

-- SELECT * FROM tabCliente
-- SELECT insertCliente('1215673034', TRUE, 'juan', 'Rojas', NULL, NULL, '3012545874', 'juan@gmail.com', 'avenida 45 # 54-30');
-- SELECT insertCliente('12156730367', TRUE, 'juan', 'Rojas', NULL, NULL, '3012545874', 'juangmail.com', 'avenida 45 # 54-30');

-- SELECT * FROM tabProveedor
-- SELECT insertProveedor('0-15','DEWALT','3156478952','dewalt@gmail.com','calle 22 #1-14');
-- SELECT insertProveedor('0-11','DEWALT','3156478952','dewaltgmail.com','calle 22 #1-14');