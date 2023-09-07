-- Función para insertar datos en la tabla "tabCliente"
-- pendiente de revision por logica

CREATE OR REPLACE FUNCTION insertCliente(
    zTipoCli BOOLEAN,
    zTelCli VARCHAR,
    zEmailCli VARCHAR,
    zDirCli VARCHAR,
    zCedulaCliNat INTEGER DEFAULT NULL,
    zNomCli VARCHAR DEFAULT NULL,
    zApeCli VARCHAR DEFAULT NULL,
    zNitCliJur VARCHAR DEFAULT NULL,
    zNomEmpr VARCHAR DEFAULT NULL
) RETURNS VOID AS

$$
DECLARE
    zFecReg TIMESTAMP = current_timestamp;
    zConsecCli UUID;

BEGIN
    INSERT INTO tabCliente (codCli, idCli, tipoCli, telCli, emailCli, dirCli, fecInsert, userInsert)
        VALUES (uuid_generate_v4(), '', TRUE, '3228695242', 'lagarto@gmail.com', 'Carrera 22', current_timestamp, current_user);
    RETURNING codCli INTO zConsecCli;

    RAISE NOTICE 'Registro exitoso';
END;
$$ 
LANGUAGE plpgsql;

-- Llamar a la función insertCliente
/*
SELECT insertCliente('Natural', '315264587', 'Marval@Constructora.com', 'Calle 41 # 55-38', 63294565, 'Gloria', 'Torres', NULL, NULL);
SELECT insertCliente('Juridico', '6785584', 'alumina.com', 'calle 64 #25-65',NULL,NULL,NULL, '0-123456', 'Alumina');
select * from tabCliente;
select * from tabClienteNatural;
select * from tabClienteJuridico;
UPDATE tabCliente
SET estado = 'INACTIVO'
WHERE consecCli = 3;
select a.idCli
*/

/*
--consultar cliente natural
SELECT 
	tcn.cedulaCliNat,tc.fecReg,tcn.nomCli, tcn.apeCli,tc.tipoCli,tc.telCli,tc.emailCli,tc.dirCli,
    tc.consecCli
FROM 
    tabCliente tc
LEFT JOIN 
    tabClienteNatural tcn ON tc.consecCli = tcn.consecCli
WHERE 
    tc.tipoCli = 'Natural';
*/
   
/*   
--consultar cliente juridico	
SELECT 
    tcj.nitCliJur, tc.fecReg, tcj.nomEmpr, tc.tipoCli, tc.telCli, tc.emailCli, tc.dirCli,
    tc.consecCli 
FROM 
    tabCliente tc
LEFT JOIN  
    tabClienteJuridico tcj ON tc.consecCli = tcj.consecCli
WHERE 
    tc.tipoCli = 'Juridico';
*/