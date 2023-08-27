
--Habilitar la extension uuid 
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

--creamos la función para generar un UUID por registro

CREATE OR REPLACE FUNCTION generarUuidtabAdministrador()
RETURNS TRIGGER AS $$
BEGIN
    NEW.idAdmin := uuid_generate_v4();
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;

-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION generarUuidtabCliente()
RETURNS TRIGGER AS $$
BEGIN
    NEW.idCli := uuid_generate_v4();
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;

-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION generarUuidtabClienteNatural()
RETURNS TRIGGER AS $$
BEGIN
    NEW.idCliNat := uuid_generate_v4();
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;

-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION generarUuidtabClienteJuridico()
RETURNS TRIGGER AS $$
BEGIN
    NEW.idCliJur := uuid_generate_v4();
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;

-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION generarUuidtabProveedor()
RETURNS TRIGGER AS $$
BEGIN
    NEW.idProv := uuid_generate_v4();
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;

-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION generarUuidtabCategoria()
RETURNS TRIGGER AS $$
BEGIN
    NEW.idCateg := uuid_generate_v4();
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;

-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION generarUuidtabMarca()
RETURNS TRIGGER AS $$
BEGIN
    NEW.idMarca := uuid_generate_v4();
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;

-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION generarUuidtabProveedorMarca()
RETURNS TRIGGER AS $$
BEGIN
    NEW.idprovMarca := uuid_generate_v4();
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;

-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION generarUuidtabArticulo()
RETURNS TRIGGER AS $$
BEGIN
    NEW.idArt := uuid_generate_v4();
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;

-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION generarUuidtabKardex()
RETURNS TRIGGER AS $$
BEGIN
    NEW.idKardex := uuid_generate_v4();
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;

-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION generarUuidtabProveedorArticulo()
RETURNS TRIGGER AS $$
BEGIN
    NEW.idProvArt := uuid_generate_v4();
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;

-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION generarUuidtabEncabezadoVenta()
RETURNS TRIGGER AS $$
BEGIN
    NEW.idVenta := uuid_generate_v4();
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;

-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION generarUuidtabDetalleVenta()
RETURNS TRIGGER AS $$
BEGIN
    NEW.idDetVenta := uuid_generate_v4();
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;

-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION generarUuidtabRegborrados()
RETURNS TRIGGER AS $$
BEGIN
    NEW.idReg := uuid_generate_v4();
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;

-----------------------------------------------------------------------

-- Crea el trigger para las tablas 

CREATE TRIGGER UuidAdministrador
BEFORE INSERT ON tabAdministrador
FOR EACH ROW
EXECUTE FUNCTION generarUuidtabAdministrador();

CREATE TRIGGER UuidCliente
BEFORE INSERT ON tabCliente
FOR EACH ROW
EXECUTE FUNCTION generarUuidtabCliente();

CREATE TRIGGER UuidClienteNatural
BEFORE INSERT ON tabClienteNatural
FOR EACH ROW
EXECUTE FUNCTION generarUuidtabClienteNatural();

CREATE TRIGGER UuidClienteJuridico
BEFORE INSERT ON tabClienteJuridico
FOR EACH ROW
EXECUTE FUNCTION generarUuidtabClienteJuridico();

CREATE TRIGGER UuidProveedor
BEFORE INSERT ON tabProveedor
FOR EACH ROW
EXECUTE FUNCTION generarUuidtabProveedor();

CREATE TRIGGER UuidCategoria
BEFORE INSERT ON tabCategoria
FOR EACH ROW
EXECUTE FUNCTION generarUuidtabCategoria();

CREATE TRIGGER UuidMarca
BEFORE INSERT ON tabMarca
FOR EACH ROW
EXECUTE FUNCTION generarUuidtabMarca();

CREATE TRIGGER UuidProveedorMarca
BEFORE INSERT ON tabProveedorMarca
FOR EACH ROW
EXECUTE FUNCTION generarUuidtabProveedorMarca();

CREATE TRIGGER UuidArticulo
BEFORE INSERT ON tabArticulo
FOR EACH ROW
EXECUTE FUNCTION generarUuidtabArticulo();

CREATE TRIGGER UuidKardex
BEFORE INSERT ON tabKardex
FOR EACH ROW
EXECUTE FUNCTION generarUuidtabKardex();

CREATE TRIGGER UuidProveedorArticulo
BEFORE INSERT ON tabProveedorArticulo
FOR EACH ROW
EXECUTE FUNCTION generarUuidtabProveedorArticulo();

CREATE TRIGGER UuidEncabezadoventa
BEFORE INSERT ON tabEncabezadoVenta
FOR EACH ROW
EXECUTE FUNCTION generarUuidtabEncabezadoVenta();

CREATE TRIGGER UuidDetalleVenta
BEFORE INSERT ON tabDetalleVenta
FOR EACH ROW
EXECUTE FUNCTION generarUuidtabDetalleVenta();

CREATE TRIGGER UuidRegBorrados
BEFORE INSERT ON tabRegBorrados
FOR EACH ROW
EXECUTE FUNCTION generarUuidtabRegBorrados();
