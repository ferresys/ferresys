-- Función para insertar datos en la tabla "tabCategoria"

--select insertCategoria('Herramientas');


CREATE OR REPLACE FUNCTION insertCategoria(
    zNomCateg tabCategoria.nomCateg%type
) RETURNS void AS 
$$
DECLARE
    categoriaExistente BOOLEAN;
BEGIN
    -- Verificamos si ya existe un registro con el mismo nomCateg
    SELECT EXISTS (SELECT 1 FROM tabCategoria WHERE nomCateg = zNomCateg) INTO categoriaExistente;

    IF categoriaExistente THEN
        RAISE EXCEPTION 'Ya existe una categoría con el mismo nombre: %', zNomCateg;
    ELSE
        -- Insertamos una nueva categoría si no existe

        INSERT INTO tabCategoria(nomCateg)
        VALUES (zNomCateg);

        RAISE NOTICE 'Categoría registrada con éxito';
    END IF;
END;
$$ 
LANGUAGE plpgsql;
