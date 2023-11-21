/*función trigger para validar el ID Proveedor, 
de tal manera que solo permita el ingreso de numeros y caacter (-) */

CREATE OR REPLACE FUNCTION validacionIdProveedor()
RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.idProv ~ '^[0-9]{8,10}$|^[0-9]{9,10}-[0-9]$' THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'El ID del proveedor debe contener solo valores numéricos y para el nit:  9-10 dígitos seguidos de un guión y la Division.';
    END IF;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER NitValidacionProveedor
BEFORE INSERT OR UPDATE ON tabProveedor
FOR EACH ROW
EXECUTE FUNCTION validacionIdProveedor();
