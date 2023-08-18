-- Función para insertar datos en la tabla "tab_usuario"
CREATE OR REPLACE FUNCTION insertAdmin(
    ZidAdmin tabAdmin.idAdmin%type,
    ZnomAdmin tabAdmin.nomAdmin%type,
    ZapeAdmin tabAdmin.apeAdmin%type,
    ZtelAdmin tabAdmin.telAdmin%type,
    ZemailAdmin tabAdmin.emailAdmin%type,
    Zusuario tabAdmin.usuario%type,
    Zpassword tabAdmin.password%type    
) RETURNS void AS 

***
CREATE TABLE tabAdministrador(
  idAdmin INTEGER NOT NULL,
  fecReg TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  nomAdmin VARCHAR NOT NULL,
  apeAdmin VARCHAR NOT NULL,
  telAdmin VARCHAR NOT NULL,
  emailAdmin VARCHAR NOT NULL,
  usuario VARCHAR NOT NULL,
  password VARCHAR NOT NULL,
  estado TEXT NOT NULL DEFAULT 'ACTIVO',
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONE,
  userUpdate VARCHAR,
  PRIMARY KEY (idAdmin)
);

****

$$
DECLARE
    ZfecReg timestamp := now(); /*tambien puedo usar current_timestamp*/
    
BEGIN

    INSERT INTO tabAdmin(idAdmin, fecReg, nomAdmin, apeAdmin, telAdmin, emailAdmin, usuario, password)
    VALUES ( zidAdmin, zfecReg, znomAdmin, zapeAdmin, ztelAdmin, zemailAdmin, zusuario, zpassword);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$ 
LANGUAGE plpgsql;

/*
select insertAdmin(1095821827,'yocser','chavez','3022292053','kayserk24@gmail.com','yocser','1234');
select * from tabAdmin;
SELECT estado_texto(true);

UPDATE tabAdmin
SET estado = 'INACTIVO'
WHERE consec_usu = 3;

*/