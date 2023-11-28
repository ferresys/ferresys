CREATE OR REPLACE FUNCTION validacionDireccion()
RETURNS TRIGGER AS
$$
-- DECLARE
--     addressRegex VARCHAR := '^(calle|avenida|cra|peatonal) [0-9]{1,3} # [0-9]{1,3}-[0-9]{1,3}(\s(piso [0-9]{1,3} apto [0-9]{1,3}|casa [0-9]{1,3}|manz\. [0-9]{1,3})|)$';
-- BEGIN
--     RAISE NOTICE 'Direccion del Proveedor: %', NEW.dirProv;
--     RAISE NOTICE 'Expresion Regular: %', addressRegex;

--     IF TG_TABLE_NAME = 'tabProveedor' THEN
--         IF NEW.dirProv !~ addressRegex THEN
--             RAISE EXCEPTION 'La dirección debe tener la estructura correcta';
--         END IF;
--     ELSIF TG_TABLE_NAME = 'tabCliente' THEN
--         RAISE NOTICE 'Direccion del Cliente: %', NEW.dirCli;
--         RAISE NOTICE 'Expresion Regular: %', addressRegex;

--         IF NEW.dirCli !~ addressRegex THEN
--             RAISE EXCEPTION 'La dirección debe tener la estructura correcta';
--         END IF;
--     END IF;

--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;

CREATE TRIGGER dirProv
BEFORE INSERT OR UPDATE ON tabProveedor
FOR EACH ROW
EXECUTE FUNCTION validacionDireccion();

CREATE TRIGGER dirCliente
BEFORE INSERT OR UPDATE ON tabCliente
FOR EACH ROW
EXECUTE FUNCTION validacionDireccion();