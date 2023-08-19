/* funcion para insertar los datos y actualizarlos si ya existen en la tabProveedorArticulo*/
CREATE OR REPLACE FUNCTION inserttabProveedorArticulo()
RETURNS TRIGGER AS 

$$
BEGIN
  -- Verificar si ya existe una fila con los mismos valores de nitProv y eanArt en tabProveedorArticulo
  IF EXISTS (SELECT 1 FROM tabProveedorArticulo WHERE nitProv = NEW.nitProv AND eanArt = NEW.eanArt) THEN
    -- Si existe, realizar una actualización en lugar de una inserción
    UPDATE tabProveedorArticulo
    SET nomProv = (SELECT nomProv FROM tab_proveedor WHERE nitProv = NEW.nitProv), 
        nomArt = (SELECT nomArt FROM tabArticulo WHERE eanArt = NEW.eanArt), 
        val_compra = NEW.val_compra
    WHERE nitProv = NEW.nitProv AND eanArt = NEW.eanArt;
  ELSE
    -- Si no existe, insertar una nueva fila
    INSERT INTO taProveedorArticulo (nitProv, nomProv, eanArt, nomArt, valCompra)
    VALUES (NEW.nitProv, (SELECT nomProv FROM tabProveedor WHERE nitProv = NEW.nitProv), 
            NEW.eanArt, (SELECT nomArt FROM tabArticulo WHERE eanArt = NEW.eanArt), 
            NEW.valCompra);
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER triggerInserttabProveedorArticulo
AFTER INSERT ON tabKardex
FOR EACH ROW
EXECUTE FUNCTION inserttabProveedorArticulo();

--SELECT * FROM tabProveedorArticulo;

