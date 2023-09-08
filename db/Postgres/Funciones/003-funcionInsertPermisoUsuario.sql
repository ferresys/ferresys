
--creamos la funcion asignarPermisoUsuario, para asignar los permisos que tendra cada usuario y asi poder acceder a los modulos del sistema.

--SELECT asignarPermisoUsuario('1005330671', 1);

CREATE OR REPLACE FUNCTION asignarPermisoUsuario(
    zIdUsuario tabUsuario.idUsuario%type,
    zConsecPermiso tabPermiso.consecPermiso%type
) RETURNS void AS 

$$
BEGIN

    -- Verificamos si el usuario y el permiso ya  existen en la db.
    IF NOT EXISTS (SELECT 1 FROM tabUsuario WHERE idUsuario = zIdUsuario) THEN

        RAISE EXCEPTION 'Usuario no existe: %', zIdUsuario;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM tabPermiso WHERE consecPermiso = zConsecPermiso) THEN
        RAISE EXCEPTION 'No existe un permiso: %', zConsecPermiso;
    END IF;


    -- Insertamos el registro en tabUsuarioPermiso
    INSERT INTO tabUsuarioPermiso (idUsuario, consecPermiso)
    VALUES (zIdUsuario, zConsecPermiso);

    RAISE NOTICE 'Permiso asignado con éxito';
END;
$$ 
LANGUAGE plpgsql;
