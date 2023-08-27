PGDMP                         {         
   dbFerreSys    15.3    15.3 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    76467 
   dbFerreSys    DATABASE     �   CREATE DATABASE "dbFerreSys" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Colombia.1252';
    DROP DATABASE "dbFerreSys";
                postgres    false                        3079    76710 	   uuid-ossp 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
    DROP EXTENSION "uuid-ossp";
                   false            �           0    0    EXTENSION "uuid-ossp"    COMMENT     W   COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
                        false    2                       1255    76778    actualizarestado()    FUNCTION     �   CREATE FUNCTION public.actualizarestado() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.estado = 'INACTIVO' THEN
        NEW.estado := 'INACTIVO';
    END IF;
	
RETURN NEW;
END;
$$;
 )   DROP FUNCTION public.actualizarestado();
       public          postgres    false                       1255    76776    actualizarstockvalunit()    FUNCTION       CREATE FUNCTION public.actualizarstockvalunit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  zValStock tabArticulo.valStock%type;
  zValUnit tabArticulo.valUnit%type;
  zPorcentaje NUMERIC(10,2);

BEGIN
select Porcentaje into zPorcentaje from tabArticulo where eanArt = NEW.eanArt;
  IF NEW.tipoMov = 'ENTRADA' THEN
    	zValStock := (SELECT COALESCE(valStock, 0) + NEW.cantArt FROM tabArticulo WHERE eanArt = NEW.eanArt);
    	zValUnit := NEW.valProm * zPorcentaje ; --(el porcentaje debe ser ingresado como 1.20, 1.30, 1.10..etc)
	
  	 ELSIF NEW.tipoMov = 'SALIDA' THEN
    	zValStock := (SELECT COALESCE(valStock, 0) - NEW.cantArt FROM tabArticulo WHERE eanArt = NEW.eanArt);
    	zValUnit := (SELECT valUnit FROM tabArticulo WHERE eanArt = NEW.eanArt);
  END IF;

  UPDATE tabArticulo SET valStock = zValStock, valUnit = zValUnit WHERE eanArt = NEW.eanArt;

RETURN NEW;
END;
$$;
 /   DROP FUNCTION public.actualizarstockvalunit();
       public          postgres    false            �            1255    76693     generarconsecutivotabcategoria()    FUNCTION     �   CREATE FUNCTION public.generarconsecutivotabcategoria() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecCateg := (SELECT COALESCE(MAX(consecCateg), 0) + 1 FROM tabCategoria);
    RETURN NEW;
END;
$$;
 7   DROP FUNCTION public.generarconsecutivotabcategoria();
       public          postgres    false            �            1255    76692    generarconsecutivotabcliente()    FUNCTION     �   CREATE FUNCTION public.generarconsecutivotabcliente() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecCli := (SELECT COALESCE(MAX(consecCli), 0) + 1 FROM tabCliente);
    RETURN NEW;
END;
$$;
 5   DROP FUNCTION public.generarconsecutivotabcliente();
       public          postgres    false            �            1255    76699 #   generarconsecutivotabdetalleventa()    FUNCTION     �   CREATE FUNCTION public.generarconsecutivotabdetalleventa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecDetVenta := (SELECT COALESCE(MAX(consecDetVenta), 0) + 1 FROM tabDetalleVenta);
    RETURN NEW;
END;
$$;
 :   DROP FUNCTION public.generarconsecutivotabdetalleventa();
       public          postgres    false            �            1255    76698 &   generarconsecutivotabencabezadoventa()    FUNCTION     �   CREATE FUNCTION public.generarconsecutivotabencabezadoventa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecVenta := (SELECT COALESCE(MAX(consecVenta), 0) + 1 FROM tabEncabezadoVenta);
    RETURN NEW;
END;
$$;
 =   DROP FUNCTION public.generarconsecutivotabencabezadoventa();
       public          postgres    false            �            1255    76696    generarconsecutivotabkardex()    FUNCTION     �   CREATE FUNCTION public.generarconsecutivotabkardex() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecKardex := (SELECT COALESCE(MAX(consecKardex), 0) + 1 FROM tabKardex);
    RETURN NEW;
END;
$$;
 4   DROP FUNCTION public.generarconsecutivotabkardex();
       public          postgres    false            �            1255    76694    generarconsecutivotabmarca()    FUNCTION     �   CREATE FUNCTION public.generarconsecutivotabmarca() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecMarca := (SELECT COALESCE(MAX(consecMarca), 0) + 1 FROM tabMarca);
    RETURN NEW;
END;
$$;
 3   DROP FUNCTION public.generarconsecutivotabmarca();
       public          postgres    false            �            1255    76697 (   generarconsecutivotabproveedorarticulo()    FUNCTION     �   CREATE FUNCTION public.generarconsecutivotabproveedorarticulo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecProvArt := (SELECT COALESCE(MAX(consecProvArt), 0) + 1 FROM tabProveedorArticulo);
    RETURN NEW;
END;
$$;
 ?   DROP FUNCTION public.generarconsecutivotabproveedorarticulo();
       public          postgres    false            �            1255    76695 %   generarconsecutivotabproveedormarca()    FUNCTION     �   CREATE FUNCTION public.generarconsecutivotabproveedormarca() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecProvMarca := (SELECT COALESCE(MAX(consecProvMarca), 0) + 1 FROM tabProveedorMarca);
    RETURN NEW;
END;
$$;
 <   DROP FUNCTION public.generarconsecutivotabproveedormarca();
       public          postgres    false            �            1255    76700 "   generarconsecutivotabregborrados()    FUNCTION     �   CREATE FUNCTION public.generarconsecutivotabregborrados() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecReg := (SELECT COALESCE(MAX(consecReg), 0) + 1 FROM tabRegBorrados);
    RETURN NEW;
END;
$$;
 9   DROP FUNCTION public.generarconsecutivotabregborrados();
       public          postgres    false            �            1255    76721    generaruuidtabadministrador()    FUNCTION     �   CREATE FUNCTION public.generaruuidtabadministrador() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.idAdmin := uuid_generate_v4();
    RETURN NEW;
END;
$$;
 4   DROP FUNCTION public.generaruuidtabadministrador();
       public          postgres    false                        1255    76729    generaruuidtabarticulo()    FUNCTION     �   CREATE FUNCTION public.generaruuidtabarticulo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.idArt := uuid_generate_v4();
    RETURN NEW;
END;
$$;
 /   DROP FUNCTION public.generaruuidtabarticulo();
       public          postgres    false            �            1255    76726    generaruuidtabcategoria()    FUNCTION     �   CREATE FUNCTION public.generaruuidtabcategoria() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.idCateg := uuid_generate_v4();
    RETURN NEW;
END;
$$;
 0   DROP FUNCTION public.generaruuidtabcategoria();
       public          postgres    false            �            1255    76722    generaruuidtabcliente()    FUNCTION     �   CREATE FUNCTION public.generaruuidtabcliente() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.idCli := uuid_generate_v4();
    RETURN NEW;
END;
$$;
 .   DROP FUNCTION public.generaruuidtabcliente();
       public          postgres    false            �            1255    76724    generaruuidtabclientejuridico()    FUNCTION     �   CREATE FUNCTION public.generaruuidtabclientejuridico() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.idCliJur := uuid_generate_v4();
    RETURN NEW;
END;
$$;
 6   DROP FUNCTION public.generaruuidtabclientejuridico();
       public          postgres    false            �            1255    76723    generaruuidtabclientenatural()    FUNCTION     �   CREATE FUNCTION public.generaruuidtabclientenatural() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.idCliNat := uuid_generate_v4();
    RETURN NEW;
END;
$$;
 5   DROP FUNCTION public.generaruuidtabclientenatural();
       public          postgres    false                       1255    76733    generaruuidtabdetalleventa()    FUNCTION     �   CREATE FUNCTION public.generaruuidtabdetalleventa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.idDetVenta := uuid_generate_v4();
    RETURN NEW;
END;
$$;
 3   DROP FUNCTION public.generaruuidtabdetalleventa();
       public          postgres    false                       1255    76732    generaruuidtabencabezadoventa()    FUNCTION     �   CREATE FUNCTION public.generaruuidtabencabezadoventa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.idVenta := uuid_generate_v4();
    RETURN NEW;
END;
$$;
 6   DROP FUNCTION public.generaruuidtabencabezadoventa();
       public          postgres    false                       1255    76730    generaruuidtabkardex()    FUNCTION     �   CREATE FUNCTION public.generaruuidtabkardex() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.idKardex := uuid_generate_v4();
    RETURN NEW;
END;
$$;
 -   DROP FUNCTION public.generaruuidtabkardex();
       public          postgres    false            �            1255    76727    generaruuidtabmarca()    FUNCTION     �   CREATE FUNCTION public.generaruuidtabmarca() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.idMarca := uuid_generate_v4();
    RETURN NEW;
END;
$$;
 ,   DROP FUNCTION public.generaruuidtabmarca();
       public          postgres    false            �            1255    76725    generaruuidtabproveedor()    FUNCTION     �   CREATE FUNCTION public.generaruuidtabproveedor() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.idProv := uuid_generate_v4();
    RETURN NEW;
END;
$$;
 0   DROP FUNCTION public.generaruuidtabproveedor();
       public          postgres    false                       1255    76731 !   generaruuidtabproveedorarticulo()    FUNCTION     �   CREATE FUNCTION public.generaruuidtabproveedorarticulo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.idProvArt := uuid_generate_v4();
    RETURN NEW;
END;
$$;
 8   DROP FUNCTION public.generaruuidtabproveedorarticulo();
       public          postgres    false            �            1255    76728    generaruuidtabproveedormarca()    FUNCTION     �   CREATE FUNCTION public.generaruuidtabproveedormarca() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.idprovMarca := uuid_generate_v4();
    RETURN NEW;
END;
$$;
 5   DROP FUNCTION public.generaruuidtabproveedormarca();
       public          postgres    false                       1255    76734    generaruuidtabregborrados()    FUNCTION     �   CREATE FUNCTION public.generaruuidtabregborrados() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.idReg := uuid_generate_v4();
    RETURN NEW;
END;
$$;
 2   DROP FUNCTION public.generaruuidtabregborrados();
       public          postgres    false                       1255    76786 �   insertadministrador(integer, character varying, character varying, character varying, character varying, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.insertadministrador(zcedulaadmin integer, znomadmin character varying, zapeadmin character varying, zteladmin character varying, zemailadmin character varying, zusuario character varying, zpassword character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE

    ZFecReg timestamp := now(); /*tambien puedo usar current_timestamp*/
    
BEGIN

    INSERT INTO tabAdministrador(cedulaAdmin, fecReg, nomAdmin, apeAdmin, telAdmin, emailAdmin, usuario, password)
    VALUES ( zCedulaAdmin, zFecReg, zNomAdmin, zApeAdmin, zTelAdmin, zEmailAdmin, zUsuario, zPassword );
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$;
 �   DROP FUNCTION public.insertadministrador(zcedulaadmin integer, znomadmin character varying, zapeadmin character varying, zteladmin character varying, zemailadmin character varying, zusuario character varying, zpassword character varying);
       public          postgres    false                       1255    76791 Y   insertarticulo(character varying, character varying, bigint, bigint, text, numeric, date)    FUNCTION     I  CREATE FUNCTION public.insertarticulo(zeanart character varying, znomart character varying, zconsecmarca bigint, zconseccateg bigint, zdescripart text, zporcentaje numeric, zfecvence date) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    zFecReg TIMESTAMP:= current_timestamp;--now(); puede ser current_timestamp o now();
	zMarca tabMarca.consecMarca%type;
	zCategoria tabCategoria.consecCateg%type;
	
BEGIN

SELECT consecMarca INTO zMarca FROM tabMarca WHERE consecMarca=zConsecMarca;
SELECT consecCateg INTO zCategoria FROM tabCategoria WHERE consecCateg=zConsecCateg; 
    
	INSERT INTO tabArticulo(eanArt, fecReg, nomArt,consecMarca, consecCateg, descripArt, porcentaje, fecVence)
    VALUES (zEanArt, zFecReg, zNomArt, zMarca, zCategoria, zDescripArt, zPorcentaje, zFecVence);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$;
 �   DROP FUNCTION public.insertarticulo(zeanart character varying, znomart character varying, zconsecmarca bigint, zconseccateg bigint, zdescripart text, zporcentaje numeric, zfecvence date);
       public          postgres    false                       1255    76790 +   insertcategoria(character varying, integer)    FUNCTION     �  CREATE FUNCTION public.insertcategoria(znomcateg character varying, zcedulaadmin integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    --zAdmin INTEGER;
BEGIN
    --SELECT idAdmin INTO ZAdmin FROM tabAdministrador;
    INSERT INTO tabCategoria(nomCateg, cedulaAdmin)
    VALUES (zNomCateg, zCedulaAdmin);
    --RETURNING idAdmin INTO zAdmin;
    RAISE NOTICE 'Registro exitoso ';
END;
$$;
 Y   DROP FUNCTION public.insertcategoria(znomcateg character varying, zcedulaadmin integer);
       public          postgres    false                       1255    76787 �   insertcliente(character varying, character varying, character varying, character varying, integer, character varying, character varying, character varying, character varying)    FUNCTION     d  CREATE FUNCTION public.insertcliente(ztipocli character varying, ztelcli character varying, zemailcli character varying, zdircli character varying, zcedulaclinat integer DEFAULT NULL::integer, znomcli character varying DEFAULT NULL::character varying, zapecli character varying DEFAULT NULL::character varying, znitclijur character varying DEFAULT NULL::character varying, znomempr character varying DEFAULT NULL::character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    zFecReg TIMESTAMP := current_timestamp;
    zConsecCli BIGINT;
BEGIN
    -- Insertar en la tabla tabCliente
    INSERT INTO tabCliente(fecReg, tipoCli, telCli, emailCli, dirCli)
    VALUES (zFecReg, zTipoCli, zTelCli, zEmailCli, zDirCli)
    RETURNING consecCli INTO zConsecCli;

    --validaciones para insertar dependiendo del tipo de cliente Natural o Juridico
    IF zTipoCli = 'Natural' THEN
        -- Insertar en la tabla tabClienteNatural
        INSERT INTO tabClienteNatural(cedulaCliNat, consecCli, fecReg, nomCli, apeCli)
        VALUES (zCedulaCliNat, zConsecCli, zFecReg, zNomCli, zApeCli);

    ELSIF zTipoCli = 'Juridico' THEN
        -- Insertar en la tabla tabClienteJuridico
        INSERT INTO tabClienteJuridico(nitCliJur, consecCli, fecReg, nomEmpr)
        VALUES (zNitCliJur, zConsecCli, zFecReg, zNomEmpr);
    END IF;

    RAISE NOTICE 'Registro exitoso';
END;
$$;
   DROP FUNCTION public.insertcliente(ztipocli character varying, ztelcli character varying, zemailcli character varying, zdircli character varying, zcedulaclinat integer, znomcli character varying, zapecli character varying, znitclijur character varying, znomempr character varying);
       public          postgres    false            !           1255    76803 .   insertdetalleventa(character varying, integer)    FUNCTION     �  CREATE FUNCTION public.insertdetalleventa(zeanart character varying, zcantart integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    zValUnit NUMERIC(10);
    zSubTotal NUMERIC(10);
    --ziva NUMERIC(10);
    zTotalPagar NUMERIC(10);
    zConsecVenta BIGINT;
BEGIN
    -- Obtener el valor unitario (valUnit) del artículo desde la tabla "tabArticulo"
    SELECT valUnit INTO zValUnit FROM tabArticulo WHERE eanArt = zEanArt;

    -- Calcular el subtotal, el valor del IVA y el total a pagar
    zSubtotal := zCantArt * zValUnit;
    /*SELECT iva INTO ziva FROM tab_articulo WHERE ean_art = zEanArt;
    zTotalPagar :=  (zSubtotal * ziva)/100+(zsubtotal)-zdescuento;*/
    zTotalPagar := zSubtotal;
    -- Obtener el consecutivo de venta (consec_venta) desde la tabla "tab_encabezado_venta"
    SELECT consecVenta INTO zConsecVenta FROM tabEncabezadoVenta ORDER BY consecVenta DESC LIMIT 1;

    -- Insertar los datos en la tabla "tab_detalle_venta"
    INSERT INTO tabDetalleVenta (nomArt, cantArt, valUnit, subtotal, totalPagar, consecVenta, eanArt)
    VALUES ((SELECT nomArt FROM tabArticulo WHERE eanArt = zEanArt), zCantArt, zValUnit, zsubtotal,  zTotalPagar, zConsecVenta, zEanArt);

    RETURN;
END;
$$;
 V   DROP FUNCTION public.insertdetalleventa(zeanart character varying, zcantart integer);
       public          postgres    false                       1255    76800 L   insertencabezadoventajuridico(character varying, character varying, integer)    FUNCTION     -  CREATE FUNCTION public.insertencabezadoventajuridico(ztipofactura character varying, znitclijur character varying, zcedulaadmin integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE 
    zFecVenta TIMESTAMP := current_timestamp;
    zNitClis VARCHAR;
BEGIN
    IF zTipoFactura = 'PRELIMINAR' OR zTipoFactura = 'LEGAL' THEN
        -- Obtener el consecutivo del cliente jurídico
        SELECT nitCliJur INTO zNitClis FROM tabClienteJuridico WHERE nitCliJur = zNitCliJur;

        -- Insertar en la tabla tabEncabezadoVenta
        INSERT INTO tabEncabezadoVenta (fecVenta, tipoFactura, cedulaAdmin, nitCliJur)
        VALUES (zFecVenta, zTipoFactura, zCedulaAdmin, zNitClis);

        RAISE NOTICE 'Encabezado de Venta para cliente jurídico registrado con éxito.';
    END IF;
    
    RETURN;
END;
$$;
 �   DROP FUNCTION public.insertencabezadoventajuridico(ztipofactura character varying, znitclijur character varying, zcedulaadmin integer);
       public          postgres    false                       1255    76799 A   insertencabezadoventanatural(character varying, integer, integer)    FUNCTION     +  CREATE FUNCTION public.insertencabezadoventanatural(ztipofactura character varying, zcedulaclinat integer, zcedulaadmin integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE 
    zFecVenta TIMESTAMP:= current_timestamp;
    zIdClis INTEGER;
	
BEGIN
    IF zTipoFactura = 'PRELIMINAR' OR zTipoFactura = 'LEGAL' THEN
        -- Obtener el consecutivo del cliente natural
        SELECT cedulaCliNat INTO zIdClis FROM tabClienteNatural WHERE cedulaCliNat = zCedulaCliNat;

        -- Insertar en la tabla tabEncabezadoVenta
        INSERT INTO tabEncabezadoVenta (fecVenta, tipoFactura, cedulaAdmin, cedulaCliNat)
        VALUES (zFecVenta, zTipoFactura,  zcedulaAdmin, zIdClis);

        RAISE NOTICE 'Encabezado de Venta para cliente natural registrado con éxito.';
    END IF;
    
    RETURN;
END;
$$;
 �   DROP FUNCTION public.insertencabezadoventanatural(ztipofactura character varying, zcedulaclinat integer, zcedulaadmin integer);
       public          postgres    false                       1255    76796 �   insertkardex(character varying, character varying, character varying, integer, numeric, text, character varying, bigint, integer)    FUNCTION     �  CREATE FUNCTION public.insertkardex(ztipomov character varying, zeanart character varying, znomart character varying, zcantart integer, zvalcompra numeric, zobservacion text, znitprov character varying, zconsecmarca bigint, zcedulaadmin integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    zFecMov TIMESTAMP := current_timestamp; --now(); puede ser current_timestamp o now();
    zValProm tabKardex.valProm%type;
    zValTotal tabKardex.valTotal%type;
	
BEGIN
    IF zTipoMov ='ENTRADA' THEN
        zValTotal := zCantArt * zValCompra;
        zValProm := zValTotal / zCantArt;
		
    	ELSIF zTipoMov ='SALIDA' THEN
        zValTotal := 0; -- No se realiza el cálculo para 'SALIDA', asignamos  un valor por defecto.
        zValProm := 0;  -- No se realiza el cálculo para 'SALIDA', asignamos un valor por defecto.
    END IF;

    INSERT INTO tabKardex( fecMov, tipoMov, eanArt, nomArt, cantArt, valCompra, valTotal, valProm, observacion, nitProv, consecMarca, cedulaAdmin)
    VALUES (zFecMov, zTipoMov, zEanArt, zNomArt, zCantArt, zValCompra, zValTotal, zValProm, zObservacion, zNitProv, zConsecMarca, zCedulaAdmin);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$;
 �   DROP FUNCTION public.insertkardex(ztipomov character varying, zeanart character varying, znomart character varying, zcantart integer, zvalcompra numeric, zobservacion text, znitprov character varying, zconsecmarca bigint, zcedulaadmin integer);
       public          postgres    false                       1255    76789    insertmarca(character varying)    FUNCTION     �   CREATE FUNCTION public.insertmarca(znommarca character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    
BEGIN

    INSERT INTO tabMarca(nomMarca)
    VALUES (zNomMarca);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$;
 ?   DROP FUNCTION public.insertmarca(znommarca character varying);
       public          postgres    false                       1255    76788 n   insertproveedor(character varying, character varying, character varying, character varying, character varying)    FUNCTION     !  CREATE FUNCTION public.insertproveedor(znitprov character varying, znomprov character varying, ztelprov character varying, zemailprov character varying, zdirprov character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    
    zFecReg TIMESTAMP:= current_timestamp;--now(); puede ser current_timestamp o now();
	
BEGIN

    INSERT INTO tabProveedor(fecReg, nitProv, nomProv, telProv, emailProv, dirProv)
    VALUES (zFecReg, zNitProv, zNomProv, zTelProv, zEmailProv, zDirProv);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$;
 �   DROP FUNCTION public.insertproveedor(znitprov character varying, znomprov character varying, ztelprov character varying, zemailprov character varying, zdirprov character varying);
       public          postgres    false                       1255    76797     insertsalidakardexdetalleventa()    FUNCTION     �  CREATE FUNCTION public.insertsalidakardexdetalleventa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO tabKardex (
    fecMov, tipoMov, eanArt, nomArt, cantArt,valCompra, valTotal, valProm, nitProv, consecMarca, cedulaAdmin ) 
	VALUES (now(), 'SALIDA', NEW.eanArt, NEW.nomArt, NEW.cantArt, 0, 0, 0,  
    (SELECT nitProv FROM tabProveedor  LIMIT 1), 
	(SELECT consecMarca FROM tabMarca LIMIT 1),		
    (SELECT cedulaAdmin FROM tabAdministrador LIMIT 1) 
   
  );

  RETURN NEW;
END;
$$;
 7   DROP FUNCTION public.insertsalidakardexdetalleventa();
       public          postgres    false                       1255    76792    inserttabproveedorarticulo()    FUNCTION       CREATE FUNCTION public.inserttabproveedorarticulo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  -- Verificar si ya existe una fila con los mismos valores de nitProv y eanArt en tabProveedorArticulo
  IF EXISTS (SELECT 1 FROM tabProveedorArticulo WHERE nitProv = NEW.nitProv AND eanArt = NEW.eanArt) THEN
   
    UPDATE tabProveedorArticulo
    SET nitProv = NEW.nitProv, eanArt= NEW.eanArt
    WHERE  nitProv=NEW.nitProv and eanArt= NEW.eanArt;
	

  ELSE
    -- Si no existe, insertar una nueva fila
    INSERT INTO tabProveedorArticulo (nitProv, eanArt)
    VALUES (NEW.nitProv,  NEW.eanArt);
  END IF;

  RETURN NEW;
END;
$$;
 3   DROP FUNCTION public.inserttabproveedorarticulo();
       public          postgres    false                       1255    76794    inserttabproveedormarca()    FUNCTION     �  CREATE FUNCTION public.inserttabproveedormarca() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  -- Verificar si ya existe una fila con los mismos valores de nitProv y consecMarca en tabProveedorMarca
  IF EXISTS (SELECT 1 FROM tabProveedorMarca WHERE nitProv = NEW.nitProv and consecMarca= NEW.consecMarca ) THEN
   
    -- Si existe, se actualiza solo la fila correspondiente
    UPDATE tabProveedorMarca
    SET nitProv = NEW.nitProv, consecMarca= NEW.consecMarca
    WHERE  nitProv=NEW.nitProv and consecMarca=NEW.consecMarca;
	
  
    
  ELSE
    -- Si no existe, insertar una nueva fila en tabProveedorMarca
    INSERT INTO tabProveedorMarca (nitProv, consecMarca)
    VALUES (NEW.nitProv, NEW.consecMarca);
  END IF;

  RETURN NEW;
END;
$$;
 0   DROP FUNCTION public.inserttabproveedormarca();
       public          postgres    false                       1255    76749    movimientosadmin()    FUNCTION     �  CREATE FUNCTION public.movimientosadmin() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP='INSERT' THEN
    	NEW.fecInsert := now();
    	NEW.userInsert := current_user;
		RETURN NEW;
	END IF;
	
	IF TG_OP='UPDATE' THEN
		NEW.fecUpdate := now();
		NEW.userUpdate := current_user;
		RETURN NEW;
	END IF;
	
	IF TG_OP= 'DELETE' THEN
	  INSERT INTO tabRegBorrados (fecDelete,userDelete,nomTabla)
	  VALUES(current_timestamp,current_user,TG_RELNAME);
	
	  RETURN OLD;
	END IF ;

END;

$$;
 )   DROP FUNCTION public.movimientosadmin();
       public          postgres    false                        1255    76801    updateencabezadoventavalpagar()    FUNCTION     2  CREATE FUNCTION public.updateencabezadoventavalpagar() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    ZTotalPagar numeric(10);
BEGIN
    -- Obtener el "TotalPagar" de "tabDetalleVenta" para el consecVenta correspondiente
    SELECT SUM(totalPagar) INTO ZTotalPagar FROM tabDetalleVenta WHERE consecVenta = NEW.consecVenta;

    -- Actualizar el campo "valPagar" en "tabEncabezadoVenta" con el valor calculado
    UPDATE tabEncabezadoVenta AS enc
    SET totalPagar = ZTotalPagar
    WHERE enc.consecVenta = NEW.consecVenta;

    RETURN NEW;
END;
$$;
 6   DROP FUNCTION public.updateencabezadoventavalpagar();
       public          postgres    false            �            1259    76468    tabadministrador    TABLE     Y  CREATE TABLE public.tabadministrador (
    idadmin uuid NOT NULL,
    cedulaadmin integer NOT NULL,
    fecreg timestamp without time zone NOT NULL,
    nomadmin character varying NOT NULL,
    apeadmin character varying NOT NULL,
    teladmin character varying NOT NULL,
    emailadmin character varying NOT NULL,
    usuario character varying NOT NULL,
    password character varying NOT NULL,
    estado text DEFAULT 'ACTIVO'::text NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
 $   DROP TABLE public.tabadministrador;
       public         heap    postgres    false            �            1259    76569    tabarticulo    TABLE     �  CREATE TABLE public.tabarticulo (
    idart uuid NOT NULL,
    eanart character varying,
    fecreg timestamp without time zone NOT NULL,
    nomart character varying NOT NULL,
    consecmarca bigint NOT NULL,
    conseccateg bigint NOT NULL,
    descripart text,
    valunit numeric(10,0),
    porcentaje numeric(10,2),
    valstock integer,
    stockmin integer DEFAULT 10 NOT NULL,
    stockmax integer DEFAULT 500 NOT NULL,
    valreorden integer DEFAULT 50 NOT NULL,
    fecvence date,
    estado text DEFAULT 'ACTIVO'::text NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
    DROP TABLE public.tabarticulo;
       public         heap    postgres    false            �            1259    76525    tabcategoria    TABLE     w  CREATE TABLE public.tabcategoria (
    idcateg uuid NOT NULL,
    conseccateg bigint NOT NULL,
    nomcateg character varying NOT NULL,
    estado text DEFAULT 'ACTIVO'::text NOT NULL,
    cedulaadmin integer NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
     DROP TABLE public.tabcategoria;
       public         heap    postgres    false            �            1259    76478 
   tabcliente    TABLE     �  CREATE TABLE public.tabcliente (
    idcli uuid NOT NULL,
    conseccli bigint NOT NULL,
    fecreg timestamp without time zone NOT NULL,
    tipocli character varying NOT NULL,
    telcli character varying NOT NULL,
    emailcli character varying NOT NULL,
    dircli character varying NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
    DROP TABLE public.tabcliente;
       public         heap    postgres    false            �            1259    76501    tabclientejuridico    TABLE     �  CREATE TABLE public.tabclientejuridico (
    idclijur uuid NOT NULL,
    nitclijur character varying NOT NULL,
    conseccli bigint NOT NULL,
    fecreg timestamp without time zone NOT NULL,
    nomempr character varying NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
 &   DROP TABLE public.tabclientejuridico;
       public         heap    postgres    false            �            1259    76487    tabclientenatural    TABLE     �  CREATE TABLE public.tabclientenatural (
    idclinat uuid NOT NULL,
    cedulaclinat integer NOT NULL,
    conseccli bigint NOT NULL,
    fecreg timestamp without time zone NOT NULL,
    nomcli character varying NOT NULL,
    apecli character varying NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
 %   DROP TABLE public.tabclientenatural;
       public         heap    postgres    false            �            1259    76665    tabdetalleventa    TABLE     2  CREATE TABLE public.tabdetalleventa (
    iddetventa uuid NOT NULL,
    consecdetventa bigint NOT NULL,
    consecventa bigint NOT NULL,
    eanart character varying NOT NULL,
    nomart character varying NOT NULL,
    cantart integer NOT NULL,
    valunit numeric(10,0) NOT NULL,
    subtotal numeric(10,0) NOT NULL,
    totalpagar numeric(10,0) NOT NULL,
    estado text DEFAULT 'ACTIVO'::text NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
 #   DROP TABLE public.tabdetalleventa;
       public         heap    postgres    false            �            1259    76640    tabencabezadoventa    TABLE       CREATE TABLE public.tabencabezadoventa (
    idventa uuid NOT NULL,
    consecventa bigint NOT NULL,
    fecventa timestamp without time zone NOT NULL,
    tipofactura character varying NOT NULL,
    cedulaclinat integer,
    nitclijur character varying,
    totalpagar numeric(10,0),
    cedulaadmin integer NOT NULL,
    estado text DEFAULT 'ACTIVO'::text NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
 &   DROP TABLE public.tabencabezadoventa;
       public         heap    postgres    false            �            1259    76592 	   tabkardex    TABLE     �  CREATE TABLE public.tabkardex (
    idkardex uuid NOT NULL,
    conseckardex bigint NOT NULL,
    fecmov timestamp without time zone NOT NULL,
    tipomov character varying NOT NULL,
    eanart character varying NOT NULL,
    nomart character varying NOT NULL,
    cantart integer NOT NULL,
    valcompra numeric(10,0) NOT NULL,
    valtotal numeric(10,0) NOT NULL,
    valprom numeric(10,0) NOT NULL,
    observacion text,
    nitprov character varying NOT NULL,
    consecmarca bigint NOT NULL,
    cedulaadmin integer NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
    DROP TABLE public.tabkardex;
       public         heap    postgres    false            �            1259    76540    tabmarca    TABLE     Q  CREATE TABLE public.tabmarca (
    idmarca uuid NOT NULL,
    consecmarca bigint NOT NULL,
    nommarca character varying NOT NULL,
    estado text DEFAULT 'ACTIVO'::text NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
    DROP TABLE public.tabmarca;
       public         heap    postgres    false            �            1259    76515    tabproveedor    TABLE       CREATE TABLE public.tabproveedor (
    idprov uuid NOT NULL,
    nitprov character varying NOT NULL,
    fecreg timestamp without time zone NOT NULL,
    nomprov character varying NOT NULL,
    telprov character varying NOT NULL,
    emailprov character varying NOT NULL,
    dirprov character varying NOT NULL,
    estado text DEFAULT 'ACTIVO'::text NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
     DROP TABLE public.tabproveedor;
       public         heap    postgres    false            �            1259    76621    tabproveedorarticulo    TABLE     V  CREATE TABLE public.tabproveedorarticulo (
    idprovart uuid NOT NULL,
    consecprovart bigint NOT NULL,
    nitprov character varying NOT NULL,
    eanart character varying NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
 (   DROP TABLE public.tabproveedorarticulo;
       public         heap    postgres    false            �            1259    76550    tabproveedormarca    TABLE     Q  CREATE TABLE public.tabproveedormarca (
    idprovmarca uuid NOT NULL,
    consecprovmarca bigint NOT NULL,
    nitprov character varying NOT NULL,
    consecmarca bigint NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
 %   DROP TABLE public.tabproveedormarca;
       public         heap    postgres    false            �            1259    76685    tabregborrados    TABLE     �   CREATE TABLE public.tabregborrados (
    idreg uuid NOT NULL,
    consecreg bigint NOT NULL,
    fecdelete timestamp without time zone,
    userdelete character varying NOT NULL,
    nomtabla character varying NOT NULL
);
 "   DROP TABLE public.tabregborrados;
       public         heap    postgres    false            �          0    76468    tabadministrador 
   TABLE DATA           �   COPY public.tabadministrador (idadmin, cedulaadmin, fecreg, nomadmin, apeadmin, teladmin, emailadmin, usuario, password, estado, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    215   <      �          0    76569    tabarticulo 
   TABLE DATA           �   COPY public.tabarticulo (idart, eanart, fecreg, nomart, consecmarca, conseccateg, descripart, valunit, porcentaje, valstock, stockmin, stockmax, valreorden, fecvence, estado, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    223   �<      �          0    76525    tabcategoria 
   TABLE DATA           �   COPY public.tabcategoria (idcateg, conseccateg, nomcateg, estado, cedulaadmin, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    220   �=      �          0    76478 
   tabcliente 
   TABLE DATA           �   COPY public.tabcliente (idcli, conseccli, fecreg, tipocli, telcli, emailcli, dircli, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    216   '>      �          0    76501    tabclientejuridico 
   TABLE DATA           �   COPY public.tabclientejuridico (idclijur, nitclijur, conseccli, fecreg, nomempr, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    218   ?      �          0    76487    tabclientenatural 
   TABLE DATA           �   COPY public.tabclientenatural (idclinat, cedulaclinat, conseccli, fecreg, nomcli, apecli, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    217   �?      �          0    76665    tabdetalleventa 
   TABLE DATA           �   COPY public.tabdetalleventa (iddetventa, consecdetventa, consecventa, eanart, nomart, cantart, valunit, subtotal, totalpagar, estado, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    227   @      �          0    76640    tabencabezadoventa 
   TABLE DATA           �   COPY public.tabencabezadoventa (idventa, consecventa, fecventa, tipofactura, cedulaclinat, nitclijur, totalpagar, cedulaadmin, estado, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    226   �@      �          0    76592 	   tabkardex 
   TABLE DATA           �   COPY public.tabkardex (idkardex, conseckardex, fecmov, tipomov, eanart, nomart, cantart, valcompra, valtotal, valprom, observacion, nitprov, consecmarca, cedulaadmin, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    224   #A      �          0    76540    tabmarca 
   TABLE DATA           x   COPY public.tabmarca (idmarca, consecmarca, nommarca, estado, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    221   yB      �          0    76515    tabproveedor 
   TABLE DATA           �   COPY public.tabproveedor (idprov, nitprov, fecreg, nomprov, telprov, emailprov, dirprov, estado, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    219   C      �          0    76621    tabproveedorarticulo 
   TABLE DATA           �   COPY public.tabproveedorarticulo (idprovart, consecprovart, nitprov, eanart, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    225   �C      �          0    76550    tabproveedormarca 
   TABLE DATA           �   COPY public.tabproveedormarca (idprovmarca, consecprovmarca, nitprov, consecmarca, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    222   �D      �          0    76685    tabregborrados 
   TABLE DATA           [   COPY public.tabregborrados (idreg, consecreg, fecdelete, userdelete, nomtabla) FROM stdin;
    public          postgres    false    228   |E      �           2606    76477 1   tabadministrador tabadministrador_cedulaadmin_key 
   CONSTRAINT     s   ALTER TABLE ONLY public.tabadministrador
    ADD CONSTRAINT tabadministrador_cedulaadmin_key UNIQUE (cedulaadmin);
 [   ALTER TABLE ONLY public.tabadministrador DROP CONSTRAINT tabadministrador_cedulaadmin_key;
       public            postgres    false    215            �           2606    76475 &   tabadministrador tabadministrador_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.tabadministrador
    ADD CONSTRAINT tabadministrador_pkey PRIMARY KEY (idadmin);
 P   ALTER TABLE ONLY public.tabadministrador DROP CONSTRAINT tabadministrador_pkey;
       public            postgres    false    215            �           2606    76581 "   tabarticulo tabarticulo_eanart_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.tabarticulo
    ADD CONSTRAINT tabarticulo_eanart_key UNIQUE (eanart);
 L   ALTER TABLE ONLY public.tabarticulo DROP CONSTRAINT tabarticulo_eanart_key;
       public            postgres    false    223            �           2606    76579    tabarticulo tabarticulo_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.tabarticulo
    ADD CONSTRAINT tabarticulo_pkey PRIMARY KEY (idart);
 F   ALTER TABLE ONLY public.tabarticulo DROP CONSTRAINT tabarticulo_pkey;
       public            postgres    false    223            �           2606    76534 )   tabcategoria tabcategoria_conseccateg_key 
   CONSTRAINT     k   ALTER TABLE ONLY public.tabcategoria
    ADD CONSTRAINT tabcategoria_conseccateg_key UNIQUE (conseccateg);
 S   ALTER TABLE ONLY public.tabcategoria DROP CONSTRAINT tabcategoria_conseccateg_key;
       public            postgres    false    220            �           2606    76532    tabcategoria tabcategoria_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.tabcategoria
    ADD CONSTRAINT tabcategoria_pkey PRIMARY KEY (idcateg);
 H   ALTER TABLE ONLY public.tabcategoria DROP CONSTRAINT tabcategoria_pkey;
       public            postgres    false    220            �           2606    76486 #   tabcliente tabcliente_conseccli_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.tabcliente
    ADD CONSTRAINT tabcliente_conseccli_key UNIQUE (conseccli);
 M   ALTER TABLE ONLY public.tabcliente DROP CONSTRAINT tabcliente_conseccli_key;
       public            postgres    false    216            �           2606    76484    tabcliente tabcliente_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.tabcliente
    ADD CONSTRAINT tabcliente_pkey PRIMARY KEY (idcli);
 D   ALTER TABLE ONLY public.tabcliente DROP CONSTRAINT tabcliente_pkey;
       public            postgres    false    216            �           2606    76509 3   tabclientejuridico tabclientejuridico_nitclijur_key 
   CONSTRAINT     s   ALTER TABLE ONLY public.tabclientejuridico
    ADD CONSTRAINT tabclientejuridico_nitclijur_key UNIQUE (nitclijur);
 ]   ALTER TABLE ONLY public.tabclientejuridico DROP CONSTRAINT tabclientejuridico_nitclijur_key;
       public            postgres    false    218            �           2606    76507 *   tabclientejuridico tabclientejuridico_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.tabclientejuridico
    ADD CONSTRAINT tabclientejuridico_pkey PRIMARY KEY (idclijur);
 T   ALTER TABLE ONLY public.tabclientejuridico DROP CONSTRAINT tabclientejuridico_pkey;
       public            postgres    false    218            �           2606    76495 4   tabclientenatural tabclientenatural_cedulaclinat_key 
   CONSTRAINT     w   ALTER TABLE ONLY public.tabclientenatural
    ADD CONSTRAINT tabclientenatural_cedulaclinat_key UNIQUE (cedulaclinat);
 ^   ALTER TABLE ONLY public.tabclientenatural DROP CONSTRAINT tabclientenatural_cedulaclinat_key;
       public            postgres    false    217            �           2606    76493 (   tabclientenatural tabclientenatural_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.tabclientenatural
    ADD CONSTRAINT tabclientenatural_pkey PRIMARY KEY (idclinat);
 R   ALTER TABLE ONLY public.tabclientenatural DROP CONSTRAINT tabclientenatural_pkey;
       public            postgres    false    217                       2606    76674 2   tabdetalleventa tabdetalleventa_consecdetventa_key 
   CONSTRAINT     w   ALTER TABLE ONLY public.tabdetalleventa
    ADD CONSTRAINT tabdetalleventa_consecdetventa_key UNIQUE (consecdetventa);
 \   ALTER TABLE ONLY public.tabdetalleventa DROP CONSTRAINT tabdetalleventa_consecdetventa_key;
       public            postgres    false    227                       2606    76672 $   tabdetalleventa tabdetalleventa_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.tabdetalleventa
    ADD CONSTRAINT tabdetalleventa_pkey PRIMARY KEY (iddetventa);
 N   ALTER TABLE ONLY public.tabdetalleventa DROP CONSTRAINT tabdetalleventa_pkey;
       public            postgres    false    227                       2606    76649 5   tabencabezadoventa tabencabezadoventa_consecventa_key 
   CONSTRAINT     w   ALTER TABLE ONLY public.tabencabezadoventa
    ADD CONSTRAINT tabencabezadoventa_consecventa_key UNIQUE (consecventa);
 _   ALTER TABLE ONLY public.tabencabezadoventa DROP CONSTRAINT tabencabezadoventa_consecventa_key;
       public            postgres    false    226                       2606    76647 *   tabencabezadoventa tabencabezadoventa_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.tabencabezadoventa
    ADD CONSTRAINT tabencabezadoventa_pkey PRIMARY KEY (idventa);
 T   ALTER TABLE ONLY public.tabencabezadoventa DROP CONSTRAINT tabencabezadoventa_pkey;
       public            postgres    false    226            �           2606    76600 $   tabkardex tabkardex_conseckardex_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.tabkardex
    ADD CONSTRAINT tabkardex_conseckardex_key UNIQUE (conseckardex);
 N   ALTER TABLE ONLY public.tabkardex DROP CONSTRAINT tabkardex_conseckardex_key;
       public            postgres    false    224            �           2606    76598    tabkardex tabkardex_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.tabkardex
    ADD CONSTRAINT tabkardex_pkey PRIMARY KEY (idkardex);
 B   ALTER TABLE ONLY public.tabkardex DROP CONSTRAINT tabkardex_pkey;
       public            postgres    false    224            �           2606    76549 !   tabmarca tabmarca_consecmarca_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.tabmarca
    ADD CONSTRAINT tabmarca_consecmarca_key UNIQUE (consecmarca);
 K   ALTER TABLE ONLY public.tabmarca DROP CONSTRAINT tabmarca_consecmarca_key;
       public            postgres    false    221            �           2606    76547    tabmarca tabmarca_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.tabmarca
    ADD CONSTRAINT tabmarca_pkey PRIMARY KEY (idmarca);
 @   ALTER TABLE ONLY public.tabmarca DROP CONSTRAINT tabmarca_pkey;
       public            postgres    false    221            �           2606    76524 %   tabproveedor tabproveedor_nitprov_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.tabproveedor
    ADD CONSTRAINT tabproveedor_nitprov_key UNIQUE (nitprov);
 O   ALTER TABLE ONLY public.tabproveedor DROP CONSTRAINT tabproveedor_nitprov_key;
       public            postgres    false    219            �           2606    76522    tabproveedor tabproveedor_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.tabproveedor
    ADD CONSTRAINT tabproveedor_pkey PRIMARY KEY (idprov);
 H   ALTER TABLE ONLY public.tabproveedor DROP CONSTRAINT tabproveedor_pkey;
       public            postgres    false    219            �           2606    76629 ;   tabproveedorarticulo tabproveedorarticulo_consecprovart_key 
   CONSTRAINT        ALTER TABLE ONLY public.tabproveedorarticulo
    ADD CONSTRAINT tabproveedorarticulo_consecprovart_key UNIQUE (consecprovart);
 e   ALTER TABLE ONLY public.tabproveedorarticulo DROP CONSTRAINT tabproveedorarticulo_consecprovart_key;
       public            postgres    false    225                        2606    76627 .   tabproveedorarticulo tabproveedorarticulo_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY public.tabproveedorarticulo
    ADD CONSTRAINT tabproveedorarticulo_pkey PRIMARY KEY (idprovart);
 X   ALTER TABLE ONLY public.tabproveedorarticulo DROP CONSTRAINT tabproveedorarticulo_pkey;
       public            postgres    false    225            �           2606    76558 7   tabproveedormarca tabproveedormarca_consecprovmarca_key 
   CONSTRAINT     }   ALTER TABLE ONLY public.tabproveedormarca
    ADD CONSTRAINT tabproveedormarca_consecprovmarca_key UNIQUE (consecprovmarca);
 a   ALTER TABLE ONLY public.tabproveedormarca DROP CONSTRAINT tabproveedormarca_consecprovmarca_key;
       public            postgres    false    222            �           2606    76556 (   tabproveedormarca tabproveedormarca_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.tabproveedormarca
    ADD CONSTRAINT tabproveedormarca_pkey PRIMARY KEY (idprovmarca);
 R   ALTER TABLE ONLY public.tabproveedormarca DROP CONSTRAINT tabproveedormarca_pkey;
       public            postgres    false    222            
           2606    76691 "   tabregborrados tabregborrados_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.tabregborrados
    ADD CONSTRAINT tabregborrados_pkey PRIMARY KEY (consecreg);
 L   ALTER TABLE ONLY public.tabregborrados DROP CONSTRAINT tabregborrados_pkey;
       public            postgres    false    228            /           2620    76702 #   tabcategoria autoincrementcategoria    TRIGGER     �   CREATE TRIGGER autoincrementcategoria BEFORE INSERT ON public.tabcategoria FOR EACH ROW EXECUTE FUNCTION public.generarconsecutivotabcategoria();
 <   DROP TRIGGER autoincrementcategoria ON public.tabcategoria;
       public          postgres    false    220    230            !           2620    76701    tabcliente autoincrementcliente    TRIGGER     �   CREATE TRIGGER autoincrementcliente BEFORE INSERT ON public.tabcliente FOR EACH ROW EXECUTE FUNCTION public.generarconsecutivotabcliente();
 8   DROP TRIGGER autoincrementcliente ON public.tabcliente;
       public          postgres    false    229    216            Q           2620    76708 )   tabdetalleventa autoincrementdetalleventa    TRIGGER     �   CREATE TRIGGER autoincrementdetalleventa BEFORE INSERT ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.generarconsecutivotabdetalleventa();
 B   DROP TRIGGER autoincrementdetalleventa ON public.tabdetalleventa;
       public          postgres    false    227    236            L           2620    76707 /   tabencabezadoventa autoincrementencabezadoventa    TRIGGER     �   CREATE TRIGGER autoincrementencabezadoventa BEFORE INSERT ON public.tabencabezadoventa FOR EACH ROW EXECUTE FUNCTION public.generarconsecutivotabencabezadoventa();
 H   DROP TRIGGER autoincrementencabezadoventa ON public.tabencabezadoventa;
       public          postgres    false    235    226            A           2620    76705    tabkardex autoincrementkardex    TRIGGER     �   CREATE TRIGGER autoincrementkardex BEFORE INSERT ON public.tabkardex FOR EACH ROW EXECUTE FUNCTION public.generarconsecutivotabkardex();
 6   DROP TRIGGER autoincrementkardex ON public.tabkardex;
       public          postgres    false    233    224            4           2620    76703    tabmarca autoincrementmarca    TRIGGER     �   CREATE TRIGGER autoincrementmarca BEFORE INSERT ON public.tabmarca FOR EACH ROW EXECUTE FUNCTION public.generarconsecutivotabmarca();
 4   DROP TRIGGER autoincrementmarca ON public.tabmarca;
       public          postgres    false    221    231            H           2620    76706 3   tabproveedorarticulo autoincrementproveedorarticulo    TRIGGER     �   CREATE TRIGGER autoincrementproveedorarticulo BEFORE INSERT ON public.tabproveedorarticulo FOR EACH ROW EXECUTE FUNCTION public.generarconsecutivotabproveedorarticulo();
 L   DROP TRIGGER autoincrementproveedorarticulo ON public.tabproveedorarticulo;
       public          postgres    false    225    234            9           2620    76704 -   tabproveedormarca autoincrementproveedormarca    TRIGGER     �   CREATE TRIGGER autoincrementproveedormarca BEFORE INSERT ON public.tabproveedormarca FOR EACH ROW EXECUTE FUNCTION public.generarconsecutivotabproveedormarca();
 F   DROP TRIGGER autoincrementproveedormarca ON public.tabproveedormarca;
       public          postgres    false    222    232            X           2620    76709 '   tabregborrados autoincrementregborrados    TRIGGER     �   CREATE TRIGGER autoincrementregborrados BEFORE INSERT ON public.tabregborrados FOR EACH ROW EXECUTE FUNCTION public.generarconsecutivotabregborrados();
 @   DROP TRIGGER autoincrementregborrados ON public.tabregborrados;
       public          postgres    false    237    228            R           2620    76798 .   tabdetalleventa insertsalidakardexdetalleventa    TRIGGER     �   CREATE TRIGGER insertsalidakardexdetalleventa AFTER INSERT ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.insertsalidakardexdetalleventa();
 G   DROP TRIGGER insertsalidakardexdetalleventa ON public.tabdetalleventa;
       public          postgres    false    285    227                       2620    76779 8   tabadministrador triggeractualizarestadotabadministrador    TRIGGER     �   CREATE TRIGGER triggeractualizarestadotabadministrador BEFORE UPDATE ON public.tabadministrador FOR EACH ROW EXECUTE FUNCTION public.actualizarestado();
 Q   DROP TRIGGER triggeractualizarestadotabadministrador ON public.tabadministrador;
       public          postgres    false    275    215            =           2620    76783 .   tabarticulo triggeractualizarestadotabarticulo    TRIGGER     �   CREATE TRIGGER triggeractualizarestadotabarticulo BEFORE UPDATE ON public.tabarticulo FOR EACH ROW EXECUTE FUNCTION public.actualizarestado();
 G   DROP TRIGGER triggeractualizarestadotabarticulo ON public.tabarticulo;
       public          postgres    false    223    275            0           2620    76781 0   tabcategoria triggeractualizarestadotabcategoria    TRIGGER     �   CREATE TRIGGER triggeractualizarestadotabcategoria BEFORE UPDATE ON public.tabcategoria FOR EACH ROW EXECUTE FUNCTION public.actualizarestado();
 I   DROP TRIGGER triggeractualizarestadotabcategoria ON public.tabcategoria;
       public          postgres    false    275    220            S           2620    76785 6   tabdetalleventa triggeractualizarestadotabdetalleventa    TRIGGER     �   CREATE TRIGGER triggeractualizarestadotabdetalleventa BEFORE UPDATE ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.actualizarestado();
 O   DROP TRIGGER triggeractualizarestadotabdetalleventa ON public.tabdetalleventa;
       public          postgres    false    227    275            M           2620    76784 <   tabencabezadoventa triggeractualizarestadotabencabezadoventa    TRIGGER     �   CREATE TRIGGER triggeractualizarestadotabencabezadoventa BEFORE UPDATE ON public.tabencabezadoventa FOR EACH ROW EXECUTE FUNCTION public.actualizarestado();
 U   DROP TRIGGER triggeractualizarestadotabencabezadoventa ON public.tabencabezadoventa;
       public          postgres    false    275    226            5           2620    76782 (   tabmarca triggeractualizarestadotabmarca    TRIGGER     �   CREATE TRIGGER triggeractualizarestadotabmarca BEFORE UPDATE ON public.tabmarca FOR EACH ROW EXECUTE FUNCTION public.actualizarestado();
 A   DROP TRIGGER triggeractualizarestadotabmarca ON public.tabmarca;
       public          postgres    false    221    275            +           2620    76780 0   tabproveedor triggeractualizarestadotabproveedor    TRIGGER     �   CREATE TRIGGER triggeractualizarestadotabproveedor BEFORE UPDATE ON public.tabproveedor FOR EACH ROW EXECUTE FUNCTION public.actualizarestado();
 I   DROP TRIGGER triggeractualizarestadotabproveedor ON public.tabproveedor;
       public          postgres    false    219    275            B           2620    76777 '   tabkardex triggeractualizarstockvalunit    TRIGGER     �   CREATE TRIGGER triggeractualizarstockvalunit AFTER INSERT ON public.tabkardex FOR EACH ROW EXECUTE FUNCTION public.actualizarstockvalunit();
 @   DROP TRIGGER triggeractualizarstockvalunit ON public.tabkardex;
       public          postgres    false    274    224            C           2620    76793 +   tabkardex triggerinserttabproveedorarticulo    TRIGGER     �   CREATE TRIGGER triggerinserttabproveedorarticulo AFTER INSERT ON public.tabkardex FOR EACH ROW EXECUTE FUNCTION public.inserttabproveedorarticulo();
 D   DROP TRIGGER triggerinserttabproveedorarticulo ON public.tabkardex;
       public          postgres    false    224    282            D           2620    76795 (   tabkardex triggerinserttabproveedormarca    TRIGGER     �   CREATE TRIGGER triggerinserttabproveedormarca AFTER INSERT ON public.tabkardex FOR EACH ROW EXECUTE FUNCTION public.inserttabproveedormarca();
 A   DROP TRIGGER triggerinserttabproveedormarca ON public.tabkardex;
       public          postgres    false    224    283                       2620    76750 (   tabadministrador triggertabadministrador    TRIGGER     �   CREATE TRIGGER triggertabadministrador BEFORE INSERT OR UPDATE ON public.tabadministrador FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 A   DROP TRIGGER triggertabadministrador ON public.tabadministrador;
       public          postgres    false    262    215            >           2620    76764    tabarticulo triggertabarticulo    TRIGGER     �   CREATE TRIGGER triggertabarticulo BEFORE INSERT OR UPDATE ON public.tabarticulo FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 7   DROP TRIGGER triggertabarticulo ON public.tabarticulo;
       public          postgres    false    223    262            1           2620    76760     tabcategoria triggertabcategoria    TRIGGER     �   CREATE TRIGGER triggertabcategoria BEFORE INSERT OR UPDATE ON public.tabcategoria FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 9   DROP TRIGGER triggertabcategoria ON public.tabcategoria;
       public          postgres    false    262    220            "           2620    76752    tabcliente triggertabcliente    TRIGGER     �   CREATE TRIGGER triggertabcliente BEFORE INSERT OR UPDATE ON public.tabcliente FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 5   DROP TRIGGER triggertabcliente ON public.tabcliente;
       public          postgres    false    262    216            (           2620    76756 ,   tabclientejuridico triggertabclientejuridico    TRIGGER     �   CREATE TRIGGER triggertabclientejuridico BEFORE INSERT OR UPDATE ON public.tabclientejuridico FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 E   DROP TRIGGER triggertabclientejuridico ON public.tabclientejuridico;
       public          postgres    false    262    218            %           2620    76754 *   tabclientenatural triggertabclientenatural    TRIGGER     �   CREATE TRIGGER triggertabclientenatural BEFORE INSERT OR UPDATE ON public.tabclientenatural FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 C   DROP TRIGGER triggertabclientenatural ON public.tabclientenatural;
       public          postgres    false    262    217            T           2620    76774 &   tabdetalleventa triggertabdetalleventa    TRIGGER     �   CREATE TRIGGER triggertabdetalleventa BEFORE INSERT OR UPDATE ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 ?   DROP TRIGGER triggertabdetalleventa ON public.tabdetalleventa;
       public          postgres    false    227    262            N           2620    76772 ,   tabencabezadoventa triggertabencabezadoventa    TRIGGER     �   CREATE TRIGGER triggertabencabezadoventa BEFORE INSERT OR UPDATE ON public.tabencabezadoventa FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 E   DROP TRIGGER triggertabencabezadoventa ON public.tabencabezadoventa;
       public          postgres    false    262    226            E           2620    76766    tabkardex triggertabkardex    TRIGGER     �   CREATE TRIGGER triggertabkardex BEFORE INSERT OR UPDATE ON public.tabkardex FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 3   DROP TRIGGER triggertabkardex ON public.tabkardex;
       public          postgres    false    262    224            6           2620    76762    tabmarca triggertabmarca    TRIGGER     �   CREATE TRIGGER triggertabmarca BEFORE INSERT OR UPDATE ON public.tabmarca FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 1   DROP TRIGGER triggertabmarca ON public.tabmarca;
       public          postgres    false    221    262            ,           2620    76758     tabproveedor triggertabproveedor    TRIGGER     �   CREATE TRIGGER triggertabproveedor BEFORE INSERT OR UPDATE ON public.tabproveedor FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 9   DROP TRIGGER triggertabproveedor ON public.tabproveedor;
       public          postgres    false    262    219            I           2620    76768 0   tabproveedorarticulo triggertabproveedorarticulo    TRIGGER     �   CREATE TRIGGER triggertabproveedorarticulo BEFORE INSERT OR UPDATE ON public.tabproveedorarticulo FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 I   DROP TRIGGER triggertabproveedorarticulo ON public.tabproveedorarticulo;
       public          postgres    false    225    262            :           2620    76770 *   tabproveedormarca triggertabproveedormarca    TRIGGER     �   CREATE TRIGGER triggertabproveedormarca BEFORE INSERT OR UPDATE ON public.tabproveedormarca FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 C   DROP TRIGGER triggertabproveedormarca ON public.tabproveedormarca;
       public          postgres    false    222    262                       2620    76751 &   tabadministrador triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabadministrador FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 ?   DROP TRIGGER triggertabregborrados ON public.tabadministrador;
       public          postgres    false    262    215            ?           2620    76765 !   tabarticulo triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabarticulo FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 :   DROP TRIGGER triggertabregborrados ON public.tabarticulo;
       public          postgres    false    223    262            2           2620    76761 "   tabcategoria triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabcategoria FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 ;   DROP TRIGGER triggertabregborrados ON public.tabcategoria;
       public          postgres    false    220    262            #           2620    76753     tabcliente triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabcliente FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 9   DROP TRIGGER triggertabregborrados ON public.tabcliente;
       public          postgres    false    262    216            )           2620    76757 (   tabclientejuridico triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabclientejuridico FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 A   DROP TRIGGER triggertabregborrados ON public.tabclientejuridico;
       public          postgres    false    262    218            &           2620    76755 '   tabclientenatural triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabclientenatural FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 @   DROP TRIGGER triggertabregborrados ON public.tabclientenatural;
       public          postgres    false    262    217            U           2620    76775 %   tabdetalleventa triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 >   DROP TRIGGER triggertabregborrados ON public.tabdetalleventa;
       public          postgres    false    227    262            O           2620    76773 (   tabencabezadoventa triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabencabezadoventa FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 A   DROP TRIGGER triggertabregborrados ON public.tabencabezadoventa;
       public          postgres    false    262    226            F           2620    76767    tabkardex triggertabregborrados    TRIGGER        CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabkardex FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 8   DROP TRIGGER triggertabregborrados ON public.tabkardex;
       public          postgres    false    262    224            7           2620    76763    tabmarca triggertabregborrados    TRIGGER     ~   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabmarca FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 7   DROP TRIGGER triggertabregborrados ON public.tabmarca;
       public          postgres    false    262    221            -           2620    76759 "   tabproveedor triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabproveedor FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 ;   DROP TRIGGER triggertabregborrados ON public.tabproveedor;
       public          postgres    false    262    219            J           2620    76769 *   tabproveedorarticulo triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabproveedorarticulo FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 C   DROP TRIGGER triggertabregborrados ON public.tabproveedorarticulo;
       public          postgres    false    225    262            ;           2620    76771 '   tabproveedormarca triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabproveedormarca FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 @   DROP TRIGGER triggertabregborrados ON public.tabproveedormarca;
       public          postgres    false    262    222            V           2620    76802 ,   tabdetalleventa triggerupdateencabezadoventa    TRIGGER     �   CREATE TRIGGER triggerupdateencabezadoventa AFTER INSERT ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.updateencabezadoventavalpagar();
 E   DROP TRIGGER triggerupdateencabezadoventa ON public.tabdetalleventa;
       public          postgres    false    227    288                        2620    76735 "   tabadministrador uuidadministrador    TRIGGER     �   CREATE TRIGGER uuidadministrador BEFORE INSERT ON public.tabadministrador FOR EACH ROW EXECUTE FUNCTION public.generaruuidtabadministrador();
 ;   DROP TRIGGER uuidadministrador ON public.tabadministrador;
       public          postgres    false    248    215            @           2620    76743    tabarticulo uuidarticulo    TRIGGER        CREATE TRIGGER uuidarticulo BEFORE INSERT ON public.tabarticulo FOR EACH ROW EXECUTE FUNCTION public.generaruuidtabarticulo();
 1   DROP TRIGGER uuidarticulo ON public.tabarticulo;
       public          postgres    false    256    223            3           2620    76740    tabcategoria uuidcategoria    TRIGGER     �   CREATE TRIGGER uuidcategoria BEFORE INSERT ON public.tabcategoria FOR EACH ROW EXECUTE FUNCTION public.generaruuidtabcategoria();
 3   DROP TRIGGER uuidcategoria ON public.tabcategoria;
       public          postgres    false    220    253            $           2620    76736    tabcliente uuidcliente    TRIGGER     |   CREATE TRIGGER uuidcliente BEFORE INSERT ON public.tabcliente FOR EACH ROW EXECUTE FUNCTION public.generaruuidtabcliente();
 /   DROP TRIGGER uuidcliente ON public.tabcliente;
       public          postgres    false    249    216            *           2620    76738 &   tabclientejuridico uuidclientejuridico    TRIGGER     �   CREATE TRIGGER uuidclientejuridico BEFORE INSERT ON public.tabclientejuridico FOR EACH ROW EXECUTE FUNCTION public.generaruuidtabclientejuridico();
 ?   DROP TRIGGER uuidclientejuridico ON public.tabclientejuridico;
       public          postgres    false    218    251            '           2620    76737 $   tabclientenatural uuidclientenatural    TRIGGER     �   CREATE TRIGGER uuidclientenatural BEFORE INSERT ON public.tabclientenatural FOR EACH ROW EXECUTE FUNCTION public.generaruuidtabclientenatural();
 =   DROP TRIGGER uuidclientenatural ON public.tabclientenatural;
       public          postgres    false    250    217            W           2620    76747     tabdetalleventa uuiddetalleventa    TRIGGER     �   CREATE TRIGGER uuiddetalleventa BEFORE INSERT ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.generaruuidtabdetalleventa();
 9   DROP TRIGGER uuiddetalleventa ON public.tabdetalleventa;
       public          postgres    false    227    260            P           2620    76746 &   tabencabezadoventa uuidencabezadoventa    TRIGGER     �   CREATE TRIGGER uuidencabezadoventa BEFORE INSERT ON public.tabencabezadoventa FOR EACH ROW EXECUTE FUNCTION public.generaruuidtabencabezadoventa();
 ?   DROP TRIGGER uuidencabezadoventa ON public.tabencabezadoventa;
       public          postgres    false    226    259            G           2620    76744    tabkardex uuidkardex    TRIGGER     y   CREATE TRIGGER uuidkardex BEFORE INSERT ON public.tabkardex FOR EACH ROW EXECUTE FUNCTION public.generaruuidtabkardex();
 -   DROP TRIGGER uuidkardex ON public.tabkardex;
       public          postgres    false    224    257            8           2620    76741    tabmarca uuidmarca    TRIGGER     v   CREATE TRIGGER uuidmarca BEFORE INSERT ON public.tabmarca FOR EACH ROW EXECUTE FUNCTION public.generaruuidtabmarca();
 +   DROP TRIGGER uuidmarca ON public.tabmarca;
       public          postgres    false    221    254            .           2620    76739    tabproveedor uuidproveedor    TRIGGER     �   CREATE TRIGGER uuidproveedor BEFORE INSERT ON public.tabproveedor FOR EACH ROW EXECUTE FUNCTION public.generaruuidtabproveedor();
 3   DROP TRIGGER uuidproveedor ON public.tabproveedor;
       public          postgres    false    252    219            K           2620    76745 *   tabproveedorarticulo uuidproveedorarticulo    TRIGGER     �   CREATE TRIGGER uuidproveedorarticulo BEFORE INSERT ON public.tabproveedorarticulo FOR EACH ROW EXECUTE FUNCTION public.generaruuidtabproveedorarticulo();
 C   DROP TRIGGER uuidproveedorarticulo ON public.tabproveedorarticulo;
       public          postgres    false    225    258            <           2620    76742 $   tabproveedormarca uuidproveedormarca    TRIGGER     �   CREATE TRIGGER uuidproveedormarca BEFORE INSERT ON public.tabproveedormarca FOR EACH ROW EXECUTE FUNCTION public.generaruuidtabproveedormarca();
 =   DROP TRIGGER uuidproveedormarca ON public.tabproveedormarca;
       public          postgres    false    255    222            Y           2620    76748    tabregborrados uuidregborrados    TRIGGER     �   CREATE TRIGGER uuidregborrados BEFORE INSERT ON public.tabregborrados FOR EACH ROW EXECUTE FUNCTION public.generaruuidtabregborrados();
 7   DROP TRIGGER uuidregborrados ON public.tabregborrados;
       public          postgres    false    228    261                       2606    76535    tabcategoria fkadministrador    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabcategoria
    ADD CONSTRAINT fkadministrador FOREIGN KEY (cedulaadmin) REFERENCES public.tabadministrador(cedulaadmin);
 F   ALTER TABLE ONLY public.tabcategoria DROP CONSTRAINT fkadministrador;
       public          postgres    false    220    215    3286                       2606    76611    tabkardex fkadministrador    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabkardex
    ADD CONSTRAINT fkadministrador FOREIGN KEY (cedulaadmin) REFERENCES public.tabadministrador(cedulaadmin);
 C   ALTER TABLE ONLY public.tabkardex DROP CONSTRAINT fkadministrador;
       public          postgres    false    224    3286    215                       2606    76660 "   tabencabezadoventa fkadministrador    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabencabezadoventa
    ADD CONSTRAINT fkadministrador FOREIGN KEY (cedulaadmin) REFERENCES public.tabadministrador(cedulaadmin);
 L   ALTER TABLE ONLY public.tabencabezadoventa DROP CONSTRAINT fkadministrador;
       public          postgres    false    215    3286    226                       2606    76601    tabkardex fkarticulo    FK CONSTRAINT     |   ALTER TABLE ONLY public.tabkardex
    ADD CONSTRAINT fkarticulo FOREIGN KEY (eanart) REFERENCES public.tabarticulo(eanart);
 >   ALTER TABLE ONLY public.tabkardex DROP CONSTRAINT fkarticulo;
       public          postgres    false    224    223    3318                       2606    76635    tabproveedorarticulo fkarticulo    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabproveedorarticulo
    ADD CONSTRAINT fkarticulo FOREIGN KEY (eanart) REFERENCES public.tabarticulo(eanart);
 I   ALTER TABLE ONLY public.tabproveedorarticulo DROP CONSTRAINT fkarticulo;
       public          postgres    false    225    3318    223                       2606    76680    tabdetalleventa fkarticulo    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabdetalleventa
    ADD CONSTRAINT fkarticulo FOREIGN KEY (eanart) REFERENCES public.tabarticulo(eanart);
 D   ALTER TABLE ONLY public.tabdetalleventa DROP CONSTRAINT fkarticulo;
       public          postgres    false    223    227    3318                       2606    76587    tabarticulo fkcategoria    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabarticulo
    ADD CONSTRAINT fkcategoria FOREIGN KEY (conseccateg) REFERENCES public.tabcategoria(conseccateg);
 A   ALTER TABLE ONLY public.tabarticulo DROP CONSTRAINT fkcategoria;
       public          postgres    false    223    220    3306                       2606    76655 $   tabencabezadoventa fkclientejuridico    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabencabezadoventa
    ADD CONSTRAINT fkclientejuridico FOREIGN KEY (nitclijur) REFERENCES public.tabclientejuridico(nitclijur);
 N   ALTER TABLE ONLY public.tabencabezadoventa DROP CONSTRAINT fkclientejuridico;
       public          postgres    false    3298    218    226                       2606    76650 #   tabencabezadoventa fkclientenatural    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabencabezadoventa
    ADD CONSTRAINT fkclientenatural FOREIGN KEY (cedulaclinat) REFERENCES public.tabclientenatural(cedulaclinat);
 M   ALTER TABLE ONLY public.tabencabezadoventa DROP CONSTRAINT fkclientenatural;
       public          postgres    false    217    226    3294                       2606    76510     tabclientejuridico fkclijuridico    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabclientejuridico
    ADD CONSTRAINT fkclijuridico FOREIGN KEY (conseccli) REFERENCES public.tabcliente(conseccli);
 J   ALTER TABLE ONLY public.tabclientejuridico DROP CONSTRAINT fkclijuridico;
       public          postgres    false    218    3290    216                       2606    76496    tabclientenatural fkclinatural    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabclientenatural
    ADD CONSTRAINT fkclinatural FOREIGN KEY (conseccli) REFERENCES public.tabcliente(conseccli);
 H   ALTER TABLE ONLY public.tabclientenatural DROP CONSTRAINT fkclinatural;
       public          postgres    false    217    3290    216                       2606    76564    tabproveedormarca fkmarca    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabproveedormarca
    ADD CONSTRAINT fkmarca FOREIGN KEY (consecmarca) REFERENCES public.tabmarca(consecmarca);
 C   ALTER TABLE ONLY public.tabproveedormarca DROP CONSTRAINT fkmarca;
       public          postgres    false    222    221    3310                       2606    76582    tabarticulo fkmarca    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabarticulo
    ADD CONSTRAINT fkmarca FOREIGN KEY (consecmarca) REFERENCES public.tabmarca(consecmarca);
 =   ALTER TABLE ONLY public.tabarticulo DROP CONSTRAINT fkmarca;
       public          postgres    false    223    3310    221                       2606    76616    tabkardex fkmarca    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabkardex
    ADD CONSTRAINT fkmarca FOREIGN KEY (consecmarca) REFERENCES public.tabmarca(consecmarca);
 ;   ALTER TABLE ONLY public.tabkardex DROP CONSTRAINT fkmarca;
       public          postgres    false    224    3310    221                       2606    76559    tabproveedormarca fkproveedor    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabproveedormarca
    ADD CONSTRAINT fkproveedor FOREIGN KEY (nitprov) REFERENCES public.tabproveedor(nitprov);
 G   ALTER TABLE ONLY public.tabproveedormarca DROP CONSTRAINT fkproveedor;
       public          postgres    false    3302    222    219                       2606    76606    tabkardex fkproveedor    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabkardex
    ADD CONSTRAINT fkproveedor FOREIGN KEY (nitprov) REFERENCES public.tabproveedor(nitprov);
 ?   ALTER TABLE ONLY public.tabkardex DROP CONSTRAINT fkproveedor;
       public          postgres    false    3302    219    224                       2606    76630     tabproveedorarticulo fkproveedor    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabproveedorarticulo
    ADD CONSTRAINT fkproveedor FOREIGN KEY (nitprov) REFERENCES public.tabproveedor(nitprov);
 J   ALTER TABLE ONLY public.tabproveedorarticulo DROP CONSTRAINT fkproveedor;
       public          postgres    false    3302    225    219                       2606    76675    tabdetalleventa fkventa    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabdetalleventa
    ADD CONSTRAINT fkventa FOREIGN KEY (consecventa) REFERENCES public.tabencabezadoventa(consecventa);
 A   ALTER TABLE ONLY public.tabdetalleventa DROP CONSTRAINT fkventa;
       public          postgres    false    227    226    3330            �   �   x�}���0@��W�%�;�W&���.Ɖ��C��~�,�&ozyy�Dۊ8-^
���u�#it���	ܕt"d�,kMvc�
�bΈ����a���U9a\���~��[��W�v���r��}���/1A}\Qu�����-]      �   �   x����NAE�ٯ�xd{��!�T4(U�y-��ѢI��3$�&B��}���q�e'HX5�RvTpɐ15Z%�,Yz`�!;��$y��c>��E��ĥ�R���$�v����� &����ݽ��t9��Z=}w��Zje�u�gE� �I���!�1Q�.v~%�������P�s�ci�&c;���@e�K����$�@�ޱ�r�O�G`�      �   r   x��;�0 ��9H�O�8�,� �.��%����W�3+�h�1&�]���'�b� 8����n������q�j�d\��%�E.ҙpF�j҂~߱�z�\wa�B��y      �   �   x�}λj�@��z��#�2�]Uw��	ܬv� �-����1I��p�S�|*�A��EEt���\,�"R�w`���g:m��&��Y���5-�-;!
_�����޷�y_k��z�sZ��%۞Zf��M��n�w7�^�kt�1�T�Hf$�#I
N���ف��^�wT��ϣ�e�+��@���6��a�&Ԟ�����5M��Pt      �   m   x�K25O1H1IֵL5I�5I�H�L�u͓��R�,�S�8t��ML�8�8���u,t��ͬ,�L��-�͌�9sJs3��))�/.I/J-��"�=... .�      �   o   x�}�1�0 ��yE?`�8ql�@�NY8�R������n<[��TB%^1�1�bVq�ȴy��ȑ�ę! y��In!O^'�!����W�g���?����~������9��g x      �   x   x�E�1�0Eg�\���8n�X`AL] IQ%�V-ܟ������(j_r�j6�G�\͔�U������yMe^��Z O�?�����#E�~Ƕgiv��2o��Z7�M7tι/�      �   �   x�}�1�0 g�| U�ĉݭB���
1uj�0�(��8�x��<��jqR�!�h�ź�$s]j� �#o�XJ;�-b��8f��p8�S��'��� t*B(���_�����|������m6$�!~36Ƙ�+9      �   F  x���AKC1��ݯ�䑤M��6Ѓ(S��.����Ʀ���n��v�-9���GJ�(b�\�)���>[J/�F��
��ω�(�:
d����iq�08.2���oy�����1a�cx�k��0�2)�s��z��-;�Z�3��fM 5(8�����ɩ�j�H�ql�pN���4^�����-�T@7_d�������5�� c�3����O|���R+xk�8�*�( ���Ֆzo�)�]笨?�/���QNu���>�ea��.��h� ���4���)����6.�</�ouw�m+��*]��c�Dq��f�/����      �   �   x�u�9�0@�z|
.0��xM:("�&�&M۔ ��Eh��~�~�ƓE�kEcZ��(c.�1�B��p��~��C���h���7�:j;K��8fx>���U�k�M���XuZy���5�v��w������^7�����F)���0c      �   �   x���=k�@D�ӯ�^�_w�sc���1I��Z����m�ߏRH�x���I���@�l��a:p�T݇0�Y 3p�RZbYr�z��p�l�VO� ���D����p<�����)X�&o��iX�w��/1/���x�[�?�i�E	� �� j�``��KM�I��S~3%vX2J�G�o��}�4�'�R�      �   �   x�}�Kn�1���)z,�ؘ"'���l����,�V} ��f����fe:6H�M�����m�Q1p@�|�F΀X����Nĉ��jx}��?���/K��lMt��z�Ptv�fȰ�+ڞ��!O��,Iri�K��|tDY���.�]��<�|�Z����tXR�㈿����f$���b��Ri      �   �   x�u�MNC1��)zG�M��t�������j 	�(�W��Ml1bP����D^c��*r�ɜ8!�$J�,��NT�Dg�±�-�����y{�DQd��f���C#��No8�b�c3�I�/+�]d-*�����.��Bm����	����}V�jx��X�����R[��j��؃���\J��Y�L�      �      x������ � �     