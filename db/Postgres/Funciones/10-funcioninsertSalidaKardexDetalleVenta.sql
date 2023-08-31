
/* Funcion para insertar un registro en la tabla kardex 'SALIDA',
cada vez que se realice una insercion en la tabDetalleVenta*/

--esto permite que se actualice el stock en la tabArticulo cada vez que se haga una venta.

CREATE OR REPLACE FUNCTION insertSalidaKardexDetalleVenta()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO tabKardex (
    fecMov, tipoMov, eanArt, nomArt, cantArt,valCompra, valTotal, valProm ) 
	VALUES (now(), 'SALIDA', NEW.eanArt, NEW.nomArt, NEW.cantArt, 0, 0, 0,  
    
    
  );

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER  insertSalidaKardexDetalleVenta
AFTER INSERT ON tabDetalleVenta
FOR EACH ROW
EXECUTE FUNCTION  insertSalidaKardexDetalleVenta();
