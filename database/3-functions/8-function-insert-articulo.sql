
--SELECT insertArticulo('2','Pulidora','1','1','Pulidora amarilla',1.20, 1.19, 10, 500, 50, NULL);
select * from tabArticulo

-- Función para insertar un nuevo Artículo

CREATE OR REPLACE FUNCTION insertArticulo(
    zEanArt tabArticulo.eanArt%type,
    zNomArt tabArticulo.nomArt%type,
    zConsecMarca tabMarca.consecMarca%type,
    zConsecCateg tabCategoria.consecCateg%type,
    zDescArt tabArticulo.descArt%type,
    zPorcentaje tabArticulo.Porcentaje%type,
    zIva tabArticulo.iva%type,
    zStockMin tabArticulo.stockMin%type,
    zStockMax tabArticulo.stockMax%type,
    zValReorden tabArticulo.valReorden%type,
    zFecVence tabArticulo.fecVence%type
) RETURNS void AS 
$$
DECLARE

    articuloExistente BOOLEAN;
    zMarca tabMarca.consecMarca%type;
    zCategoria tabCategoria.consecCateg%type;

BEGIN
    -- Verificamos si ya existe un registro con el mismo eanArt
    SELECT EXISTS (SELECT 1 FROM tabArticulo WHERE eanArt = zEanArt) INTO articuloExistente;

    IF articuloExistente THEN
        RAISE EXCEPTION 'Ya existe un artículo con el mismo EAN: %', zEanArt;

    ELSE
        -- Obtener los valores de marca y categoría
        SELECT consecMarca INTO zMarca FROM tabMarca WHERE consecMarca = zConsecMarca;
        SELECT consecCateg INTO zCategoria FROM tabCategoria WHERE consecCateg = zConsecCateg;

        -- Insertar el nuevo artículo si no existe
        INSERT INTO tabArticulo(eanArt, nomArt, consecMarca, consecCateg, descArt, porcentaje, iva, stockMin, stockMax, valReorden, fecVence)
        VALUES (zEanArt, zNomArt, zMarca, zCategoria, zDescArt, zPorcentaje, zIva, zStockMin, zStockMax, zValReorden, zFecVence);

        RAISE NOTICE 'Artículo registrado con éxito';
    END IF;
END;
$$ 
LANGUAGE plpgsql;




