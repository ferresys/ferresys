/* funcion para insertar los datos y actualizarlos si ya existen en la tab_artxprov*/
CREATE OR REPLACE FUNCTION insert_tab_artxprov()
RETURNS TRIGGER AS 

$$
BEGIN
  -- Verificar si ya existe una fila con los mismos valores de consec_prov y ean_art en tab_artxprov
  IF EXISTS (SELECT 1 FROM tab_artxprov WHERE consec_prov = NEW.consec_prov AND ean_art = NEW.ean_art) THEN
    -- Si existe, realizar una actualización en lugar de una inserción
    UPDATE tab_artxprov 
    SET nom_prov = (SELECT nom_prov FROM tab_proveedor WHERE consec_prov = NEW.consec_prov), 
        nom_art = (SELECT nom_art FROM tab_articulo WHERE ean_art = NEW.ean_art), 
        val_compra = NEW.val_compra
    WHERE consec_prov = NEW.consec_prov AND ean_art = NEW.ean_art;
  ELSE
    -- Si no existe, insertar una nueva fila
    INSERT INTO tab_artxprov (consec_prov, nom_prov, ean_art, nom_art, val_compra)
    VALUES (NEW.consec_prov, (SELECT nom_prov FROM tab_proveedor WHERE consec_prov = NEW.consec_prov), 
            NEW.ean_art, (SELECT nom_art FROM tab_articulo WHERE ean_art = NEW.ean_art), 
            NEW.val_compra);
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_insert_tab_artxprov
AFTER INSERT ON tab_kardex
FOR EACH ROW
EXECUTE FUNCTION insert_tab_artxprov();

SELECT * FROM tab_artxprov;