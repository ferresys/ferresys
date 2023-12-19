
--Habilitar la extension uuid 

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

------------------------------------------------------------------------

--creamos la función para generar un UUID por registro

CREATE OR REPLACE FUNCTION uuidtabCliente()
RETURNS TRIGGER AS $$
BEGIN
    NEW.codCli := uuid_generate_v4();
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;

-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION uuidtabProveedor()
RETURNS TRIGGER AS $$
BEGIN
    NEW.codProv := uuid_generate_v4();
    RETURN NEW;
END;
$$ 
LANGUAGE PLpgSQL;
-----------------------------------------------------------------------


-- Crea el trigger para las tablas 

CREATE TRIGGER uuidCliente
BEFORE INSERT ON tabCliente
FOR EACH ROW
EXECUTE FUNCTION uuidtabCliente();

CREATE TRIGGER uuidProveedor
BEFORE INSERT ON tabProveedor
FOR EACH ROW
EXECUTE FUNCTION uuidtabProveedor();