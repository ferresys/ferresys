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


CREATE TABLE tabCliente(
  consecCli BIGINT NOT NULL DEFAULT NEXTVAL('consecCli'),
  fecReg TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  tipoCli VARCHAR NOT NULL,
  PRIMARY KEY (consecCli)
);

CREATE TABLE tabClienteNatural(
  idCli VARCHAR NOT NULL,
  consecCli BIGINT NOT NULL,
  fecReg TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  nomCli VARCHAR ,
  apeCli VARCHAR ,
  telCli VARCHAR NOT NULL,
  emailCli VARCHAR NOT NULL,
  dirCli VARCHAR NOT NULL,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (idCli),
  CONSTRAINT fkCliNatural
  FOREIGN KEY (consecCli) REFERENCES tabCliente(consecCli)
);

CREATE TABLE tabClienteJuridico(
  nitCli VARCHAR NOT NULL,
  consecCli BIGINT NOT NULL,
  fecReg TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  nomEmpr VARCHAR ,
  telEmpr VARCHAR NOT NULL,
  emailEmpr VARCHAR NOT NULL,
  dirEmpr VARCHAR NOT NULL,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (nitCli),
  CONSTRAINT fkCliJuridico
  FOREIGN KEY (consecCli) REFERENCES tabCliente(consecCli)
);

CREATE TABLE tabProveedor(
  nitProv VARCHAR NOT NULL,
  fecReg TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  nomProv VARCHAR NOT NULL,
  telProv VARCHAR NOT NULL,
  emailProv VARCHAR NOT NULL,
  dirProv VARCHAR NOT NULL,
  estado TEXT NOT NULL DEFAULT 'ACTIVO',
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (nitProv)
);


CREATE TABLE tabCategoria(
  consecCateg BIGINT NOT NULL DEFAULT NEXTVAL('consecCateg'),
  nomCateg VARCHAR NOT NULL,
  estado TEXT NOT NULL DEFAULT 'ACTIVO',
  idAdmin INTEGER NOT NULL,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (consecCateg),
  CONSTRAINT fkAdministrador
  FOREIGN KEY (idAdmin ) REFERENCES tabAdministrador(idAdmin)
);


CREATE TABLE tabMarca(
  consecMarca BIGINT NOT NULL DEFAULT NEXTVAL('consecMarca'),
  nomMarca VARCHAR NOT NULL,
  estado TEXT NOT NULL DEFAULT 'ACTIVO',
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (consecMarca)
);


CREATE TABLE tabProveedorMarca(
  consecProvMarca BIGINT NOT NULL DEFAULT NEXTVAL('consecProvMarca'),
  nitProv VARCHAR NOT NULL,
  consecMarca BIGINT NOT NULL,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (consecProvMarca),
  CONSTRAINT fkProveedor
  FOREIGN KEY (nitProv) REFERENCES tabProveedor(nitProv),
  CONSTRAINT fkMarca
  FOREIGN KEY (consecMarca) REFERENCES tabMarca(consecMarca)
);


CREATE TABLE tabArticulo(
  eanArt VARCHAR NOT NULL,
  fecReg TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  nomArt VARCHAR NOT NULL,
  consecMarca BIGINT NOT NULL,
  consecCateg BIGINT NOT NULL,
  descripArt TEXT,
  valUnit NUMERIC(10),
  valStock INTEGER,
  stockMin INTEGER NOT NULL DEFAULT 10,
  stockMax INTEGER NOT NULL DEFAULT 500,
  valReorden INTEGER NOT NULL DEFAULT 50,
  fecVence DATE,
  estado TEXT NOT NULL DEFAULT 'ACTIVO',
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (eanArt),
  CONSTRAINT fkMarca
  FOREIGN KEY (consecMarca) REFERENCES tabMarca(consecMarca),
  CONSTRAINT fkCategoria
  FOREIGN KEY (consecCateg) REFERENCES tabCategoria(consecCateg)
);


CREATE TABLE tabKardex(
  consecKardex BIGINT NOT NULL DEFAULT NEXTVAL('consecKardex'),
  fecMov TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  tipoMov VARCHAR NOT NULL,
  eanArt VARCHAR NOT NULL,
  nomArt VARCHAR NOT NULL,
  cantArt INTEGER NOT NULL,
  valCompra NUMERIC(10) NOT NULL,
  valTotal NUMERIC(10) NOT NULL,
  valProm NUMERIC(10) NOT NULL,
  observacion TEXT,
  nitProv VARCHAR NOT NULL,
  idAdmin INTEGER NOT NULL,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONE,
  userUpdate VARCHAR,
  PRIMARY KEY (consecKardex),
  CONSTRAINT fkArticulo
  FOREIGN KEY (eanArt) REFERENCES tabArticulo(eanArt),
  CONSTRAINT fkProveedor
  FOREIGN KEY (nitProv) REFERENCES tabProveedor(nitProv),
  CONSTRAINT fkAdministrador
  FOREIGN KEY (idAdmin) REFERENCES tabAdministrador(idAdmin)
);


CREATE TABLE tabProveedorArticulo(
  consecProvArt BIGINT NOT NULL DEFAULT NEXTVAL('consecProvArt'),
  nitProv VARCHAR NOT NULL,
  eanArt VARCHAR NOT NULL,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (consecProvArt),
  CONSTRAINT fkProveedor
  FOREIGN KEY (nitProv) REFERENCES tabProveedor(nitProv),
  CONSTRAINT fkArticulo
  FOREIGN KEY (eanArt) REFERENCES tabArticulo(eanArt)

);


CREATE TABLE tabEncabezadoVenta(
  consecVenta BIGINT NOT NULL DEFAULT NEXTVAL('consecVenta'),
  fecVenta TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  consecCli BIGINT NOT NULL,
  totalPagar NUMERIC (10),
  idAdmin INTEGER NOT NULL,
  estado TEXT NOT NULL DEFAULT 'ACTIVO',
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (consecVenta),
  CONSTRAINT fkCliente
  FOREIGN KEY (consecCli) REFERENCES tabCliente(consecCli),
  CONSTRAINT fkAdministrador
  FOREIGN KEY (idAdmin) REFERENCES tabAdministrador(idAdmin)
  
  
);


CREATE TABLE tabDetalleVenta(
  consecDetVenta BIGINT NOT NULL DEFAULT NEXTVAL('consecDetVenta'),
  consecVenta BIGINT NOT NULL,
  eanArt VARCHAR NOT NULL,
  nomArt VARCHAR NOT NULL,
  cantArt INTEGER NOT NULL,
  valUnit NUMERIC(10) NOT NULL,
  subTotal NUMERIC(10) NOT NULL,
  totalPagar NUMERIC(10) NOT NULL,
  estado TEXT NOT NULL DEFAULT 'ACTIVO',
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (consecDetVenta),
  CONSTRAINT fkVenta
  FOREIGN KEY (consecVenta) REFERENCES tabEncabezadoVenta(consecVenta),
  CONSTRAINT fkArticulo
  FOREIGN KEY (eanArt) REFERENCES tabArticulo(eanArt)

);



CREATE TABLE tabRegBorrados(
  consecReg BIGINT NOT NULL DEFAULT NEXTVAL('consecReg'),
  fecDelete TIMESTAMP WITHOUT TIME ZONE,
  userDelete VARCHAR NOT NULL,
  nomTabla VARCHAR NOT NULL,
  PRIMARY KEY (consecReg)
);
