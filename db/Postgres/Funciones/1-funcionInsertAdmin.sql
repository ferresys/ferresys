
-- Función para insertar datos en la tabla "tabAdministrador"

CREATE OR REPLACE FUNCTION insertAdministrador(
    zCedulaAdmin tabAdministrador.cedulaAdmin%type,
    zNomAdmin tabAdministrador.nomAdmin%type,
    zApeAdmin tabAdministrador.apeAdmin%type,
    zTelAdmin tabAdministrador.telAdmin%type,
    zEmailAdmin tabAdministrador.emailAdmin%type,
    zUsuario tabAdministrador.usuario%type,
    zPassword tabAdministrador.password%type    
) RETURNS void AS 


$$
DECLARE

    ZFecReg timestamp := now(); /*tambien puedo usar current_timestamp*/
    
BEGIN

    INSERT INTO tabAdministrador(cedulaAdmin, fecReg, nomAdmin, apeAdmin, telAdmin, emailAdmin, usuario, password)
    VALUES ( zCedulaAdmin, zFecReg, zNomAdmin, zApeAdmin, zTelAdmin, zEmailAdmin, zUsuario, zPassword );
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$ 
LANGUAGE plpgsql;

/*
select insertAdministrador(1098821827,'yocser','chavez','3022292053','kraken@gmail.com','yocser','1234');
select insertAdministrador(1006452544,'David','Adarme','3004567891','kraken1@gmail.com','david','5678');
select * from tabAdministrador where id= '0b781678-b69e-46da-99bd-431bd7a776eb';
select * from tabAdministrador where idAdmin=1095821827

UPDATE tabAdmin
SET estado = 'INACTIVO'
WHERE idAdmin= 1095821827;

*/