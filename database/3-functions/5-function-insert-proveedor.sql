
--select insertProveedor('1234569825', '4', 'MAKITA', '3225468794','makita@gmail.com','calle 45# 12-51');


-- Función para insertar datos en la tabla "tabProveedor"

CREATE OR REPLACE FUNCTION insertProveedor(
    zIdProv tabProveedor.idProv%type,
    zDivProv tabProveedor.divProv%type,
    zNomProv tabProveedor.nomProv%type,
    zTelProv tabProveedor.telProv%type,  
    zEmailProv tabProveedor.emailProv%type, 
    zDirProv tabProveedor.dirProv%type
) RETURNS void AS 

$$
DECLARE
    proveedorExistente BOOLEAN;

BEGIN
    -- Verificamos si ya existe un registro con el mismo idProv
    SELECT EXISTS (SELECT 1 FROM tabProveedor WHERE idProv = zIdProv) INTO proveedorExistente;

    IF proveedorExistente THEN
        RAISE EXCEPTION 'El proveedor ya esta registrado: %', zIdProv;

    ELSE
        -- Insertamos nuevo proveedor si no existe

        INSERT INTO tabProveedor(idProv, divProv, nomProv, telProv, emailProv, dirProv)
        VALUES (zIdProv, zDivProv, zNomProv, zTelProv, zEmailProv, zDirProv);

        RAISE NOTICE 'Proveedor registrado con éxito';
    END IF;
END;
$$ 
LANGUAGE plpgsql;





