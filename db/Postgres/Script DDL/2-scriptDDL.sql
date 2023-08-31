CREATE TABLE tabAdministrador(
  codAdmin UUID NOT NULL,
  idAdmin INTEGER NOT NULL UNIQUE,
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
  PRIMARY KEY (codAdmin)
);


CREATE TABLE tabCliente(
  codCli UUID NOT NULL,
  idCli INTEGER NOT NULL UNIQUE,
  tipoCli VARCHAR NOT NULL,
  nomCli VARCHAR,
  apeCli VARCHAR,
  nomRepLegal VARCHAR,
  nomEmpresa VARCHAR,
  telCli VARCHAR NOT NULL,
  emailCli VARCHAR NOT NULL,
  dirCli VARCHAR NOT NULL,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (codCli)
);



CREATE TABLE tabProveedor(
  codProv UUID NOT NULL,
  idProv VARCHAR NOT NULL UNIQUE,
  nomProv VARCHAR NOT NULL,
  telProv VARCHAR NOT NULL,
  emailProv VARCHAR NOT NULL,
  dirProv VARCHAR NOT NULL,
  estado TEXT NOT NULL DEFAULT 'ACTIVO',
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (codProv)
);


CREATE TABLE tabCategoria(
  idCateg BIGINT NOT NULL UNIQUE,
  nomCateg VARCHAR NOT NULL,
  estado TEXT NOT NULL DEFAULT 'ACTIVO',
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (idCateg)
);


CREATE TABLE tabMarca(
  idMarca BIGINT NOT NULL,
  nomMarca VARCHAR NOT NULL,
  estado TEXT NOT NULL DEFAULT 'ACTIVO',
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (idMarca)
);



CREATE TABLE tabArticulo(
  eanArt VARCHAR  NOT NULL,
  nomArt VARCHAR NOT NULL,
  idMarca BIGINT NOT NULL,
  idCateg BIGINT NOT NULL,
  descripArt TEXT,
  valUnit NUMERIC(10),
  porcentaje NUMERIC(10,2),
  valStock INTEGER,
  stockMin INTEGER NOT NULL DEFAULT 10,
  stockMax INTEGER NOT NULL DEFAULT 500,
  valReorden INTEGER NOT NULL DEFAULT 50,
  fecVence DATE,
  idProv INTEGER NOT NULL, 
  estado TEXT NOT NULL DEFAULT 'ACTIVO',
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (eanArt),
  CONSTRAINT fkMarca
  FOREIGN KEY (idMarca) REFERENCES tabMarca(idMarca),
  CONSTRAINT fkCategoria
  FOREIGN KEY (idCateg) REFERENCES tabCategoria(idCateg)
   CONSTRAINT fkProveedor
  FOREIGN KEY (idProv) REFERENCES tabProveedor(idProv)
);


CREATE TABLE tabKardex(
  consecKardex BIGINT NOT NULL UNIQUE,
  tipoMov VARCHAR NOT NULL,
  eanArt VARCHAR NOT NULL,
  cantArt INTEGER NOT NULL,
  valCompra NUMERIC(10) NOT NULL,
  valTotal NUMERIC(10) NOT NULL,
  valProm NUMERIC(10) NOT NULL,
  observacion TEXT,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONE,
  userUpdate VARCHAR,
  PRIMARY KEY (consecKardex),
  CONSTRAINT fkArticulo
  FOREIGN KEY (eanArt) REFERENCES tabArticulo(eanArt),
);


CREATE TABLE tabEncabezadoVenta(
  consecEncVenta  BIGINT NOT NULL,
  fecVenta TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  tipoFactura VARCHAR NOT NULL, --factura legal- factura preliminar
  idCli INTEGER NOT NULL,
  totalPagar NUMERIC (10),
  estado TEXT NOT NULL DEFAULT 'ACTIVO',
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (consecEncVenta),
  CONSTRAINT fkCliente
  FOREIGN KEY (idCli) REFERENCES tabCliente(idCli)
  
);


CREATE TABLE tabDetalleVenta(
  consecDetVenta BIGINT NOT NULL UNIQUE,
  consecVenta BIGINT NOT NULL,
  eanArt VARCHAR NOT NULL,
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
  CONSTRAINT fkEncVenta
  FOREIGN KEY (consecEncVenta) REFERENCES tabEncabezadoVenta(consecEncVenta),
  CONSTRAINT fkArticulo
  FOREIGN KEY (eanArt) REFERENCES tabArticulo(eanArt)

);


CREATE TABLE tabRegBorrados(
  consecRegBor BIGINT NOT NULL,
  fecDelete TIMESTAMP WITHOUT TIME ZONE,
  userDelete VARCHAR NOT NULL,
  nomTabla VARCHAR NOT NULL,
  PRIMARY KEY (consecRegBor)
);
