
CREATE OR REPLACE FUNCTION generarConsecutivotabCliente()
RETURNS TRIGGER AS $$
BEGIN
    NEW.consecCli := (SELECT COALESCE(MAX(consecCli), 0) + 1 FROM tabCliente);
    RETURN NEW;
END;
$$ LANGUAGE PLpgSQL;


------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION generarConsecutivotabCategoria()
RETURNS TRIGGER AS $$
BEGIN
    NEW.consecCateg := (SELECT COALESCE(MAX(consecCateg), 0) + 1 FROM tabCategoria);
    RETURN NEW;
END;
$$ LANGUAGE PLpgSQL;

----------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION generarConsecutivotabMarca()
RETURNS TRIGGER AS $$
BEGIN
    NEW.consecMarca := (SELECT COALESCE(MAX(consecMarca), 0) + 1 FROM tabMarca);
    RETURN NEW;
END;
$$ LANGUAGE PLpgSQL;

-----------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION generarConsecutivotabProveedorMarca()
RETURNS TRIGGER AS $$
BEGIN
    NEW.consecProvMarca := (SELECT COALESCE(MAX(consecProvMarca), 0) + 1 FROM tabProveedorMarca);
    RETURN NEW;
END;
$$ LANGUAGE PLpgSQL;

------------------------------------------------------------------------------------------------------------


CREATE OR REPLACE FUNCTION generarConsecutivotabKardex()
RETURNS TRIGGER AS $$
BEGIN
    NEW.consecKardex := (SELECT COALESCE(MAX(consecKardex), 0) + 1 FROM tabKardex);
    RETURN NEW;
END;
$$ LANGUAGE PLpgSQL;

------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION generarConsecutivotabProveedorArticulo()
RETURNS TRIGGER AS $$
BEGIN
    NEW.consecProvArt := (SELECT COALESCE(MAX(consecProvArt), 0) + 1 FROM tabProveedorArticulo);
    RETURN NEW;
END;
$$ LANGUAGE PLpgSQL;

------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION generarConsecutivotabEncabezadoVenta()
RETURNS TRIGGER AS $$
BEGIN
    NEW.consecVenta := (SELECT COALESCE(MAX(consecVenta), 0) + 1 FROM tabEncabezadoVenta);
    RETURN NEW;
END;
$$ LANGUAGE PLpgSQL;

------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION generarConsecutivotabDetalleVenta()
RETURNS TRIGGER AS $$
BEGIN
    NEW.consecDetVenta := (SELECT COALESCE(MAX(consecDetVenta), 0) + 1 FROM tabDetalleVenta);
    RETURN NEW;
END;
$$ LANGUAGE PLpgSQL;

------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION generarConsecutivotabRegBorrados()
RETURNS TRIGGER AS $$
BEGIN
    NEW.consecReg := (SELECT COALESCE(MAX(consecReg), 0) + 1 FROM tabRegBorrados);
    RETURN NEW;
END;
$$ LANGUAGE PLpgSQL;

------------------------------------------------------------------------------------------------------------

-- Crea el trigger

CREATE TRIGGER autoincrementCliente
BEFORE INSERT ON tabCliente
FOR EACH ROW
EXECUTE FUNCTION generarConsecutivotabCliente();


CREATE TRIGGER autoincrementCategoria
BEFORE INSERT ON tabCategoria
FOR EACH ROW
EXECUTE FUNCTION generarConsecutivotabCategoria();

CREATE TRIGGER autoincrementMarca
BEFORE INSERT ON tabMarca
FOR EACH ROW
EXECUTE FUNCTION generarConsecutivotabMarca();

CREATE TRIGGER autoincrementProveedorMarca
BEFORE INSERT ON tabProveedorMarca
FOR EACH ROW
EXECUTE FUNCTION generarConsecutivotabProveedorMarca();

CREATE TRIGGER autoincrementKardex
BEFORE INSERT ON tabKardex
FOR EACH ROW
EXECUTE FUNCTION generarConsecutivotabKardex();

CREATE TRIGGER autoincrementProveedorArticulo
BEFORE INSERT ON tabProveedorArticulo
FOR EACH ROW
EXECUTE FUNCTION generarConsecutivotabProveedorArticulo();

CREATE TRIGGER autoincrementEncabezadoventa
BEFORE INSERT ON tabEncabezadoVenta
FOR EACH ROW
EXECUTE FUNCTION generarConsecutivotabEncabezadoVenta();

CREATE TRIGGER autoincrementDetalleVenta
BEFORE INSERT ON tabDetalleVenta
FOR EACH ROW
EXECUTE FUNCTION generarConsecutivotabDetalleVenta();

CREATE TRIGGER autoincrementRegBorrados
BEFORE INSERT ON tabRegBorrados
FOR EACH ROW
EXECUTE FUNCTION generarConsecutivotabRegBorrados();