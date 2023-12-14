/*función trigger para la validacion ID de clientes,proveedores y Usuarios */

CREATE OR REPLACE FUNCTION validacionId()
RETURNS TRIGGER AS
$$
DECLARE
    zId VARCHAR := '^[0-9]{1,10}$';
    zIdValue VARCHAR;
BEGIN
    IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
        CASE
            WHEN TG_RELID = 'tabcliente'::regclass THEN
                zIdValue := NEW.idCli;
            WHEN TG_RELID = 'tabproveedor'::regclass THEN
                zIdValue := NEW.idProv;
            WHEN TG_RELID = 'tabusuario'::regclass THEN
                zIdValue := NEW.idUsuario;
            ELSE
                RAISE EXCEPTION 'Error trigger';
        END CASE;

        IF zIdValue IS NOT NULL AND zIdValue !~ zId THEN
            RAISE EXCEPTION 'Porfavor ingresar solo números de hasta 10 digitos';
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER nitCliente
BEFORE INSERT ON tabCliente
FOR EACH ROW EXECUTE FUNCTION validacionId();

CREATE TRIGGER nitProveedor
BEFORE INSERT ON tabProveedor
FOR EACH ROW EXECUTE FUNCTION validacionId();

CREATE TRIGGER nitUsuario
BEFORE INSERT ON tabUsuario
FOR EACH ROW EXECUTE FUNCTION validacionId();