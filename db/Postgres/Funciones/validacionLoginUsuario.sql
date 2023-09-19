CREATE OR REPLACE FUNCTION validacionLoginUsuario (
    zUsuario tabUsuario.usuario%type,
    zPassword tabUsuario.password%type
) RETURNS BOOLEAN AS
$$

DECLARE
    zUsuarioValido BOOLEAN;

BEGIN
    SELECT idUsuario, password
        FROM tabUsuario
        WHERE idUsuario = zIdUsuario AND password = zPassword;
    INTO zUsuarioValido;

    IF zUsuarioValido THEN
        RAISE NOTICE 'Inicio de sesión exitoso';
    ELSE
        RAISE NOTICE 'Credenciales de inicio de sesión incorrectas';
    END IF;

    RETURN zUsuarioValido;

END;
$$ LANGUAGE plpgsql;

-- @Yocser Hacer validación para que el idUsuario no se repita cuando se haga el insert en db/Postgres/Funciones/001-funcionInsertUsuario.sql

/*
SELECT COUNT(*) FROM tabUsuario
WHERE usuario = 'kraken' OR idUsuario = '1005330671' AND password = 'abcd1234';

    SELECT EXISTS (
        SELECT 1
        FROM tabUsuario 
        WHERE usuario = zUsuario AND password = zPassword
    ) INTO zUsuarioValido; 
*/