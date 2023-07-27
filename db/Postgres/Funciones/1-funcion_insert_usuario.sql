-- Función para insertar datos en la tabla "tab_usuario"
CREATE OR REPLACE FUNCTION insert_usuario(
    Zid_usu tab_usuario.id_usu%type,
    Znom_usu tab_usuario.nom_usu%type,
    Zape_usu tab_usuario.ape_usu%type,
    Ztel_usu tab_usuario.tel_usu%type,
    Zemail_usu tab_usuario.email_usu%type,
    Zusuario tab_usuario.usuario%type,
    Zpassword tab_usuario.password%type	
) RETURNS void AS 

$$
DECLARE
    Zfec_reg timestamp := now(); /*tambien puedo usar current_timestamp*/
	
BEGIN

    INSERT INTO tab_usuario(id_usu, fec_reg, nom_usu, ape_usu, tel_usu, email_usu, usuario, password)
    VALUES ( zid_usu, zfec_reg, znom_usu, zape_usu, ztel_usu, zemail_usu, zusuario, zpassword);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$ 
LANGUAGE plpgsql;

/*
select insert_usuario(1095821827,'yocser','chavez','3022292053','kayserk24@gmail.com','yocser','1234');
select * from tab_usuario;
SELECT estado_texto(true);

UPDATE tab_usuario
SET estado = 'INACTIVO'
WHERE consec_usu = 3;

*/