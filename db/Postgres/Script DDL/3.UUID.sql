
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

CREATE OR REPLACE FUNCTION generarUuidtabProveedor()
RETURNS TRIGGER AS $$
BEGIN
    NEW.idProv := uuid_generate_v4();
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;


-- Crea el trigger para las tablas 

CREATE TRIGGER UuidAdministrador
BEFORE INSERT ON tabAdministrador
FOR EACH ROW
EXECUTE FUNCTION generarUuidtabAdministrador();

CREATE TRIGGER UuidCliente
BEFORE INSERT ON tabCliente
FOR EACH ROW
EXECUTE FUNCTION generarUuidtabCliente();

CREATE TRIGGER UuidProveedor
BEFORE INSERT ON tabProveedor
FOR EACH ROW
EXECUTE FUNCTION generarUuidtabProveedor();


