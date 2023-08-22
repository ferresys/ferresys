-- Función para insertar datos en la tabla "tabAdministrador"
CREATE OR REPLACE FUNCTION insertAdministrador(
    zIdAdmin tabAdministrador.idAdmin%type,
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

    INSERT INTO tabAdministrador(idAdmin, fecReg, nomAdmin, apeAdmin, telAdmin, emailAdmin, usuario, password)
    VALUES ( zidAdmin, zFecReg, znomAdmin, zapeAdmin, ztelAdmin, zemailAdmin, zUsuario, zPassword);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$ 
LANGUAGE plpgsql;

/*
select insertAdministrador(1095821827,'yocser','chavez','3022292053','kayserk24@gmail.com','yocser','1234');
select * from tabAdministrador;


UPDATE tabAdmin
SET estado = 'INACTIVO'
WHERE idAdmin= 1095821827;

*/