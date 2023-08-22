/* funcion para insertar los datos y verificar si ya existen en la tabProveedorArticulo*/


CREATE OR REPLACE FUNCTION inserttabProveedorArticulo()
RETURNS TRIGGER AS 

$$
BEGIN
  -- Verificar si ya existe una fila con los mismos valores de nitProv y eanArt en tabProveedorArticulo
  IF EXISTS (SELECT 1 FROM tabProveedorArticulo WHERE nitProv = NEW.nitProv AND eanArt = NEW.eanArt) THEN
   
     UPDATE tabProveedorArticulo
    SET nitProv = NEW.nitProv, eanArt= NEW.eanArt
    WHERE  nitProv=NEW.nitProv and eanArt= NEW.eanArt;
	

  ELSE
    -- Si no existe, insertar una nueva fila
    INSERT INTO tabProveedorArticulo (nitProv, eanArt)
    VALUES (NEW.nitProv,  NEW.eanArt);
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER triggerInserttabProveedorArticulo
AFTER INSERT ON tabKardex
FOR EACH ROW
EXECUTE FUNCTION inserttabProveedorArticulo();

--SELECT * FROM tabProveedorArticulo;