CREATE TABLE tabAdministrador(
  idAdmin UUID NOT NULL,
  cedulaAdmin INTEGER NOT NULL UNIQUE,
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
  idCli UUID NOT NULL,
  consecCli BIGINT NOT NULL UNIQUE,
  fecReg TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  tipoCli VARCHAR NOT NULL,
  telCli VARCHAR NOT NULL,
  emailCli VARCHAR NOT NULL,
  dirCli VARCHAR NOT NULL,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (idCli)
);


CREATE TABLE tabClienteNatural(
  idCliNat UUID NOT NULL,
  cedulaCliNat INTEGER NOT NULL UNIQUE,
  consecCli BIGINT NOT NULL,
  fecReg TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  nomCli VARCHAR NOT NULL,
  apeCli VARCHAR NOT NULL,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (idCliNat),
  CONSTRAINT fkCliNatural
  FOREIGN KEY (consecCli) REFERENCES tabCliente(consecCli)
);

CREATE TABLE tabClienteJuridico(
  idCliJur UUID NOT NULL,
  nitCliJur VARCHAR NOT NULL UNIQUE,
  consecCli BIGINT NOT NULL,
  fecReg TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  nomEmpr VARCHAR NOT NULL,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (idCliJur),
  CONSTRAINT fkCliJuridico
  FOREIGN KEY (consecCli) REFERENCES tabCliente(consecCli)
);

CREATE TABLE tabProveedor(
  idProv UUID NOT NULL,
  nitProv VARCHAR NOT NULL UNIQUE,
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
  PRIMARY KEY (idProv)
);


CREATE TABLE tabCategoria(
  idCateg UUID NOT NULL,
  consecCateg BIGINT NOT NULL UNIQUE,
  nomCateg VARCHAR NOT NULL,
  estado TEXT NOT NULL DEFAULT 'ACTIVO',
  cedulaAdmin INTEGER NOT NULL,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (idCateg),
  CONSTRAINT fkAdministrador
  FOREIGN KEY (cedulaAdmin ) REFERENCES tabAdministrador(cedulaAdmin)
);


CREATE TABLE tabMarca(
  idMarca UUID NOT NULL,
  consecMarca BIGINT NOT NULL UNIQUE,
  nomMarca VARCHAR NOT NULL,
  estado TEXT NOT NULL DEFAULT 'ACTIVO',
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (idMarca)
);


CREATE TABLE tabProveedorMarca(
  idProvMarca UUID NOT NULL,
  consecProvMarca BIGINT NOT NULL UNIQUE,
  nitProv VARCHAR NOT NULL,
  consecMarca BIGINT NOT NULL,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (idProvMarca),
  CONSTRAINT fkProveedor
  FOREIGN KEY (nitProv) REFERENCES tabProveedor(nitProv),
  CONSTRAINT fkMarca
  FOREIGN KEY (consecMarca) REFERENCES tabMarca(consecMarca)
);


CREATE TABLE tabArticulo(
  idArt UUID NOT NULL,
  eanArt VARCHAR  UNIQUE,
  fecReg TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  nomArt VARCHAR NOT NULL,
  consecMarca BIGINT NOT NULL,
  consecCateg BIGINT NOT NULL,
  descripArt TEXT,
  valUnit NUMERIC(10),
  porcentaje NUMERIC(10,2),
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
  PRIMARY KEY (idArt),
  CONSTRAINT fkMarca
  FOREIGN KEY (consecMarca) REFERENCES tabMarca(consecMarca),
  CONSTRAINT fkCategoria
  FOREIGN KEY (consecCateg) REFERENCES tabCategoria(consecCateg)
);


CREATE TABLE tabKardex(
  idKardex UUID NOT NULL,
  consecKardex BIGINT NOT NULL UNIQUE,
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
  consecMarca BIGINT NOT NULL,
  cedulaAdmin INTEGER NOT NULL,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONE,
  userUpdate VARCHAR,
  PRIMARY KEY (idKardex),
  CONSTRAINT fkArticulo
  FOREIGN KEY (eanArt) REFERENCES tabArticulo(eanArt),
  CONSTRAINT fkProveedor
  FOREIGN KEY (nitProv) REFERENCES tabProveedor(nitProv),
  CONSTRAINT fkAdministrador
  FOREIGN KEY (cedulaAdmin) REFERENCES tabAdministrador(cedulaAdmin),
  CONSTRAINT fkMarca
  FOREIGN KEY (consecMarca) REFERENCES tabMarca(consecMarca)
);


CREATE TABLE tabProveedorArticulo(
  idProvArt UUID NOT NULL,
  consecProvArt BIGINT NOT NULL UNIQUE,
  nitProv VARCHAR NOT NULL,
  eanArt VARCHAR NOT NULL,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (idProvArt),
  CONSTRAINT fkProveedor
  FOREIGN KEY (nitProv) REFERENCES tabProveedor(nitProv),
  CONSTRAINT fkArticulo
  FOREIGN KEY (eanArt) REFERENCES tabArticulo(eanArt)

);


CREATE TABLE tabEncabezadoVenta(
  idventa UUID NOT NULL,
  consecVenta BIGINT NOT NULL UNIQUE,
  fecVenta TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  tipoFactura VARCHAR NOT NULL, --factura legal- factura preliminar
  cedulaCliNat INTEGER,
  NitCliJur VARCHAR,
  totalPagar NUMERIC (10),
  cedulaAdmin INTEGER NOT NULL,
  estado TEXT NOT NULL DEFAULT 'ACTIVO',
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (idVenta),
  CONSTRAINT fkClienteNatural
  FOREIGN KEY (cedulaCliNat) REFERENCES tabClienteNatural(cedulaCliNat),
  CONSTRAINT fkClienteJuridico
  FOREIGN KEY (nitCliJur) REFERENCES tabClienteJuridico(nitCliJur),
  CONSTRAINT fkAdministrador
  FOREIGN KEY (cedulaAdmin) REFERENCES tabAdministrador(cedulaAdmin)
  
  
);


CREATE TABLE tabDetalleVenta(
  idDetVenta UUID NOT NULL,
  consecDetVenta BIGINT NOT NULL UNIQUE,
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
  PRIMARY KEY (idDetVenta),
  CONSTRAINT fkVenta
  FOREIGN KEY (consecVenta) REFERENCES tabEncabezadoVenta(consecVenta),
  CONSTRAINT fkArticulo
  FOREIGN KEY (eanArt) REFERENCES tabArticulo(eanArt)

);

CREATE TABLE tabRegBorrados(
  idReg UUID NOT NULL,
  consecReg BIGINT NOT NULL UNIQUE,
  fecDelete TIMESTAMP WITHOUT TIME ZONE,
  userDelete VARCHAR NOT NULL,
  nomTabla VARCHAR NOT NULL,
  PRIMARY KEY (consecReg)
);
