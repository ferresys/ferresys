--modificar basado en el nuevo der y diagrama de clases
CREATE TABLE tab_usuario(
  consec_usu BIGINT DEFAULT NEXTVAL('consec_usu'),
  id_usu iNTEGER NOT NULL,
  fec_reg TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  nom_usu VARCHAR NOT NULL,
  ape_usu VARCHAR NOT NULL,
  tel_usu VARCHAR NOT NULL,
  email_usu VARCHAR NOT NULL,
  usuario VARCHAR NOT NULL,
  password VARCHAR NOT NULL,
  estado BOOLEAN NOT NULL DEFAULT true,
  estado_texto TEXT DEFAULT estado_texto(true),
  --se creo una funcion "estado_texto" para que true(activo) y false (inactivo)
  fec_insert TIMESTAMP WITHOUT TIME ZONE,
  user_insert VARCHAR,
  fec_update TIMESTAMP WITHOUT TIME ZONe,
  user_update VARCHAR,
  PRIMARY KEY (consec_usu)
);

CREATE TABLE tab_cliente(
  consec_cli BIGINT NOT NULL DEFAULT NEXTVAL('consec_cli'),
  fec_reg TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  tipo_cli VARCHAR NOT NULL,
  id_cli INTEGER NOT NULL,
  nit_cli VARCHAR NOT NULL,
  nom_cli VARCHAR NOT NULL,
  ape_cli VARCHAR NOT NULL,
  nom_empr VARCHAR NOT NULL,
  tel_cli VARCHAR NOT NULL,
  email_cli VARCHAR NOT NULL,
  dir_cli VARCHAR NOT NULL,
  fec_insert TIMESTAMP WITHOUT TIME ZONE,
  user_insert VARCHAR,
  fec_update TIMESTAMP WITHOUT TIME ZONe,
  user_update VARCHAR,
  PRIMARY KEY (consec_cli)
);

CREATE TABLE tab_proveedor(
  consec_prov BIGINT NOT NULL DEFAULT NEXTVAL('consec_prov'),
  nit_prov VARCHAR NOT NULL,
  fec_reg TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  nom_prov VARCHAR NOT NULL,
  tel_prov VARCHAR NOT NULL,
  email_prov VARCHAR NOT NULL,
  dir_prov VARCHAR NOT NULL,
  estado BOOLEAN NOT NULL DEFAULT true,
  estado_texto TEXT DEFAULT estado_texto(true),
  fec_insert TIMESTAMP WITHOUT TIME ZONE,
  user_insert VARCHAR,
  fec_update TIMESTAMP WITHOUT TIME ZONe,
  user_update VARCHAR,
  PRIMARY KEY (consec_prov)
);

CREATE TABLE tab_categoria(
  consec_categ BIGINT NOT NULL DEFAULT NEXTVAL('consec_categ'),
  nom_categ VARCHAR NOT NULL,
  estado BOOLEAN NOT NULL DEFAULT true,
  estado_texto TEXT DEFAULT estado_texto(true),
  fec_insert TIMESTAMP WITHOUT TIME ZONE,
  user_insert VARCHAR,
  fec_update TIMESTAMP WITHOUT TIME ZONe,
  user_update VARCHAR,
  PRIMARY KEY (consec_categ)
);

CREATE TABLE tab_marca(
  consec_marca BIGINT NOT NULL DEFAULT NEXTVAL('consec_marca'),
  nom_marca VARCHAR NOT NULL,
  estado BOOLEAN NOT NULL DEFAULT true,
  estado_texto TEXT DEFAULT estado_texto(true),
  fec_insert TIMESTAMP WITHOUT TIME ZONE,
  user_insert VARCHAR,
  fec_update TIMESTAMP WITHOUT TIME ZONe,
  user_update VARCHAR,
  PRIMARY KEY (consec_marca)
);

CREATE TABLE tab_articulo(
  consec_art BIGINT NOT NULL DEFAULT NEXTVAL('consec_art'),
  ean_art VARCHAR NOT NULL,
  fec_reg TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  nom_art VARCHAR NOT NULL,
  marca_art VARCHAR NOT NULL,
  categ_art VARCHAR NOT NULL,
  descrip_art TEXT,
  unid_med VARCHAR NOT NULL,
  val_unit INTEGER NOT NULL,
  iva INTEGER NOT NULL,
  val_stock INTEGER NOT NULL,
  stock_min INTEGER NOT NULL,
  stock_max INTEGER NOT NULL,
  val_reorden INTEGER NOT NULL,
  fec_vence DATE,
  estado BOOLEAN NOT NULL DEFAULT true,
  estado_texto TEXT DEFAULT estado_texto(true),
  fec_insert TIMESTAMP WITHOUT TIME ZONE,
  user_insert VARCHAR,
  fec_update TIMESTAMP WITHOUT TIME ZONe,
  user_update VARCHAR,
  consec_marca BIGINT NOT NULL,
  consec_categ BIGINT NOT NULL,
  PRIMARY KEY (ean_art),
  FOREIGN KEY (consec_marca) REFERENCES tab_marca(consec_marca),
  FOREIGN KEY (consec_categ) REFERENCES tab_categoria(consec_categ)
);

CREATE TABLE tab_artxprov(
  consec_artxprov BIGINT NOT NULL DEFAULT NEXTVAL('consec_artxprov'),
  nom_prov VARCHAR NOT NULL,
  nom_art VARCHAR NOT NULL,
  val_compra NUMERIC(10, 2) NOT NULL,
  val_stock INTEGER NOT NULL,
  fec_insert TIMESTAMP WITHOUT TIME ZONE,
  user_insert VARCHAR,
  fec_update TIMESTAMP WITHOUT TIME ZONe,
  user_update VARCHAR,
  consec_prov BIGINT NOT NULL,
  ean_art VARCHAR NOT NULL,
  PRIMARY KEY (consec_artxprov),
  FOREIGN KEY (consec_prov) REFERENCES tab_proveedor(consec_prov),
  FOREIGN KEY (ean_art) REFERENCES tab_articulo(ean_art)
);

CREATE TABLE tab_kardex(
  consec_kardex BIGINT NOT NULL DEFAULT NEXTVAL('consec_kardex'),
  fec_mov TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  tipo_mov VARCHAR NOT NULL,
  nom_art VARCHAR NOT NULL,
  cant_art INTEGER NOT NULL,
  val_compra NUMERIC(10, 2) NOT NULL,
  val_total NUMERIC(10, 2) NOT NULL,
  val_prom NUMERIC(10, 2) NOT NULL,
  observacion TEXT,
  nom_prov VARCHAR NOT NULL,
  fec_insert TIMESTAMP WITHOUT TIME ZONE,
  user_insert VARCHAR,
  fec_update TIMESTAMP WITHOUT TIME ZONe,
  user_update VARCHAR,
  ean_art VARCHAR NOT NULL,
  consec_prov BIGINT NOT NULL,
  PRIMARY KEY (consec_kardex),
  FOREIGN KEY (ean_art) REFERENCES tab_articulo(ean_art),
  FOREIGN KEY (consec_prov) REFERENCES tab_proveedor(consec_prov)
);

CREATE TABLE tab_encabezado_venta(
  consec_venta BIGINT NOT NULL DEFAULT NEXTVAL('consec_venta'),
  fec_venta TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  id_cli INTEGER NOT NULL,
  val_pagar NUMERIC(10, 2) NOT NULL,
  estado BOOLEAN NOT NULL DEFAULT true,
  estado_texto TEXT DEFAULT estado_texto(true),
  fec_insert TIMESTAMP WITHOUT TIME ZONE,
  user_insert VARCHAR,
  fec_update TIMESTAMP WITHOUT TIME ZONe,
  user_update VARCHAR,
  consec_cli BIGINT NOT NULL,
  PRIMARY KEY (consec_venta),
  FOREIGN KEY (consec_cli) REFERENCES tab_cliente(consec_cli)
);

CREATE TABLE tab_detalle_venta(
  consec_det_venta BIGINT NOT NULL DEFAULT NEXTVAL('consec_det_venta'),
  nom_art VARCHAR NOT NULL,
  cant_art INTEGER NOT NULL,
  val_unit INTEGER NOT NULL,
  Subtotal NUMERIC(10, 2) NOT NULL,
  Descuento NUMERIC(10, 2) NOT NULL,
  val_iva NUMERIC(10, 2) NOT NULL,
  Total_Pagar NUMERIC(10, 2) NOT NULL,
  estado BOOLEAN NOT NULL DEFAULT true,
  estado_texto TEXT DEFAULT estado_texto(true),
  fec_insert TIMESTAMP WITHOUT TIME ZONE,
  user_insert VARCHAR,
  fec_update TIMESTAMP WITHOUT TIME ZONe,
  user_update VARCHAR,
  consec_venta BIGINT NOT NULL,
  ean_art VARCHAR NOT NULL,
  PRIMARY KEY (consec_det_venta),
  FOREIGN KEY (consec_venta) REFERENCES tab_encabezado_venta(consec_venta),
  FOREIGN KEY (ean_art) REFERENCES tab_articulo(ean_art)
);

CREATE TABLE reg_borrados(
  consec_reg BIGINT NOT NULL DEFAULT NEXTVAL('consec_reg'),
  fec_delete TIMESTAMP WITHOUT TIME ZONe,
  user_delete VARCHAR NOT NULL,
  nom_tabla VARCHAR NOT NULL,
  PRIMARY KEY (consec_reg)
);
