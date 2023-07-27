-- Función para insertar datos en la tabla "tab_proveedor"
CREATE OR REPLACE FUNCTION insert_proveedor(
    
    znit_prov tab_proveedor.nit_prov%type,
    znom_prov tab_proveedor.nom_prov%type,
    ztel_prov tab_proveedor.tel_prov%type,  
    zemail_prov tab_proveedor.email_prov%type, 
    zdir_prov tab_proveedor.dir_prov%type

) RETURNS void AS 

$$
DECLARE
    
    zfec_reg timestamp := current_timestamp;--now(); puede ser current_timestamp o now();
	
BEGIN

    INSERT INTO tab_proveedor(fec_reg, nit_prov, nom_prov, tel_prov, email_prov, dir_prov)
    VALUES (zfec_reg, znit_prov, znom_prov, ztel_prov, zemail_prov, zdir_prov);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$ 
LANGUAGE plpgsql;

/*
select insert_proveedor('0-1098235641','DEWALT','3156478952','dewalt@gmail.com','calle 22 #1-14');
select * from tab_proveedor;


UPDATE tab_proveedor
SET estado = 'INACTIVO'
WHERE consec_prov = 1;

*/