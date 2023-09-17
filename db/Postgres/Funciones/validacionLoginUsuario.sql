CREATE OR REPLACE FUNCTION validacionLoginUsuario (
    zIdUsuario tabUsuario.idUsuario%type,
    zUsuario tabUsuario.Usuario%type,
    zPassword tabUsuario.password%type
) RETURNS BOOLEAN AS 
$$

DECLARE 
    zUsuarioValido BOOLEAN;

BEGIN
    SELECT --Consulta incompleta, @Yocser Cómo hago el SELECT? :)
    FROM tabUsuario 
    WHERE (usuario = zUsuario OR idUsuario = zIdUsuario) AND password = zPassword;
    INTO zUsuarioValido; 
    -- RAISE NOTICE '';

    IF zUsuarioValido THEN
        RAISE NOTICE 'Inicio de sesión exitoso %', zUsuario;
    ELSE
        RAISE NOTICE 'Credenciales de inicio de sesión incorrectas para %', zUsuario;
    END IF;

    RETURN usuario_valido;

END;
$$ LANGUAGE plpgsql;

-- @Yocser Hacer validación para que el idUsuario no se repita cuando se haga el insert en db/Postgres/Funciones/001-funcionInsertUsuario.sql

/*
SELECT COUNT(*) FROM tabUsuario
WHERE usuario = 'kraken' OR idUsuario = '1005330671' AND password = 'abcd1234';
*/

/* correccion de chatgpt
CREATE OR REPLACE FUNCTION validacionLoginUsuario (
    zIdUsuario tabUsuario.idUsuario%type,
    zUsuario tabUsuario.usuario%type,
    zPassword tabUsuario.password%type
) RETURNS BOOLEAN AS 
$$

DECLARE 
    zUsuarioValido BOOLEAN;

BEGIN
    zUsuarioValido := FALSE;

    SELECT TRUE
    INTO zUsuarioValido
    FROM tabUsuario 
    WHERE (usuario = zUsuario OR idUsuario = zIdUsuario) AND password = zPassword;

    IF zUsuarioValido THEN
        RAISE NOTICE 'Inicio de sesión exitoso para %', zUsuario;
    ELSE
        RAISE NOTICE 'Credenciales de inicio de sesión incorrectas para %', zUsuario;
    END IF;

    RETURN zUsuarioValido;

END;
$$ LANGUAGE plpgsql;
*/