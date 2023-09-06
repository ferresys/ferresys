
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
  consecPermiso SMALLINT PRIMARY KEY,
  nomPermiso VARCHAR NOT NULL,
  descPermiso TEXT NOT NULL, --descripción permiso
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONE,
  userUpdate VARCHAR,
  PRIMARY KEY (idPermiso)
);

CREATE TABLE tabUsuarioPermiso(
  consecUsuarioPermiso SMALLINT NOT NULL,
  idUsuario VARCHAR NOT NULL,
  consecPermiso SMALLINT NOT NULL,
  fecPermiso TIMESTAMP WITHOUT TIME ZONE, 
  PRIMARY KEY (consecUsuarioPermiso)
  FOREIGN KEY (idUsuario) REFERENCES tabUsuario(idUsuario),
  CONSTRAINT fkUsuario
  FOREIGN KEY (idPermiso) REFERENCES tabpermisos(idPermiso)
);

CREATE TABLE tabCliente(
  codCli UUID NOT NULL,
  idCli VARCHAR NOT NULL UNIQUE,
  tipoCli BOOLEAN NOT NULL  DEFAULT TRUE, --TRUE="CLIENTE NATURAL"
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
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (codProv)
);

CREATE TABLE tabCategoria(
  consecCateg SMALLINT NOT NULL,
  nomCateg VARCHAR NOT NULL,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (consecCateg)
);

CREATE TABLE tabMarca(
  consecMarca SMALLINT NOT NULL,
  nomMarca VARCHAR NOT NULL,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (idMarca)
);

CREATE TABLE tabArticulo(
  eanArt VARCHAR  NOT NULL,
  nomArt VARCHAR NOT NULL,
  consecMarca SMALLINT NOT NULL,
  consecCateg SMALLINT NOT NULL,
  descArt TEXT, --descripción del articulo
  valUnit NUMERIC(10),
  porcentaje NUMERIC(10,2), --valor porcentual para las ganancias por venta del articulo
  iva NUMERIC (10,2) NOT NULL DEFAULT 0,
  valStock INTEGER,
  stockMin INTEGER NOT NULL,
  stockMax INTEGER NOT NULL,
  valReorden INTEGER NOT NULL,
  fecVence DATE,
  estado BOOLEAN NOT NULL TRUE,
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
  consecKardex BIGINT NOT NULL UNIQUE,
  tipoMov BOOLEAN NOT NULL DEFAULT TRUE, --TRUE="ENTRADA" FALSE="SALIDA"
  eanArt VARCHAR NOT NULL,
  cantArt INTEGER NOT NULL,
  valProm NUMERIC(10) NOT NULL,--Valor de compra promedio
  observacion TEXT,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONE,
  userUpdate VARCHAR,
  PRIMARY KEY (consecKardex),
  CONSTRAINT fkArticulo
  FOREIGN KEY (eanArt) REFERENCES tabArticulo(eanArt),
);

CREATE TABLE tabReciboMercancia(
  consecReciboMcia BIGINT NOT NULL,
  eanArt VARCHAR NOT NULL,
  cantArt INTEGER NOT NULL,
  valCompra NUMERIC(10),
  valTotal NUMERIC(10),
  idProv VARCHAR NOT NULL,
  consecMarca SMALLINT NOT NULL,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONE,
  userUpdate VARCHAR,
  PRIMARY KEY (consecReciboMcia),
  CONSTRAINT fkProveedor
  FOREIGN KEY (idProv) REFERENCES tabProveedor(idProv),
  CONSTRAINT fkMarca
  FOREIGN KEY (consecMarca) REFERENCES tabMarca(consecMarca),
);

CREATE TABLE tabEncabezadoVenta(
  consecEncVenta SMALLINT NOT NULL,
  fecVenta TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  --tipoFactura BOOLEAN NOT NULL, --factura legal- cotización
  estado BOOLEAN NOT NULL TRUE, --TRUE= 'Anulada"
  idCli INTEGER NOT NULL,
  ciudad Varchar NOT NULL DEFAULT 'Bucaramanga',
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
  consecEncVenta SMALLINT NOT NULL,
  eanArt VARCHAR NOT NULL,
  cantArt INTEGER NOT NULL,
  valUnit NUMERIC(10) NOT NULL,
  subTotal NUMERIC(10) NOT NULL,
  iva NUMERIC (10,2) NOT NULL DEFAULT 0,
  descuento NUMERIC (10) NOT NULL DEFAULT 0,
  totalPagar NUMERIC(10) NOT NULL,
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

CREATE TABLE tabcotizacionCliente(
  consecCotizacion SMALLINT NOT NULL,
  fecVenta TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  --tipoFactura BOOLEAN NOT NULL, --factura legal- factura preliminar
  idCli INTEGER NOT NULL,
  ciudad Varchar NOT NULL DEFAULT 'Bucaramanga',
  estado BOOLEAN NOT NULL TRUE,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (consecEncVenta),
  CONSTRAINT fkCliente
  FOREIGN KEY (idCli) REFERENCES tabCliente(idCli)
);

CREATE TABLE tabRegBorrados(
  consecRegBor BIGINT NOT NULL,
  fecDelete TIMESTAMP WITHOUT TIME ZONE,
  userDelete VARCHAR NOT NULL,
  nomTabla VARCHAR NOT NULL,
  PRIMARY KEY (consecRegBor)
);