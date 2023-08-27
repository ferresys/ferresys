-- Función para insertar datos en la tabla "tabCliente"

CREATE OR REPLACE FUNCTION insertCliente(
    zTipoCli VARCHAR,
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
    zFecReg TIMESTAMP := current_timestamp;
    zConsecCli BIGINT;
BEGIN
    -- Insertar en la tabla tabCliente
    INSERT INTO tabCliente(fecReg, tipoCli, telCli, emailCli, dirCli)
    VALUES (zFecReg, zTipoCli, zTelCli, zEmailCli, zDirCli)
    RETURNING consecCli INTO zConsecCli;

    --validaciones para insertar dependiendo del tipo de cliente Natural o Juridico
    IF zTipoCli = 'Natural' THEN
        -- Insertar en la tabla tabClienteNatural
        INSERT INTO tabClienteNatural(cedulaCliNat, consecCli, fecReg, nomCli, apeCli)
        VALUES (zCedulaCliNat, zConsecCli, zFecReg, zNomCli, zApeCli);

    ELSIF zTipoCli = 'Juridico' THEN
        -- Insertar en la tabla tabClienteJuridico
        INSERT INTO tabClienteJuridico(nitCliJur, consecCli, fecReg, nomEmpr)
        VALUES (zNitCliJur, zConsecCli, zFecReg, zNomEmpr);
    END IF;

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