-- Función para insertar datos en la tabla "tabCliente"
-- pendiente de revision por logica

CREATE OR REPLACE FUNCTION insertCliente(
    zIdCli tabCliente.idCli%type,
    zTipoCli tabCliente.tipoCli%type,
    zTelCli tabCliente.telCli%type,
    zEmailCli tabCliente.emailCli%type,
    zDirCli tabCliente.dirCli%type,
    zNomCli tabCliente.nomCli%type,
    zApeCli tabCliente.apeCli%type,
    zNomEmpr tabCliente.nomEmpr%type

) RETURNS VOID AS

$$
DECLARE
    zFecReg TIMESTAMP = current_timestamp;
    zConsecCli UUID;

BEGIN
    INSERT INTO tabCliente (idCli, tipoCli, telCli, emailCli, dirCli, userInsert)
        VALUES ('', TRUE, '3228695242', 'lagarto@gmail.com', 'Carrera 22', current_timestamp, current_user);
    RETURNING codCli INTO zConsecCli;

    RAISE NOTICE 'Registro exitoso';
END;
$$ 
LANGUAGE plpgsql;