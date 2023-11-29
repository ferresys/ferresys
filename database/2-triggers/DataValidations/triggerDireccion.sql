CREATE OR REPLACE FUNCTION validacionDireccion()
RETURNS TRIGGER AS 
$$
DECLARE
    direccionRegex VARCHAR := '^(calle|avenida|cra|peatonal) [0-9]{1,3} # [0-9]{1,3}-[0-9]{1,3}(\s(piso [0-9]{1,3} apto [0-9]{1,3}|casa [0-9]{1,3}|manz\. [0-9]{1,3})|)$';
    direccionValue VARCHAR;
BEGIN
    IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
        CASE 
            WHEN TG_RELID = 'tabproveedor'::regclass THEN
                direccionValue := NEW.dirProv;
            WHEN TG_RELID = 'tabcliente'::regclass THEN
                direccionValue := NEW.dirCli;
            ELSE
            RAISE EXCEPTION 'La dirección debe tener la estructura correcta, sino pailas mi perro';
        END CASE;
        
        IF direccionValue IS NOT NULL AND direccionValue !~ direccionRegex THEN
            RAISE EXCEPTION 'Dirección inválida %.', TG_RELID::text;
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER dirProv
BEFORE INSERT OR UPDATE ON tabProveedor
FOR EACH ROW
EXECUTE FUNCTION validacionDireccion();

CREATE TRIGGER dirCliente
BEFORE INSERT OR UPDATE ON tabCliente
FOR EACH ROW
EXECUTE FUNCTION validacionDireccion();

-- SELECT * FROM tabCliente
-- SELECT insertCliente('77777777', TRUE, 'juan', 'Rojas', NULL, NULL, '3012545874', 'juan@gmail.com', 'calle 22 # 1-14');
-- SELECT insertCliente('666677777', TRUE, 'juan', 'Rojas', NULL, NULL, '3012545874', 'juan@gmail.com', 'avenida 22 # 1-14');

-- SELECT * FROM tabProveedor
-- SELECT insertProveedor('0-40','DEWALT','3156478952','dewalt@gmail.com','calle 22 # 1-14');
-- SELECT insertProveedor('0-41','DEWALT','3156478952','dewalt@gmail.com','calle 22 # 1-14');

-- calle 123 # 456-789
-- avenida 12 # 34-56 piso 7 apto 89
-- cra 1 # 2-3 casa 4
-- peatonal 100 # 200-300 manz. 400