-- Función para insertar datos en la tabla "tabCliente"
CREATE OR REPLACE FUNCTION insertCliente(
    zTipoCli tabCliente.tipoCli%type,
    zTelCli tabCliente.telCli%type,
    zEmailCli tabCliente.emailCli%type, 
    zDirCli tabCliente.dirCli%type,
    zIdCli tabCliente.idCli%type,  
    zNomCli tabCliente.nomCli%type,
    zApeCli tabCliente.apeCli%type,
    zNomEmpr tabCliente.nomEmpr%type
) RETURNS void AS 


$$
DECLARE
    
    zFecReg timestamp := current_timestamp; --now();
	zConsecCli BIGINT;

BEGIN

    INSERT INTO tabCliente(fecReg, tipoCli, telCli, emailCli, dirCli)
    VALUES (zFecReg, zTipoCli, zTelCli, zEmailCli, zDirCli)
    RETURNING consecCli INTO zConsecCli;

    INSERT INTO tabClienteJuridico(nitCli,consecCli, fecReg, nomEmpr)
    VALUES (zIdCli, zConsecCli, zFecReg, zNomEmpr);

    INSERT INTO tabClienteNatural(idCli,consecCli, fecReg, nomCli, apeCli)
    VALUES (zIdCli,zConsecCli,zFecReg, zNomCli, zApe_Cli);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$ 
LANGUAGE plpgsql;

/*
select insertCliente('natural','1098121845','Manuel','Rojas','','3156478952','manuel@gmail.com','calle 14 #12-16');
select * from tabCliente;


UPDATE tabCliente
SET estado = 'INACTIVO'
WHERE consecCli = 3;

*/