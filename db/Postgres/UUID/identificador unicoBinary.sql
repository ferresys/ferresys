CREATE TABLE tabAdministrador (
  idAdmin BINARY(16) DEFAULT UUID_BIN(), --Sin embargo, no estoy seguro a que entidades colocarles este tipo de datos 
  --idAdmin UUID  NOT NULL,
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

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

 INSERT INTO tabAdministrador(idAdmin, fecReg, nomAdmin, apeAdmin, telAdmin, emailAdmin, usuario, password)
    VALUES ( uuid_generate_v4(), now(), 'David', 'Adarme', '315456784', 'kraken@gmail.com', 'david', '1234');
	
	alter table tabAdministrador drop column fecInsert;
	alter table tabAdministrador drop column userInsert ;
	alter table tabAdministrador drop column fecUpdate ;
	alter table tabAdministrador drop column userUpdate;
	
SELECT * FROM tabAdministrador WHERE idAdmin = uuid_generate_v4();
SELECT * FROM tabAdministrador WHERE idAdmin ='ea8670b9-5762-4147-aef8-41039f8791da';
	
