-- DROP FUNCTION validacionloginusuario
CREATE OR REPLACE FUNCTION validacionLoginUsuario (
    zIdUsuario tabUsuario.idUsuario%type,
    zPassword tabUsuario.password%type
) RETURNS BOOLEAN AS
$$

DECLARE
    zUsuarioValido BOOLEAN;

BEGIN
    SELECT TRUE
    INTO zUsuarioValido
    FROM tabUsuario
    WHERE idUsuario = zIdUsuario AND password = zPassword;

    IF zUsuarioValido THEN
        RAISE NOTICE 'Inicio de sesión exitoso';
        RETURN TRUE;
		
    ELSE
        RAISE NOTICE 'Credenciales de inicio de sesión incorrectas';
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- @Yocser Hacer validación para que el idUsuario no se repita cuando se haga el insert en db/Postgres/Funciones/001-funcionInsertUsuario.sql

/*
SELECT validacionLoginUsuario('1095821827', 'abcd12340'); -- false
SELECT validacionLoginUsuario('1005330671', 'abcd1234'); -- true

SELECT * FROM tabUsuario;
SELECT COUNT(*) FROM tabUsuario
WHERE usuario = 'kraken' OR idUsuario = '1005330671' AND password = 'abcd1234';
*/