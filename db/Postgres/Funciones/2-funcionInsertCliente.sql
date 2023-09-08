-- Función para insertar datos en la tabla "tabCliente"
-- pendiente de revision por logica

CREATE OR REPLACE FUNCTION insertCliente(
    zIdCli tabCliente.idCli%type,
    zTipoCli tabCliente.tipoCli%type,
    zNomCli tabCliente.nomCli%type,
    zApeCli tabCliente.apeCli%type,
    zNomEmpr tabCliente.nomRepLegal%type,
    zNomRepLegal tabCliente.nomEmpresa%type,
    zTelCli tabCliente.telCli%type,
    zEmailCli tabCliente.emailCli%type,
    zDirCli tabCliente.dirCli%type

) RETURNS VOID AS

$$
DECLARE
    zFecReg TIMESTAMP = current_timestamp;
    zConsecCli UUID;

BEGIN
    INSERT INTO tabCliente (idCli, tipoCli, nomCli, apeCli, nomEmpresa, nomRepLegal, telCli, emailCli, dirCli)
        VALUES (zIdCli, zTipoCli, zNomCli, zNomEmpr, zNomRepLegal, zTelCli, zEmailCli, zDirCli);
    RETURNING codCli INTO zConsecCli;

    RAISE NOTICE 'Registro exitoso';
END;
$$ 
LANGUAGE plpgsql;