
--función InsertMarca para insertar una nueva marca en la tabMarca.

--SELECT insertMarca('MAKITA');
--select * from tabMarca;
CREATE OR REPLACE FUNCTION insertMarca(
    zNomMarca tabMarca.nomMarca%type
) RETURNS void AS 

$$
DECLARE
    marcaExistente BOOLEAN;
BEGIN
    -- Verificar si ya existe un registro con el mismo nomMarca
    SELECT EXISTS (SELECT 1 FROM tabMarca WHERE nomMarca = zNomMarca) INTO marcaExistente;

    IF marcaExistente THEN
    
        RAISE EXCEPTION 'Ya existe una marca con el mismo nombre: %', zNomMarca;
    ELSE

        -- Insertar nueva marca si no existe
        INSERT INTO tabMarca(nomMarca)
        VALUES (zNomMarca);
        RAISE NOTICE 'Marca registrada con éxito';
    END IF;
END;
$$ 
LANGUAGE plpgsql;
