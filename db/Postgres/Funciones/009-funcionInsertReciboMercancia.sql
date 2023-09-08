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
   CONSTRAINT fkArticulo
  FOREIGN KEY (eanArt) REFERENCES tabArticulo(eanArt),
  CONSTRAINT fkProveedor
  FOREIGN KEY (idProv) REFERENCES tabProveedor(idProv),
  CONSTRAINT fkMarca
  FOREIGN KEY (consecMarca) REFERENCES tabMarca(consecMarca)
);


CREATE OR REPLACE FUNCTION insertReciboMercancia(
    zEanArt tabArticulo.eanArt%type,
    zCantArt tabArticulo.cantArt%type,
    zValCompra tabReciboMercancia.valCompra%type,
    zValTotal tabReciboMercancia.valTotal%type,
    zIdProv tabProveedor.idProv%type,
    zConsecMarca tabMarca.consecMarca%type
) RETURNS void AS 
$$
DECLARE

    zMarca tabMarca.consecMarca%type;
    zCategoria tabCategoria.consecCateg%type;

BEGIN
   
        SELECT consecMarca INTO zMarca FROM tabMarca WHERE consecMarca = zConsecMarca;
        SELECT consecCateg INTO zCategoria FROM tabCategoria WHERE consecCateg = zConsecCateg;

        -- Insertar el nuevo registro de recibo de mercancia.
        INSERT INTO tabArticulo(eanArt, nomArt, consecMarca, consecCateg, descArt, porcentaje, iva, stockMin, stockMax, valReorden, fecVence)
        VALUES (zEanArt, zNomArt, zMarca, zCategoria, zDescArt, zPorcentaje, zIva, zStockMin, zStockMax, zValReorden, zFecVence);

        RAISE NOTICE 'Artículo registrado con éxito';
    END IF;
END;
$$ 
LANGUAGE plpgsql;