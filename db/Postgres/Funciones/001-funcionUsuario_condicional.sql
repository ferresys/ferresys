CREATE OR REPLACE FUNCTION verificarUsuario(zUsuario VARCHAR)
RETURNS BOOLEAN AS
$$
DECLARE
    usuario_existente BOOLEAN;
BEGIN
    SELECT EXISTS (SELECT 1 FROM tabUsuario WHERE usuario = zUsuario) INTO usuario_existente;
    RETURN usuario_existente;
END;
$$
LANGUAGE plpgsql;

IF NOT verificarUsuario('nuevo_usuario') THEN -- no existe, puede insertar usuario
    INSERT INTO tabUsuario (codUsuario, idUsuario, nomUsuario, ApeUsuario, emailUsuario, usuario)
    VALUES (uuid_generate_v4(), '1005330672', 'David', 'Calamardo', 'correo@lechuza.com', 'pichi', 'larocabr#2123');
    RAISE NOTICE 'El usuario se registro existosamente';
ELSE
    RAISE EXCEPTION 'El usuario ya esta registrado'; --usuario existente
END IF;
