--Función InsertUsuario

--Insertamos  el primer registro  con el rol "Administrador" (ID=0000001)

--funcion para insertar usuarios

CREATE OR REPLACE FUNCTION insertUsuario(
    zIdUsuario tabUsuario.idUsuario%type,
    zNomUsuario tabUsuario.NomUsuario%type,
    zApeUsuario tabUsuario.ApeUsuario%type,
    zEmailUsuario tabUsuario.emailUsuario%type,
    zUsuario tabUsuario.usuario%type,
    zPassword tabUsuario.password%type,
    zTelUsuario tabUsuario.telUsuario%type,
    zIdrol tabRol.idRol%type   
) RETURNS void AS 


$$
DECLARE

    zCodRol INTEGER;
    
BEGIN

SET zCodRol = (SELECT COUNT(*) FROM tabUsuario);--Nos permite contar el numero e registros que tiene la tabla.

IF zCodRol = 0 THEN

	INSERT INTO Usuarios (idUsuario, NomUsuario, ApeUsuario, emailUsuario, usuario, password, telUsuario, idRol)
    VALUES (1095821827, 'Jacob', 'Chavez', 'jacob@gmail.com', 'KRAKEN', '1234*', '3154876541', 0000001); -- 0000001 es el idRol "Administrador"
    
    RAISE NOTICE 'Registro exitoso ';

ELSE 

-- Si ya hay usuarios registrados, permitir al nuevo usuario elegir entre "Auxiliar" (idRol=0000002) o "Cliente" (idRol=0000003)
INSERT INTO Usuarios (idUsuario, NomUsuario, ApeUsuario, emailUsuario, usuario, password, telUsuario, idRol)
    VALUES (1001245874, 'David', 'Adarme', 'David@gmail.com', 'KRAKEN1', '123456*', '3014476845', 0000002); -- 0000002 es el idRol "Auxiliar"
    
    RAISE NOTICE 'Registro exitoso ';

END;
$$ 
LANGUAGE plpgsql;
