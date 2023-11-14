/*función trigger para validar el ID cliente, 
de tal manera que solo permita el ingreso de numeros y caacter (-) */

CREATE OR REPLACE FUNCTION validacionIdCliente()
RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.tipoCli = false THEN
        IF NEW.idCli ~ '^[0-9]{0,10}-[0-9]$' THEN
            RETURN NEW;
        ELSE
            RAISE EXCEPTION 'Si tipoCli es false(Juridico), idCli debe tener hasta 10 dígitos (opcional), seguido por "-" y un dígito';
        END IF;
    ELSIF NEW.tipoCli = true THEN
        IF NEW.idCli ~ '^[0-9]{1,10}$' THEN
            RETURN NEW;
        ELSE
            RAISE EXCEPTION 'Si tipoCli es true (Natural, idCli debe contener hasta 10 dígitos numéricos';
        END IF;
    ELSE
        RAISE EXCEPTION 'El campo tipoCli debe ser true o false';
    END IF;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER NitValidacion
BEFORE INSERT OR UPDATE ON tabCliente
FOR EACH ROW
EXECUTE FUNCTION validacionIdCliente();

