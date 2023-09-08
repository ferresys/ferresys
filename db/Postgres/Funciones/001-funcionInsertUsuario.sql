--funcion para insertar usuarios
-- SELECT insertUsuario('1005330671', 'Chato', 'Adarme', 'inges@pailas.com');
-- SELECT insertUsuario (1095821827, 'Jacob', 'Chavez', 'jacob@gmail.com');

CREATE OR REPLACE FUNCTION insertUsuario(
    zIdUsuario tabUsuario.idUsuario%type,
    zNomUsuario tabUsuario.NomUsuario%type,
    zApeUsuario tabUsuario.ApeUsuario%type,
    zEmailUsuario tabUsuario.emailUsuario%type,
    zUsuario tabUsuario.usuario%type,
    zPassword tabUsuario.password %type
) RETURNS void AS 

$$
BEGIN
    INSERT INTO tabUsuario (idUsuario, nomUsuario, apeUsuario, emailUsuario, usuario, password)
    VALUES (zIdUsuario, zNomUsuario, zApeUsuario, zEmailUsuario, zUsuario, zPassword);
    RAISE NOTICE 'Se hizo el registro correctamente';
END;
$$ 
LANGUAGE plpgsql;