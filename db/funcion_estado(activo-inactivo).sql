/*crear la funcion para reemplazar el boolean true por activo y false por inactivo:*/

CREATE OR REPLACE FUNCTION estado_texto(estado boolean)
RETURNS text AS 
$$
BEGIN
  IF estado THEN
    RETURN 'activo';
  ELSE
    RETURN 'inactivo';
  END IF;
END;
$$ 
LANGUAGE plpgsql;
