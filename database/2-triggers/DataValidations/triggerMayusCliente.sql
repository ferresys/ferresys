/*función trigger para que independientemente de como ingrese los datos el usuario,
la primera letra de cada palabra sea en mayuscula*/

CREATE OR REPLACE FUNCTION primeraLetraMayus(text)
RETURNS text AS $$
BEGIN
    RETURN INITCAP($1);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION beforeInserttabCliente()
RETURNS TRIGGER AS 
$$
BEGIN
    NEW.nomCli := primeraLetraMayus(NEW.nomCli);
    NEW.apeCli := primeraLetraMayus(NEW.apeCli);
    NEW.nomEmpresa := primeraLetraMayus(NEW.nomEmpresa);
    NEW.nomRepLegal := primeraLetraMayus(NEW.nomRepLegal);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER mayusculas
BEFORE INSERT ON tabCliente
FOR EACH ROW
EXECUTE FUNCTION beforeInserttabCliente();
