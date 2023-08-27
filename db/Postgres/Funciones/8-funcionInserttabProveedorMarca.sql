
--creamos la función para insertar en la tabProveedorMarca despues de verificar si existe o no.

CREATE OR REPLACE FUNCTION inserttabProveedorMarca()
RETURNS TRIGGER AS 
$$
BEGIN
  -- Verificar si ya existe una fila con los mismos valores de nitProv y consecMarca en tabProveedorMarca
  IF EXISTS (SELECT 1 FROM tabProveedorMarca WHERE nitProv = NEW.nitProv and consecMarca= NEW.consecMarca ) THEN
   
    -- Si existe, se actualiza solo la fila correspondiente
    UPDATE tabProveedorMarca
    SET nitProv = NEW.nitProv, consecMarca= NEW.consecMarca
    WHERE  nitProv=NEW.nitProv and consecMarca=NEW.consecMarca;
	
  
    
  ELSE
    -- Si no existe, insertar una nueva fila en tabProveedorMarca
    INSERT INTO tabProveedorMarca (nitProv, consecMarca)
    VALUES (NEW.nitProv, NEW.consecMarca);
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para insertar en tabProveedorMarca despues de insertar un registro en tabKardex.
CREATE TRIGGER triggerInserttabProveedorMarca
AFTER INSERT ON tabKardex 
FOR EACH ROW
EXECUTE FUNCTION inserttabProveedorMarca();

