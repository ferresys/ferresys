-- Función para insertar datos en la tabla "tab_proveedor"
CREATE OR REPLACE FUNCTION insertProveedor(
    
    zNitProv tabProveedor.nitProv%type,
    zNomProv tabProveedor.nomProv%type,
    zTelProv tabProveedor.telProv%type,  
    zEmailProv tabProveedor.emailProv%type, 
    zDirProv tabProveedor.dirProv%type

) RETURNS void AS 

$$
DECLARE
    
    zFecReg timestamp := current_timestamp;--now(); puede ser current_timestamp o now();
	
BEGIN

    INSERT INTO tabProveedor(fecReg, nitProv, nomProv, telProv, emailProv, dirProv)
    VALUES (zFecReg, zNitProv, zNomProv, zTelProv, zEmailProv, zDirProv);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$ 
LANGUAGE plpgsql;

/*
select insertProveedor('0-1098235641','DEWALT','3156478952','dewalt@gmail.com','calle 22 #1-14');
select * from tabProveedor;


UPDATE tabProveedor
SET estado = 'INACTIVO'
WHERE nitProv = 1;

*/