
/*creamos la función asignarPermisoUsuario, para asignar los permisos
que tendra cada usuario y asi poder acceder a los modulos del sistema.*/

--SELECT asignarPermisoUsuario('1005330671', '1');
--SELECT asignarPermisoUsuario('1005330671', '2');
--SELECT asignarPermisoUsuario('1095821827', '1');
--SELECT asignarPermisoUsuario('1095821827', '2');

--select * from tabUsuarioPermiso;
--select * from tabPermiso;
--select * from tabUsuario;
--delete from tabUsuarioPermiso;

--select idUsuario, ConsecPermiso from tabUsuarioPermiso where idUsuario='1095821827';

--utilizamos el JOIN para realizar consultas desde diferentes tablas.
/*SELECT up.idUsuario, up.ConsecPermiso, tp.nomPermiso, tp.descPermiso
FROM tabUsuarioPermiso up
JOIN tabPermiso tp ON up.consecPermiso = tp.consecPermiso
WHERE up.idUsuario = '1095821827';*/

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
	
	IF EXISTS (SELECT idUsuario FROM tabUsuarioPermiso WHERE idUsuario=zIdUsuario and consecPermiso <> zConsecPermiso) THEN
	  --se continua con la insercion del nuevo permiso para el mismo usuario.
	END IF;
	
	IF EXISTS (SELECT idUsuario FROM tabUsuarioPermiso WHERE idUsuario=zIdUsuario and consecPermiso = zConsecPermiso) THEN
	   RAISE EXCEPTION 'Usuario ya tiene permisos asignados: %', zConsecPermiso;
	END IF;
	
	-- Insertamos el registro en tabUsuarioPermiso
    INSERT INTO tabUsuarioPermiso (idUsuario, consecPermiso)
    VALUES (zIdUsuario, zConsecPermiso);

    RAISE NOTICE 'Permiso asignado con éxito';
	
	
END;
$$ 
LANGUAGE plpgsql;
