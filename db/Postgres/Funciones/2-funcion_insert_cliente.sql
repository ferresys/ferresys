-- Función para insertar datos en la tabla "tab_cliente"
CREATE OR REPLACE FUNCTION insert_cliente(
    ztipo_cli tab_cliente.tipo_cli%type,
    zid_cli tab_cliente.id_cli%type,  
    znom_cli tab_cliente.nom_cli%type,
    zape_cli tab_cliente.ape_cli%type,
    znom_empr tab_cliente.nom_empr%type,
    ztel_cli tab_cliente.tel_cli%type,
    zemail_cli tab_cliente.email_cli%type, 
    zdir_cli tab_cliente.dir_cli%type
) RETURNS void AS 

$$
DECLARE
    
    zfec_reg timestamp := current_timestamp; --now();
	
BEGIN

    INSERT INTO tab_cliente(fec_reg, tipo_cli, id_cli, nom_cli, ape_cli, nom_empr, tel_cli, email_cli, dir_cli)
    VALUES (zfec_reg, ztipo_cli, zid_cli, znom_cli, zape_cli, znom_empr, ztel_cli, zemail_cli, zdir_cli);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$ 
LANGUAGE plpgsql;

/*
select insert_cliente('natural','1098121845','Manuel','Rojas','Alumina','3156478952','manuel@gmail.com','calle 14 #12-16');
select * from tab_cliente;


UPDATE tab_cliente
SET estado = 'INACTIVO'
WHERE consec_usu = 3;

*/