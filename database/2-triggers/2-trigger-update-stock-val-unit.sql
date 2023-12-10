/*esta función trigger es importante para:
cuando el usuario ingrese datos de recibo de mercancia o venta de mercancia,
debemos llamar esta función para que  actualice los datos 
valStock y valUnit en la tabArticulo*/

CREATE OR REPLACE FUNCTION actualizarStockValUnitEntradas()
RETURNS TRIGGER AS 

$$
DECLARE
  zValStock tabArticulo.valStock%type;
  zValUnit tabArticulo.valUnit%type;
  zPorcentaje tabArticulo.porcentaje%type;
  zValPromedio tabKardex.valprom%type;
  
BEGIN

select sum(valProm ) into zValPromedio from tabKardex WHERE eanArt = NEW.eanArt;
select Porcentaje into zPorcentaje from tabArticulo where eanArt = NEW.eanArt;
 
zValStock := (SELECT COALESCE(valStock, 0) + NEW.cantArt FROM tabArticulo WHERE eanArt = NEW.eanArt);
zValUnit :=zValPromedio* zPorcentaje ;
    

UPDATE tabArticulo SET valStock = zValStock, valUnit = zValUnit WHERE eanArt = NEW.eanArt;

RETURN NEW;
END;
$$ 
LANGUAGE plpgsql;

--Creamos el trigger 
CREATE TRIGGER triggerActualizarStockValUnitEntradas
AFTER INSERT ON tabReciboMercancia
FOR EACH ROW
EXECUTE FUNCTION actualizarStockValUnitEntradas();

-------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION actualizarStockValUnitSalidas()
RETURNS TRIGGER AS 

$$
DECLARE
  zValStock tabArticulo.valStock%type;
  zValUnit tabArticulo.valUnit%type;
  
BEGIN

      zValStock := (SELECT COALESCE(valStock, 0) - NEW.cantArt FROM tabArticulo WHERE eanArt = NEW.eanArt);
      zValUnit := (SELECT valUnit FROM tabArticulo WHERE eanArt = NEW.eanArt);
  

  UPDATE tabArticulo SET valStock = zValStock, valUnit = zValUnit WHERE eanArt = NEW.eanArt;

RETURN NEW;
END;
$$ 
LANGUAGE plpgsql;

--creamos el trigger
CREATE TRIGGER triggerActualizarStockValUnitSalidas
AFTER INSERT ON tabDetalleVenta
FOR EACH ROW
EXECUTE FUNCTION actualizarStockValUnitSalidas()