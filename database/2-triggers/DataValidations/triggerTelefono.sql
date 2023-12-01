/*función trigger para la validacion telefono de clientes y proveedores*/
CREATE OR REPLACE FUNCTION validacionTel()
RETURNS TRIGGER AS
$$
DECLARE
    zTel VARCHAR := '^[0-9]{1,10}$';
    zTelValue VARCHAR;
BEGIN
    IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
        CASE
            WHEN TG_RELID = 'tabcliente'::regclass THEN
                zTelValue := NEW.telCli;
            WHEN TG_RELID = 'tabproveedor'::regclass THEN
                zTelValue := NEW.telProv;
            
            ELSE
                RAISE EXCEPTION 'Error trigger';
        END CASE;

        IF zTelValue IS NOT NULL AND zTelValue !~ zTel THEN
            RAISE EXCEPTION 'Porfavor ingresar solo números de hasta 10 digitos para el número de teléfono';
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER telCliente
BEFORE INSERT ON tabCliente
FOR EACH ROW EXECUTE FUNCTION validacionTel();

CREATE TRIGGER telProveedor
BEFORE INSERT ON tabProveedor
FOR EACH ROW EXECUTE FUNCTION validacionTel();

