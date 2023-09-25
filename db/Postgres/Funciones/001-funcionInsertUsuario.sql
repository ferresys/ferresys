
--funcion para insertar usuarios y validar si ya existen.


-- SELECT insertUsuario('1005330671', 'Chato', 'Adarme', 'inges@pailas.com', 'kraken', 'abcd1234');
-- SELECT insertUsuario ('1095821827', 'Jacob', 'Chavez', 'jacob@gmail.com', 'kraken', 'abcd1234');
--select * from tabUsuario;
CREATE OR REPLACE FUNCTION insertUsuario(
    zIdUsuario tabUsuario.idUsuario%type,
    zNomUsuario tabUsuario.nomUsuario%type,
    zApeUsuario tabUsuario.apeUsuario%type,
    zEmailUsuario tabUsuario.emailUsuario%type,
    zUsuario tabUsuario.usuario%type,
    zPassword tabUsuario.password%type
) RETURNS void AS 
$$

DECLARE
    usuarioExistente BOOLEAN;

BEGIN
    -- Verificamos si el usuario ya existe en la db.

    SELECT EXISTS (SELECT 1 FROM tabUsuario WHERE usuario = zUsuario) INTO usuarioExistente;

    IF usuarioExistente THEN
        RAISE EXCEPTION 'Usuario ya existe: %', zUsuario;

    ELSE
        -- Insertamos  nuevo usuario si no existe en la db.

        INSERT INTO tabUsuario (idUsuario, nomUsuario, apeUsuario, emailUsuario, usuario, password)
        VALUES (zIdUsuario, zNomUsuario, zApeUsuario, zEmailUsuario, zUsuario, zPassword);
        RAISE NOTICE 'Se hizo el registro correctamente';
    END IF;
END;
$$ 
LANGUAGE plpgsql;
