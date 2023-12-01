
-- Función para insertar datos en la tabla "tabProveedor"

--select insertProveedor('1234569825-4','DEWALT','holsa','dewalt@gmail.com','calle 22 # 1-14');
--select insertProveedor('103658977-1','MAKITA','3225468794','makita@gmail.com','calle 45 ');
--select * from tabProveedor;

CREATE OR REPLACE FUNCTION insertProveedor(
    zIdProv tabProveedor.idProv%type,
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

        INSERT INTO tabProveedor(idProv, nomProv, telProv, emailProv, dirProv)
        VALUES (zIdProv, zNomProv, zTelProv, zEmailProv, zDirProv);

        RAISE NOTICE 'Proveedor registrado con éxito';
    END IF;
END;
$$ 
LANGUAGE plpgsql;





