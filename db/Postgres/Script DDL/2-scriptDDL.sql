
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
  consecPermiso SMALLINT,
  nomPermiso VARCHAR NOT NULL,
  descPermiso TEXT NOT NULL,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONE,
  userUpdate VARCHAR,
  PRIMARY KEY (consecPermiso)
);

CREATE TABLE tabUsuarioPermiso(
  consecUsuarioPermiso SMALLINT NOT NULL,
  idUsuario VARCHAR NOT NULL,
  consecPermiso SMALLINT NOT NULL,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONE,
  userUpdate VARCHAR,
  PRIMARY KEY (consecUsuarioPermiso)
  FOREIGN KEY (idUsuario) REFERENCES tabUsuario(idUsuario),
  CONSTRAINT fkUsuario
  FOREIGN KEY (idPermiso) REFERENCES tabPermiso(consecPermiso)
);

CREATE TABLE tabCliente(
  codCli UUID NOT NULL,
  idCli VARCHAR NOT NULL UNIQUE,
  tipoCli BOOLEAN NOT NULL  DEFAULT TRUE, --TRUE="CLIENTE NATURAL" / FALSE="CLIENTE JURIDICO"
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
  estado BOOLEAN NOT NULL DEFAULT TRUE,
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
  fecUpdate TIMESTAMP WITHOUT TIME ZONE,
  userUpdate VARCHAR,
  PRIMARY KEY (consecMarca)
);

CREATE TABLE tabArticulo(
  eanArt VARCHAR NOT NULL,
  nomArt VARCHAR NOT NULL,
  consecMarca SMALLINT NOT NULL,
  consecCateg SMALLINT NOT NULL,
  descArt TEXT,
  valUnit NUMERIC(10),
  porcentaje NUMERIC(10,2),
  iva NUMERIC (10,2) NOT NULL,
  valStock INTEGER,
  stockMin INTEGER NOT NULL,
  stockMax INTEGER NOT NULL,
  valReorden INTEGER NOT NULL,
  fecVence DATE,
  estado BOOLEAN NOT NULL DEFAULT TRUE,
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
  consecKardex BIGINT NOT NULL,
  consecReciboMcia BIGINT NOT NULL,
  tipoMov BOOLEAN NOT NULL DEFAULT TRUE, --TRUE="ENTRADA" FALSE="SALIDA"
  eanArt VARCHAR NOT NULL,
  cantArt INTEGER NOT NULL,
  valProm NUMERIC(10) NOT NULL, --Valor de compra promedio
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONE,
  userUpdate VARCHAR,
  PRIMARY KEY (consecKardex),
  CONSTRAINT fkArticulo
  FOREIGN KEY (eanArt) REFERENCES tabArticulo(eanArt),
  CONSTRAINT fkReciboMercancia
  FOREIGN KEY (consecReciboMcia) REFERENCES tabReciboMercancia(consecReciboMcia),
);

CREATE TABLE tabReciboMercancia(
  consecReciboMcia BIGINT NOT NULL,
  eanArt VARCHAR NOT NULL,
  cantArt INTEGER NOT NULL,
  valCompra NUMERIC(10),
  valTotal NUMERIC(10),
  idProv VARCHAR NOT NULL,
  consecMarca SMALLINT NOT NULL,
  observacion TEXT,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONE,
  userUpdate VARCHAR,
  PRIMARY KEY (consecReciboMcia),
   CONSTRAINT fkArticulo
  FOREIGN KEY (eanArt) REFERENCES tabArticulo(eanArt),
  CONSTRAINT fkProveedor
  FOREIGN KEY (idProv) REFERENCES tabProveedor(idProv),
  CONSTRAINT fkMarca
  FOREIGN KEY (consecMarca) REFERENCES tabMarca(consecMarca)
);

CREATE TABLE tabEncabezadoVenta(
  consecEncVenta BIGINT NOT NULL,
  consecEnCotizacion BIGINT NOT NULL,
  tipoFactura BOOLEAN NOT NULL DEFAULT TRUE, --TRUE='LEGAL' / FALSE='COTIZACION'
  estado BOOLEAN NOT NULL DEFAULT TRUE, --TRUE= "Generada" / FALSE="Anulada" 
  idCli INTEGER NOT NULL,
  ciudad VARCHAR NOT NULL DEFAULT 'Bucaramanga',
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (consecEncVenta),
  CONSTRAINT fkCliente
  FOREIGN KEY (idCli) REFERENCES tabCliente(idCli)
);

CREATE TABLE tabDetalleVenta(
  consecDetVenta BIGINT NOT NULL,
  consecEncVenta BIGINT NOT NULL,
  eanArt VARCHAR NOT NULL,
  cantArt INTEGER NOT NULL,
  valUnit NUMERIC(10) NOT NULL,
  subTotal NUMERIC(10) NOT NULL,
  iva NUMERIC (10,2) NOT NULL DEFAULT 0,
  descuento NUMERIC (10) NOT NULL DEFAULT 0,
  totalPagar NUMERIC(10) NOT NULL,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONE,
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