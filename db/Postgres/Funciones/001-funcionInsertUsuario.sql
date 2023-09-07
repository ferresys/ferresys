--funcion para insertar usuarios
-- SELECT insertUsuario('1005330671', 'Chato', 'Adarme', 'inges@pailas.com');

SET zIdUsuario = (SELECT COUNT(*) FROM tabUsuario);--Nos permite contar el numero e registros que tiene la tabla.

CREATE OR REPLACE FUNCTION insertUsuario(
    zIdUsuario tabUsuario.idUsuario%type,
    zNomUsuario tabUsuario.NomUsuario%type,
    zApeUsuario tabUsuario.ApeUsuario%type,
    zEmailUsuario tabUsuario.emailUsuario%type
) RETURNS void AS 

$$
BEGIN
    INSERT INTO tabUsuario (idUsuario, nomUsuario, apeUsuario, emailUsuario)
    VALUES (1095821827, 'Jacob', 'Chavez', 'jacob@gmail.com');
    RAISE NOTICE 'Se hizo el registro correctamente';

END;
$$ 
LANGUAGE plpgsql;