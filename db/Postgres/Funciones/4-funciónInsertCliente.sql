
-- Función para insertar datos de un nuevo cliente  en la tabla "tabCliente"

--SELECT insertCliente('1095847854', TRUE, 'juan', 'Rojas', NULL, NULL, '3012545874', 'juan@gmail.com', 'avenida 45 # 54-30');
--SELECT insertCliente('100256542',FALSE , NULL, NULL, 'alumina S.A', 'manuel ardila', '3226854124', 'manuel@gmail.com', 'calle 51 # 24-30');
--SELECT insertCliente('123587498-1',False , NULL, NULL, 'marval', 'hlejandra lontoya', '1234567894', 'marval@gmail.com', 'calle 54 # 12-41');

--SELECT * FROM tabCliente;
--select idCli, tipoCli, nomCli, apeCli, nomRepLegal, nomEmpresa, telCli, emailCli, dirCli from tabCliente where idCli='1095847854';
/*SELECT idCli, tipoCli, CONCAT(nomCli, ' ', apeCli) AS nombreCompleto, nomRepLegal, nomEmpresa, telCli, emailCli, dirCli
FROM tabCliente
WHERE idCli = '1095847854';*/

CREATE OR REPLACE FUNCTION insertCliente(
    zIdCli tabCliente.idCli%type,
    zTipoCli tabCliente.tipoCli%type,
    zNomCli tabCliente.nomCli%type,
    zApeCli tabCliente.apeCli%type,
    zNomRepLegal tabCliente.nomRepLegal%type,
    zNomEmpresa tabCliente.nomEmpresa%type,
    zTelCli tabCliente.telCli%type,
    zEmailCli tabCliente.emailCli%type,
    zDirCli tabCliente.dirCli%type
) RETURNS VOID AS
$$
DECLARE
    clienteExistente BOOLEAN;

BEGIN
    -- Verificamos si ya existe un registro con el mismo idCli
    SELECT EXISTS (SELECT 1 FROM tabCliente WHERE idCli = zIdCli) INTO clienteExistente;

    IF clienteExistente THEN
        RAISE EXCEPTION 'Cliente ya esta registrado: %', zIdCli;

    ELSE

        -- Insertar nuevo cliente si no existe
        INSERT INTO tabCliente (idCli, tipoCli, nomCli, apeCli, nomRepLegal, nomEmpresa, telCli, emailCli, dirCli)
        VALUES (zIdCli, zTipoCli, zNomCli, zApeCli, zNomRepLegal, zNomEmpresa, zTelCli, zEmailCli, zDirCli);
		
        RAISE NOTICE 'Cliente registrado con éxito';
    END IF;
END;
$$ 
LANGUAGE plpgsql;
