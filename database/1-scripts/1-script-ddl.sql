
CREATE TABLE tabUsuario(
  codUsuario UUID NOT NULL,
  idUsuario VARCHAR NOT NULL UNIQUE,
  nomUsuario VARCHAR NOT NULL,
  apeUsuario VARCHAR NOT NULL,
  emailUsuario VARCHAR NOT NULL,
  usuario VARCHAR NOT NULL,
  password VARCHAR NOT NULL,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONE,
  userUpdate VARCHAR,
  PRIMARY KEY (codUsuario)
);

CREATE TABLE tabPermiso(
  consecPermiso SMALLINT NOT NULL,
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
  PRIMARY KEY (consecUsuarioPermiso),
  CONSTRAINT fkUsuario
  FOREIGN KEY (idUsuario) REFERENCES tabUsuario(idUsuario),
  CONSTRAINT fkPermiso
  FOREIGN KEY (consecPermiso) REFERENCES tabPermiso(consecPermiso)
);

CREATE TABLE tabCliente(
  codCli UUID NOT NULL,
  idCli VARCHAR  NOT NULL UNIQUE,
  tipoCli BOOLEAN NOT NULL DEFAULT TRUE, --TRUE="CLIENTE NATURAL" / FALSE="CLIENTE JURIDICO"
  nomCli VARCHAR,
  apeCli VARCHAR,
  nomRepLegal VARCHAR,
  nomEmpresa VARCHAR,
  telCli VARCHAR (10) NOT NULL,
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
  estado BOOLEAN NOT NULL DEFAULT TRUE, --TRUE="ACTIVO" - FALSE="INACTIVO"
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (codProv)
);
 
CREATE TABLE tabCategoria(
  consecCateg SMALLINT NOT NULL,
  nomCateg VARCHAR NOT NULL,
  estado BOOLEAN NOT NULL DEFAULT TRUE,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (consecCateg)
);

CREATE TABLE tabMarca(
  consecMarca SMALLINT NOT NULL,
  nomMarca VARCHAR NOT NULL,
  estado BOOLEAN NOT NULL DEFAULT TRUE,
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
  porcentaje NUMERIC(10,2), /*porcentaje de ganancia por articulo que pone el administrador*/
  iva NUMERIC (10,2) NOT NULL,
  valStock INTEGER,
  stockMin INTEGER NOT NULL,
  stockMax INTEGER NOT NULL,
  valReorden INTEGER NOT NULL,
  fecVence DATE,
  estado BOOLEAN NOT NULL DEFAULT TRUE,--TRUE="ACTIVO" - FALSE="INACTIVO"
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (eanArt),
  CONSTRAINT fkMarca
  FOREIGN KEY (consecMarca) REFERENCES tabMarca(consecMarca) ON DELETE CASCADE,
  CONSTRAINT fkCategoria
  FOREIGN KEY (consecCateg) REFERENCES tabCategoria(consecCateg) ON DELETE CASCADE
  
);

CREATE TABLE tabReciboMercancia(
  consecReciboMcia BIGINT NOT NULL,
  eanArt VARCHAR NOT NULL,
  cantArt INTEGER NOT NULL,
  valCompra NUMERIC(10),
  valTotal NUMERIC(10),
  idProv VARCHAR NOT NULL,
  observacion TEXT,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONE,
  userUpdate VARCHAR,
  PRIMARY KEY (consecReciboMcia),
  CONSTRAINT fkArticulo
  FOREIGN KEY (eanArt) REFERENCES tabArticulo(eanArt) ON DELETE CASCADE,
  CONSTRAINT fkProveedor
  FOREIGN KEY (idProv) REFERENCES tabProveedor(idProv) ON DELETE CASCADE
);

CREATE TABLE tabEncabezadoVenta(
  idEncVenta BIGINT NOT NULL,
  consecFactura BIGINT UNIQUE,
  consecCotizacion BIGINT UNIQUE,
  tipoFactura BOOLEAN NOT NULL, --TRUE='LEGAL' - FALSE='COTIZACION'
  estadoFactura BOOLEAN NOT NULL DEFAULT TRUE, --TRUE= "Generada" / FALSE="Anulada" 
  idCli VARCHAR NOT NULL,
  ciudad VARCHAR NOT NULL,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONe,
  userUpdate VARCHAR,
  PRIMARY KEY (idEncVenta)
);

CREATE TABLE tabDetalleVenta(
  consecDetVenta BIGINT NOT NULL,
  idEncVenta BIGINT NOT NULL,
  consecFactura BIGINT, 
  consecCotizacion BIGINT,
  eanArt VARCHAR NOT NULL,
  cantArt INTEGER NOT NULL,
  valUnit NUMERIC(10) NOT NULL,
  subTotal NUMERIC(10) NOT NULL,
  iva NUMERIC (10,2) NOT NULL DEFAULT 0.19, -- DEFAULT 0
  descuento NUMERIC (10) NOT NULL DEFAULT 0,
  totalPagar NUMERIC(10) NOT NULL,
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONE,
  userUpdate VARCHAR,
  PRIMARY KEY (consecDetVenta),
  CONSTRAINT fkidEncVenta
  FOREIGN KEY (idEncVenta) REFERENCES tabEncabezadoVenta(idEncVenta) ON DELETE CASCADE,
  CONSTRAINT fkConsecFactura
  FOREIGN KEY (consecFactura) REFERENCES tabEncabezadoVenta(consecFactura) ON DELETE CASCADE,
  CONSTRAINT fkArticulo
  FOREIGN KEY (eanArt) REFERENCES tabArticulo(eanArt) ON DELETE CASCADE,
  CONSTRAINT fkconsecCotizacion
  FOREIGN KEY (consecCotizacion) REFERENCES tabEncabezadoVenta(consecCotizacion) ON DELETE CASCADE
);

CREATE TABLE tabKardex(
  consecKardex BIGINT NOT NULL,
  consecReciboMcia BIGINT,
  consecDetVenta BIGINT,
  tipoMov BOOLEAN NOT NULL DEFAULT TRUE, --TRUE="ENTRADA" FALSE="SALIDA"
  eanArt VARCHAR NOT NULL,
  cantArt INTEGER NOT NULL,
  valProm NUMERIC(10), --Valor de compra promedio del mismo articulo a diferentes proveedores
  fecInsert TIMESTAMP WITHOUT TIME ZONE,
  userInsert VARCHAR,
  fecUpdate TIMESTAMP WITHOUT TIME ZONE,
  userUpdate VARCHAR,
  PRIMARY KEY (consecKardex),
  CONSTRAINT fkArticulo
  FOREIGN KEY (eanArt) REFERENCES tabArticulo(eanArt) ON DELETE CASCADE,
  CONSTRAINT fkReciboMercancia
  FOREIGN KEY (consecReciboMcia) REFERENCES tabReciboMercancia(consecReciboMcia) ON DELETE CASCADE,
  CONSTRAINT fkDetalleVenta
  FOREIGN KEY (consecDetVenta) REFERENCES tabDetalleVenta(consecDetVenta) ON DELETE CASCADE
);

CREATE TABLE tabRegBorrados(
  consecRegBor BIGINT NOT NULL,
  fecDelete TIMESTAMP WITHOUT TIME ZONE,
  userDelete VARCHAR NOT NULL,
  nomTabla VARCHAR NOT NULL,
  PRIMARY KEY (consecRegBor)
);