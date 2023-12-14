
--SELECT insertClienteNatural('1095847854', True, 'Juan', 'Rojas', '3012545874', 'juan@gmail.com', 'avenida 45 # 54-30');
--SELECT insertClienteJuridico('607784784', '1', False, 'Alumina', 'Alumina', '3012545874', 'juan@gmail.com', 'avenida 45 # 54-30');
--select * from tabCliente

-- Cliente natural 
CREATE OR REPLACE FUNCTION insertClienteNatural(
    zIdCli tabCliente.idCli%type,
	zTipoCli tabCliente.tipoCli%type,
    zNomCli tabCliente.nomCli%type,
    zApeCli tabCliente.apeCli%type,
    zTelCli tabCliente.telCli%type,
    zEmailCli tabCliente.emailCli%type,
    zDirCli tabCliente.dirCli%type
) RETURNS VOID AS
$$
DECLARE
    clienteExistente BOOLEAN;
BEGIN
    -- Verificamos si ya existe un registro con el mismo idCli
    SELECT EXISTS (SELECT 1 FROM tabCliente WHERE idCli = zIdCli) INTO clienteExistente;

    IF clienteExistente THEN
        RAISE EXCEPTION 'Cliente ya está registrado: %', zIdCli;
    ELSE
        -- Insertar nuevo cliente si no existe
        INSERT INTO tabCliente (idCli, tipoCli,nomCli, apeCli, telCli, emailCli, dirCli)
        VALUES (zIdCli, zTipoCli, zNomCli, zApeCli, zTelCli, zEmailCli, zDirCli);

        RAISE NOTICE 'Cliente registrado con éxito';
    END IF;
END;
$$ 
LANGUAGE plpgsql;

-- Cliente jurídico 
CREATE OR REPLACE FUNCTION insertClienteJuridico(
    zIdCli tabCliente.idCli%type,
    zDivCli tabCliente.divCli%type,
	zTipoCli tabCliente.tipoCli%type,
    zNomRepLegal tabCliente.nomRepLegal%type,
    zNomEmpresa tabCliente.nomEmpresa%type,
    zTelCli tabCliente.telCli%type,
    zEmailCli tabCliente.emailCli%type,
    zDirCli tabCliente.dirCli%type
) RETURNS VOID AS
$$
DECLARE
    clienteExistente BOOLEAN;
BEGIN
    -- Verificamos si ya existe un registro con el mismo idCli
    SELECT EXISTS (SELECT 1 FROM tabCliente WHERE idCli = zIdCli) INTO clienteExistente;

    IF clienteExistente THEN
        RAISE EXCEPTION 'Cliente ya está registrado: %', zIdCli;
    ELSE
        -- Insertar nuevo cliente si no existe
        INSERT INTO tabCliente (idCli, divCli, tipoCli,  nomRepLegal, nomEmpresa, telCli, emailCli, dirCli)
        VALUES (zIdCli, zDivCli, zTipoCli, zNomRepLegal, zNomEmpresa, zTelCli, zEmailCli, zDirCli);

        RAISE NOTICE 'Cliente registrado con éxito';
    END IF;
END;
$$ 
LANGUAGE plpgsql;


-- Función para insertar datos de un nuevo cliente 
/*
CREATE OR REPLACE FUNCTION insertCliente(
    zIdCli tabCliente.idCli%type,
    zDivCli tabCliente.divCli%type,
    zTipoCli tabCliente.tipoCli%type,
    zNomCli tabCliente.nomCli%type,
    zApeCli tabCliente.apeCli%type,
    zNomRepLegal tabCliente.nomRepLegal%type,
    zNomEmpresa tabCliente.nomEmpresa%type,
    zTelCli tabCliente.telCli%type,
    zEmailCli tabCliente.emailCli%type,
    zDirCli tabCliente.dirCli%type
) RETURNS VOID AS
$$
DECLARE
    clienteExistente BOOLEAN;

BEGIN
    -- Verificamos si ya existe un registro con el mismo idCli
    SELECT EXISTS (SELECT 1 FROM tabCliente WHERE idCli = zIdCli) INTO clienteExistente;

    IF clienteExistente THEN
        RAISE EXCEPTION 'Cliente ya esta registrado: %', zIdCli;

    ELSE

        -- Insertar nuevo cliente si no existe
        INSERT INTO tabCliente (idCli, divCli, tipoCli, nomCli, apeCli, nomRepLegal, nomEmpresa, telCli, emailCli, dirCli)
        VALUES (zIdCli, zDivCli, zTipoCli, zNomCli, zApeCli, zNomRepLegal, zNomEmpresa, zTelCli, zEmailCli, zDirCli);
        
        RAISE NOTICE 'Cliente registrado con éxito';
    END IF;
END;
$$ 
LANGUAGE plpgsql;
*/
