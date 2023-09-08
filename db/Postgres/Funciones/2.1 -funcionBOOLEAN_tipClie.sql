/*Funcion para reemplazar el BOOLEAN, TRUE= Cliente Natural y FALSE=Cliente Jurídico*/
-- SELECT tipoCliente(tipoCli) AS tipo_cliente FROM tabCliente;

CREATE OR REPLACE FUNCTION tipoCliente(tipoCli BOOLEAN)
RETURNS TEXT AS
$$
BEGIN
    IF tipoCli THEN
        RETURN 'Cliente Natural';
    ELSE
        RETURN 'Cliente Jurídico';
    END IF;
END;
$$
LANGUAGE plpgsql;
