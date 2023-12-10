-- funcion  para actualizar el estado de las tablas correspondientes


/*----------------------------------------------
	Actualizar estado tabProveedor y tabArticulo
------------------------------------------------*/

CREATE OR REPLACE FUNCTION actualizarEstadoArtProv(
    zNomTabla VARCHAR,
    zCampoClavePrimaria VARCHAR,
    zValClavePrimaria VARCHAR,
    zNuevoEstado BOOLEAN
)
RETURNS VOID AS $$
BEGIN
    EXECUTE format('UPDATE %I SET estado = $1 WHERE %I = $2', zNomTabla, zCampoClavePrimaria)
    USING zNuevoEstado, zValClavePrimaria;
END;
$$ 
LANGUAGE plpgsql;

/*----------------------------------------------
	Actualizar estado tabMarca y tabCategoria
------------------------------------------------*/

CREATE OR REPLACE FUNCTION actualizarEstadoMarcaCateg(
    zNomTabla VARCHAR,
    zCampoClavePrimaria VARCHAR,
    zValClavePrimaria SMALLINT,
    zNuevoEstado BOOLEAN
)
RETURNS VOID AS $$
BEGIN
    EXECUTE format('UPDATE %I SET estado = $1 WHERE %I = $2', zNomTabla, zCampoClavePrimaria)
    USING zNuevoEstado, zValClavePrimaria;
END;
$$ 
LANGUAGE plpgsql;








