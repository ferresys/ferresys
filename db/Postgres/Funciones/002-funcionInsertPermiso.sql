
--Creamos la funcion insertPermiso para insertar los permisos a los que tendran acceso los usuarios.

--SELECT insertPermiso('MODULO CLIENTES', 'Acceso a todos los registros del modulo clientes');
--select * from tabPermiso;
CREATE OR REPLACE FUNCTION insertPermiso(
    zNomPermiso tabUsuario.idUsuario%type,
    zDescPermiso tabUsuario.nomUsuario%type
) RETURNS void AS 
$$
DECLARE
    permisoExistente BOOLEAN;
BEGIN
    -- Verificamos si ya existe un registro con el mismo nomPermiso
    SELECT EXISTS (SELECT 1 FROM tabPermiso WHERE nomPermiso = zNomPermiso) INTO permisoExistente;

    IF permisoExistente THEN
        RAISE EXCEPTION 'Ya existe un permiso con el mismo nombre: %', zNomPermiso;

    ELSE

        -- Insertamos nuevo permiso si no existe
        INSERT INTO tabPermiso (nomPermiso, descPermiso)
        VALUES (zNomPermiso, zDescPermiso);

        RAISE NOTICE 'permiso registrado con éxito';
    END IF;
END;
$$ 
LANGUAGE plpgsql;
