
CREATE OR REPLACE FUNCTION ConsecutivotabPermiso()
RETURNS TRIGGER AS 
$$
BEGIN
    NEW.consecPermiso := (SELECT COALESCE(MAX(consecPermiso), 0) + 1 FROM tabPermiso);
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;

----------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION ConsecutivotabUsuarioPermiso()
RETURNS TRIGGER AS 
$$
BEGIN
    NEW.consecUsuarioPermiso := (SELECT COALESCE(MAX(consecUsuarioPermiso), 0) + 1 FROM tabUsuarioPermiso);
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;

----------------------------------------------------------------------------------------------------------


CREATE OR REPLACE FUNCTION ConsecutivotabCategoria()
RETURNS TRIGGER AS 
$$
BEGIN
    NEW.consecCateg := (SELECT COALESCE(MAX(consecCateg), 0) + 1 FROM tabCategoria);
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;

----------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION ConsecutivotabMarca()
RETURNS TRIGGER AS 
$$
BEGIN
    NEW.consecMarca := (SELECT COALESCE(MAX(consecMarca), 0) + 1 FROM tabMarca);
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;

-----------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION ConsecutivotabKardex()
RETURNS TRIGGER AS 
$$
BEGIN
    NEW.consecKardex := (SELECT COALESCE(MAX(consecKardex), 0) + 1 FROM tabKardex);
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;

------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION ConsecutivotabReciboMercancia()
RETURNS TRIGGER AS 
$$
BEGIN
    NEW.consecReciboMcia := (SELECT COALESCE(MAX(consecReciboMcia), 0) + 1 FROM tabReciboMercancia);
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;
------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION ConsecutivotabEncabezadoVenta()
RETURNS TRIGGER AS 
$$
BEGIN
    NEW.idEncVenta := (SELECT COALESCE(MAX(idEncVenta), 0) + 1 FROM tabEncabezadoVenta);
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;

------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION ConsecutivotabEncabezadoVenta1()
RETURNS TRIGGER AS 
$$
BEGIN
    IF NEW.tipoFactura = TRUE THEN
    NEW.consecFactura := (SELECT COALESCE(MAX(consecFactura), 2221) + 1 FROM tabEncabezadoVenta);
    END IF;
	RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;

------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION ConsecutivotabEncabezadoVenta2()
RETURNS TRIGGER AS 
$$
BEGIN
    IF NEW.tipoFactura = FALSE THEN
    NEW.consecCotizacion := (SELECT COALESCE(MAX(consecCotizacion), 111) + 1 FROM tabEncabezadoVenta);
    END IF;
	RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;

------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION ConsecutivotabDetalleVenta()
RETURNS TRIGGER AS 
$$
BEGIN
    NEW.consecDetVenta := (SELECT COALESCE(MAX(consecDetVenta), 0) + 1 FROM tabDetalleVenta);
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;

------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION ConsecutivotabRegBorrados()
RETURNS TRIGGER AS 
$$
BEGIN
    NEW.consecRegBor := (SELECT COALESCE(MAX(consecRegBor), 0) + 1 FROM tabRegBorrados);
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;

------------------------------------------------------------------------------------------------------------


-- Crea el trigger

CREATE TRIGGER autoincrementtabPermiso
BEFORE INSERT ON tabPermiso
FOR EACH ROW
EXECUTE FUNCTION ConsecutivotabPermiso();

CREATE TRIGGER autoincrementtabUsuarioPermiso
BEFORE INSERT ON tabUsuarioPermiso
FOR EACH ROW
EXECUTE FUNCTION ConsecutivotabUsuarioPermiso();

CREATE TRIGGER autoincrementtabCategoria
BEFORE INSERT ON tabCategoria
FOR EACH ROW
EXECUTE FUNCTION ConsecutivotabCategoria();

CREATE TRIGGER autoincrementtabMarca
BEFORE INSERT ON tabMarca
FOR EACH ROW
EXECUTE FUNCTION ConsecutivotabMarca();

CREATE TRIGGER autoincrementtabKardex
BEFORE INSERT ON tabKardex
FOR EACH ROW
EXECUTE FUNCTION ConsecutivotabKardex();

CREATE TRIGGER autoincrementtabReciboMercancia
BEFORE INSERT ON tabReciboMercancia
FOR EACH ROW
EXECUTE FUNCTION ConsecutivotabReciboMercancia();

CREATE TRIGGER autoincrementtabEncabezadoventa
BEFORE INSERT ON tabEncabezadoVenta
FOR EACH ROW
EXECUTE FUNCTION ConsecutivotabEncabezadoVenta();

CREATE TRIGGER autoincrementtabEncabezadoventa1
BEFORE INSERT ON tabEncabezadoVenta
FOR EACH ROW
EXECUTE FUNCTION ConsecutivotabEncabezadoVenta1();

CREATE TRIGGER autoincrementtabEncabezadoventa2
BEFORE INSERT ON tabEncabezadoVenta
FOR EACH ROW
EXECUTE FUNCTION ConsecutivotabEncabezadoVenta2();

CREATE TRIGGER autoincrementtabDetalleVenta
BEFORE INSERT ON tabDetalleVenta
FOR EACH ROW
EXECUTE FUNCTION ConsecutivotabDetalleVenta();

CREATE TRIGGER autoincrementtabRegBorrados
BEFORE INSERT ON tabRegBorrados
FOR EACH ROW
EXECUTE FUNCTION ConsecutivotabRegBorrados();