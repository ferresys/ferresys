
CREATE TABLE tabUsuario(
  codUsuario UUID NOT NULL,
  idUsuario VARCHAR NOT NULL UNIQUE,
  nomUsuario VARCHAR NOT NULL,
  ApeUsuario VARCHAR NOT NULL,
  emailUsuario VARCHAR NOT NULL,
  usuario VARCHAR NOT NULL,
  password VARCHAR NOT NULL,
  PRIMARY KEY (codUsuario)
);

CREATE TABLE tabPermiso(
  idPermiso SMALLINT PRIMARY KEY,
  nomPermiso VARCHAR NOT NULL,
  descPermiso TEXT NOT NULL,
  
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONE,
  userUpdate VARCHAR,
  PRIMARY KEY (idPermiso)
);

CREATE TABLE tabUsuarioPermiso(
idUsuarioPermiso SMALLINT NOT NULL,
  idUsuario VARCHAR NOT NULL,
  idPermiso SMALLINT NOT NULL,
  fecPermiso TIMESTAMP WITHOUT TIME ZONE, 
  FOREIGN KEY (idUsuario) REFERENCES tabUsuario(idUsuario),
  CONSTRAINT fkUsuario
  FOREIGN KEY (idPermiso) REFERENCES tabpermisos(idPermiso)
);

CREATE TABLE tabAdministrador(
  codAdmin UUID NOT NULL,
  idAdmin VARCHAR(15) NOT NULL UNIQUE,
  nomAdmin VARCHAR NOT NULL,
  apeAdmin VARCHAR NOT NULL,
  telAdmin VARCHAR NOT NULL,
  emailAdmin VARCHAR NOT NULL,
  usuario VARCHAR NOT NULL,
  password VARCHAR NOT NULL,
  estado BOOLEAN NOT NULL TRUE,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONE,
  userUpdate VARCHAR,
  PRIMARY KEY (codAdmin)
);

CREATE TABLE tabCliente(
  codCli UUID NOT NULL,
  idCli VARCHAR NOT NULL UNIQUE,
  tipoCli BOOLEAN NOT NULL TRUE,
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
  estado BOOLEAN NOT NULL TRUE,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (codProv)
);

CREATE TABLE tabCategoria(
  idCateg SMALLINT NOT NULL,
  nomCateg VARCHAR NOT NULL,
  estado BOOLEAN NOT NULL TRUE,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (idCateg)
);

CREATE TABLE tabMarca(
  idMarca SMALLINT NOT NULL,
  nomMarca VARCHAR NOT NULL,
  estado BOOLEAN NOT NULL TRUE,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (idMarca)
);

CREATE TABLE tabArticulo(
  eanArt VARCHAR  NOT NULL,
  nomArt VARCHAR NOT NULL,
  idMarca SMALLINT NOT NULL,
  idCateg SMALLINT NOT NULL,
  descripArt TEXT,
  valUnit NUMERIC(10),
  porcentaje NUMERIC(10,2), --valor porcentual para las ganancias por venta del articulo
  iva NUMERIC (10,2) NOT NULL DEFAULT 0,
  valStock INTEGER,
  stockMin INTEGER NOT NULL DEFAULT 10,
  stockMax INTEGER NOT NULL DEFAULT 500,
  valReorden INTEGER NOT NULL DEFAULT 50,
  fecVence DATE,
  estado BOOLEAN NOT NULL TRUE,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (eanArt),
  CONSTRAINT fkMarca
  FOREIGN KEY (idMarca) REFERENCES tabMarca(idMarca),
  CONSTRAINT fkCategoria
  FOREIGN KEY (idCateg) REFERENCES tabCategoria(idCateg)
  
);

CREATE TABLE tabKardex(
  consecKardex BIGINT NOT NULL UNIQUE,
  tipoMov VARCHAR NOT NULL,
  eanArt VARCHAR NOT NULL,
  cantArt INTEGER NOT NULL,
  valProm NUMERIC(10) NOT NULL,
  observacion TEXT,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONE,
  userUpdate VARCHAR,
  PRIMARY KEY (consecKardex),
  CONSTRAINT fkArticulo
  FOREIGN KEY (eanArt) REFERENCES tabArticulo(eanArt),
  FOREIGN KEY (cantArt) REFERENCES tabReciboMcia(cantArt),
);

CREATE TABLE tabReciboMercancia(
  consecReciboMcia BIGINT NOT NULL,
  eanArt VARCHAR NOT NULL,
  cantArt INTEGER NOT NULL,
  valCompra NUMERIC(10),
  valTotal NUMERIC(10),
  valprom NUMERIC(10) NOT NULL,
  idProv VARCHAR NOT NULL,
  idMarca SMALLINT NOT NULL,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONE,
  userUpdate VARCHAR,
  PRIMARY KEY (consecReciboMcia),
  CONSTRAINT fkProveedor
  FOREIGN KEY (idProv) REFERENCES tabProveedor(idProv),
  CONSTRAINT fkMarca
  FOREIGN KEY (idMarca) REFERENCES tabMarca(idMarca),
);

CREATE TABLE tabEncabezadoVenta(
  consecEncVenta BIGINT NOT NULL,
  fecVenta TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  tipoFactura VARCHAR NOT NULL, --factura legal- factura preliminar
  idCli INTEGER NOT NULL,
  estado BOOLEAN NOT NULL TRUE,
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
  iva NUMERIC (10,2) NOT NULL DEFAULT 0,
  descuento NUMERIC (10) NOT NULL DEFAULT 0,
  totalPagar NUMERIC(10) NOT NULL,
  estado BOOLEAN NOT NULL TRUE,
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

CREATE TABLE cotizacionCliente(
  idCotizacion INTEGER PRIMARY KEY,
  idCli VARCHAR NOT NULL,
  fecReg TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (idCotizacion)
);

CREATE TABLE tabRegBorrados(
  consecRegBor BIGINT NOT NULL,
  fecDelete TIMESTAMP WITHOUT TIME ZONE,
  userDelete VARCHAR NOT NULL,
  nomTabla VARCHAR NOT NULL,
  PRIMARY KEY (consecRegBor)
);