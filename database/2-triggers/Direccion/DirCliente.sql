CREATE OR REPLACE FUNCTION validacionDireccion()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.dirCli ~ '^(calle|avenida|cra|peatonal) [0-9]{1,3} # [0-9]{1,3}-[0-9]{1,3}(\s(piso [0-9]{1,3} apto [0-9]{1,3}|casa [0-9]{1,3}|manz\. [0-9]{1,3})|)$' THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'La dirección debe tener la estructura correcta: (calle|avenida|cra|peatonal) N#N-N (opcional: piso N apto N, casa N, manz. N)';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER dirCliente
BEFORE INSERT OR UPDATE ON tabCliente
FOR EACH ROW
EXECUTE FUNCTION validacionDireccion();

