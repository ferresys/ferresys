
--funcion para insertar usuarios y validar si ya existen.

-- SELECT insertUsuario('123456', 'Alejandra', 'aleja@gmail.com', 'abcd1234', null, null, null);
-- SELECT insertUsuario ('1095821825', 'Jacob', 'Chavez', 'jacob@gmail.com', 'juan', 'abcd1234');

--select * from usuarios;

CREATE OR REPLACE FUNCTION insertUsuario(
    zId usuarios.id%type,
    zNombre usuarios.nombre%type,
    zCorreo usuarios.correo%type,
    zContrasena usuarios.contrasena%type,
    zConfirmationcode usuarios.confirmationcode%type,
	zConfirmed usuarios.confirmed%type,
	resetPasswordToken usuarios.resetPasswordToken%type
) RETURNS void AS 
$$

DECLARE
    usuarioExistente BOOLEAN;

BEGIN
    -- Verificamos si el usuario ya existe en la db.

    --SELECT EXISTS (SELECT 1 FROM usuarios WHERE usuario = zUsuario) INTO usuarioExistente;
    SELECT EXISTS (SELECT 1 FROM usuarios WHERE  id = zId) INTO usuarioExistente;

    IF usuarioExistente THEN
        RAISE EXCEPTION 'Usuario ya existe: %',zId;

    ELSE
        -- Insertamos  nuevo usuario si no existe en la db.

        INSERT INTO usuarios (id, nombre, correo, contrasena, confirmationcode, confirmed, resetPasswordToken)
        VALUES (zId, zNombre, zCorreo, zContrasena, zConfirmationcode, zConfirmed, resetPasswordToken);
        RAISE NOTICE 'Registro Exitoso';
    END IF;
END;
$$ 
LANGUAGE plpgsql;
