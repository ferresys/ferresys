-- Función para insertar datos en la tabla "tabProveedor"
CREATE OR REPLACE FUNCTION insertProveedor(
    
    zNitProv tabProveedor.nitProv%type,
    zNomProv tabProveedor.nomProv%type,
    zTelProv tabProveedor.telProv%type,  
    zEmailProv tabProveedor.emailProv%type, 
    zDirProv tabProveedor.dirProv%type

) RETURNS void AS 

$$
DECLARE
    
    zFecReg TIMESTAMP:= current_timestamp;--now(); puede ser current_timestamp o now();
	
BEGIN

    INSERT INTO tabProveedor(fecReg, nitProv, nomProv, telProv, emailProv, dirProv)
    VALUES (zFecReg, zNitProv, zNomProv, zTelProv, zEmailProv, zDirProv);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$ 
LANGUAGE plpgsql;

/*
select insertProveedor('0-12','DEWALT','3156478952','dewalt@gmail.com','calle 22 #1-14');
select insertProveedor('0-13','DEWALT','3156478952','dewalt@gmail.com','calle 22 #1-14');
select insertProveedor('0-14','MAKITA','3105642356','makita@gmail.com','calle 45 #25-15');
select * from tabProveedor;


UPDATE tabProveedor
SET estado = 'INACTIVO'
WHERE nitProv = '0-1234';

*/