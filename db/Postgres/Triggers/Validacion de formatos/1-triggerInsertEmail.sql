CREATE OR REPLACE FUNCTION validarEmailGenerico()
RETURNS TRIGGER AS
$$
DECLARE
    emailRegex VARCHAR := '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$';
    emailValue VARCHAR;
BEGIN
    IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
        CASE
            WHEN TG_RELID = 'tabusuario'::regclass THEN
                emailValue := NEW.emailUsuario;
            WHEN TG_RELID = 'tabcliente'::regclass THEN
                emailValue := NEW.emailCli;
            WHEN TG_RELID = 'tabproveedor'::regclass THEN
                emailValue := NEW.emailProv;
            ELSE
                RAISE EXCEPTION 'Tabla no soportada por el trigger.';
        END CASE;

        IF emailValue IS NOT NULL AND emailValue !~ emailRegex THEN
            RAISE EXCEPTION 'El formato del correo electrónico no es válido para la tabla %.', TG_RELID::text;
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validarEmailUsuario
BEFORE INSERT ON tabUsuario
FOR EACH ROW EXECUTE FUNCTION validarEmailGenerico();

CREATE TRIGGER validarEmailCliente
BEFORE INSERT ON tabCliente
FOR EACH ROW EXECUTE FUNCTION validarEmailGenerico();

CREATE TRIGGER validarEmailProveedor
BEFORE INSERT ON tabProveedor
FOR EACH ROW EXECUTE FUNCTION validarEmailGenerico();

-- SELECT * FROM tabUsuario
-- SELECT insertUsuario('7005330671', 'Daniel', 'Bruce', 'ingespailas.com', 'Peto123', 'abcd1234');
-- SELECT insertUsuario('4005330671', 'Tim', 'David', 'micorreoreal+aliasparausoeninternet@gmail.com', 'Peto321', 'abcd1234');

-- SELECT * FROM tabCliente
-- SELECT insertCliente('1215673034', TRUE, 'juan', 'Rojas', NULL, NULL, '3012545874', 'juan@gmail.com', 'avenida 45 # 54-30');
-- SELECT insertCliente('12156730367', TRUE, 'juan', 'Rojas', NULL, NULL, '3012545874', 'juangmail.com', 'avenida 45 # 54-30');

-- SELECT * FROM tabProveedor
-- SELECT insertProveedor('0-15','DEWALT','3156478952','dewalt@gmail.com','calle 22 #1-14');
-- SELECT insertProveedor('0-11','DEWALT','3156478952','dewaltgmail.com','calle 22 #1-14');