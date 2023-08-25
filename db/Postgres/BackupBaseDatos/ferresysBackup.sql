PGDMP     &    %                {            ferresys_testing    15.4    15.4 ~    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16882    ferresys_testing    DATABASE     �   CREATE DATABASE ferresys_testing WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Colombia.1252';
     DROP DATABASE ferresys_testing;
                postgres    false            �            1255    17120    actualizarstockvalunit()    FUNCTION       CREATE FUNCTION public.actualizarstockvalunit() RETURNS trigger
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
       public          postgres    false            �            1255    17122 �   insertadministrador(integer, character varying, character varying, character varying, character varying, character varying, character varying)    FUNCTION     |  CREATE FUNCTION public.insertadministrador(zidadmin integer, znomadmin character varying, zapeadmin character varying, zteladmin character varying, zemailadmin character varying, zusuario character varying, zpassword character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    ZFecReg timestamp := now(); /*tambien puedo usar current_timestamp*/
    
BEGIN

    INSERT INTO tabAdministrador(idAdmin, fecReg, nomAdmin, apeAdmin, telAdmin, emailAdmin, usuario, password)
    VALUES ( zidAdmin, zFecReg, znomAdmin, zapeAdmin, ztelAdmin, zemailAdmin, zUsuario, zPassword);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$;
 �   DROP FUNCTION public.insertadministrador(zidadmin integer, znomadmin character varying, zapeadmin character varying, zteladmin character varying, zemailadmin character varying, zusuario character varying, zpassword character varying);
       public          postgres    false            �            1255    17127 Y   insertarticulo(character varying, character varying, bigint, bigint, text, numeric, date)    FUNCTION     I  CREATE FUNCTION public.insertarticulo(zeanart character varying, znomart character varying, zconsecmarca bigint, zconseccateg bigint, zdescripart text, zporcentaje numeric, zfecvence date) RETURNS void
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
       public          postgres    false            �            1255    17126 +   insertcategoria(character varying, integer)    FUNCTION     �  CREATE FUNCTION public.insertcategoria(znomcateg character varying, zidadmin integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    --zAdmin INTEGER;
BEGIN
    --SELECT idAdmin INTO ZAdmin FROM tabAdministrador;
    INSERT INTO tabCategoria(nomCateg, idAdmin)
    VALUES (zNomCateg, ZIdAdmin);
    --RETURNING idAdmin INTO zAdmin;
    RAISE NOTICE 'Registro exitoso ';
END;
$$;
 U   DROP FUNCTION public.insertcategoria(znomcateg character varying, zidadmin integer);
       public          postgres    false            �            1255    17123 �   insertcliente(character varying, character varying, character varying, character varying, integer, character varying, character varying, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.insertcliente(ztipocli character varying, ztelcli character varying, zemailcli character varying, zdircli character varying, zidcli integer DEFAULT NULL::integer, znomcli character varying DEFAULT NULL::character varying, zapecli character varying DEFAULT NULL::character varying, znitcli character varying DEFAULT NULL::character varying, znomempr character varying DEFAULT NULL::character varying) RETURNS void
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

    IF zTipoCli = 'Natural' THEN
        -- Insertar en la tabla tabClienteNatural
        INSERT INTO tabClienteNatural(idCli, consecCli, fecReg, nomCli, apeCli)
        VALUES (zIdCli, zConsecCli, zFecReg, zNomCli, zApeCli);

    ELSIF zTipoCli = 'Juridico' THEN
        -- Insertar en la tabla tabClienteJuridico
        INSERT INTO tabClienteJuridico(nitCli, consecCli, fecReg, nomEmpr)
        VALUES (zNitCli, zConsecCli, zFecReg, zNomEmpr);
    END IF;

    RAISE NOTICE 'Registro exitoso';
END;
$$;
   DROP FUNCTION public.insertcliente(ztipocli character varying, ztelcli character varying, zemailcli character varying, zdircli character varying, zidcli integer, znomcli character varying, zapecli character varying, znitcli character varying, znomempr character varying);
       public          postgres    false                       1255    17139 .   insertdetalleventa(character varying, integer)    FUNCTION     �  CREATE FUNCTION public.insertdetalleventa(zeanart character varying, zcantart integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    zValUnit NUMERIC(10);
    zSubTotal NUMERIC(10);
    --ziva NUMERIC(10);
    zTotalPagar NUMERIC(10);
    zConsecVenta BIGINT;
BEGIN
    -- Obtener el valor unitario (val_unit) del artículo desde la tabla "tabArticulo"
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
       public          postgres    false                       1255    17136 L   insertencabezadoventajuridico(character varying, character varying, integer)    FUNCTION       CREATE FUNCTION public.insertencabezadoventajuridico(ztipofactura character varying, znitcli character varying, zidadmin integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE 
    zFecVenta TIMESTAMP := current_timestamp;
    zNitClis VARCHAR;
BEGIN
    IF zTipoFactura = 'PRELIMINAR' OR zTipoFactura = 'LEGAL' THEN
        -- Obtener el consecutivo del cliente jurídico
        SELECT nitCli INTO zNitClis FROM tabClienteJuridico WHERE nitCli = zNitCli;

        -- Insertar en la tabla tabEncabezadoVenta
        INSERT INTO tabEncabezadoVenta (fecVenta, tipoFactura, idAdmin, nitCli)
        VALUES (zFecVenta, zTipoFactura, zIdAdmin, zNitClis);

        RAISE NOTICE 'Encabezado de Venta para cliente jurídico registrado con éxito.';
    END IF;
    
    RETURN;
END;
$$;
 �   DROP FUNCTION public.insertencabezadoventajuridico(ztipofactura character varying, znitcli character varying, zidadmin integer);
       public          postgres    false                       1255    17135 A   insertencabezadoventanatural(character varying, integer, integer)    FUNCTION     �  CREATE FUNCTION public.insertencabezadoventanatural(ztipofactura character varying, zidcli integer, zidadmin integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE 
    zFecVenta TIMESTAMP:= current_timestamp;
    zIdClis INTEGER;
	
BEGIN
    IF zTipoFactura = 'PRELIMINAR' OR zTipoFactura = 'LEGAL' THEN
        -- Obtener el consecutivo del cliente natural
        SELECT idCli INTO zIdClis FROM tabClienteNatural WHERE idCli = zIdCli;

        -- Insertar en la tabla tabEncabezadoVenta
        INSERT INTO tabEncabezadoVenta (fecVenta, tipoFactura, idAdmin, idCli)
        VALUES (zFecVenta, zTipoFactura,  zIdAdmin, zIdClis);

        RAISE NOTICE 'Encabezado de Venta para cliente natural registrado con éxito.';
    END IF;
    
    RETURN;
END;
$$;
 u   DROP FUNCTION public.insertencabezadoventanatural(ztipofactura character varying, zidcli integer, zidadmin integer);
       public          postgres    false                       1255    17132 �   insertkardex(character varying, character varying, character varying, integer, numeric, text, character varying, bigint, integer)    FUNCTION     �  CREATE FUNCTION public.insertkardex(ztipomov character varying, zeanart character varying, znomart character varying, zcantart integer, zvalcompra numeric, zobservacion text, znitprov character varying, zconsecmarca bigint, zidadmin integer) RETURNS void
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

    INSERT INTO tabKardex( fecMov, tipoMov, eanArt, nomArt, cantArt, valCompra, valTotal, valProm, observacion, nitProv, consecMarca, idAdmin)
    VALUES (zFecMov, zTipoMov, zEanArt, zNomArt, zCantArt, zValCompra, zValTotal, zValProm, zObservacion, zNitProv, zConsecMarca, zIdAdmin);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$;
 �   DROP FUNCTION public.insertkardex(ztipomov character varying, zeanart character varying, znomart character varying, zcantart integer, zvalcompra numeric, zobservacion text, znitprov character varying, zconsecmarca bigint, zidadmin integer);
       public          postgres    false            �            1255    17125    insertmarca(character varying)    FUNCTION     �   CREATE FUNCTION public.insertmarca(znommarca character varying) RETURNS void
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
       public          postgres    false            �            1255    17124 n   insertproveedor(character varying, character varying, character varying, character varying, character varying)    FUNCTION     !  CREATE FUNCTION public.insertproveedor(znitprov character varying, znomprov character varying, ztelprov character varying, zemailprov character varying, zdirprov character varying) RETURNS void
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
       public          postgres    false                       1255    17133     insertsalidakardexdetalleventa()    FUNCTION     �  CREATE FUNCTION public.insertsalidakardexdetalleventa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO tabKardex (
    fecMov, tipoMov, eanArt, nomArt, cantArt,valCompra, valTotal, valProm, nitProv, consecMarca, idAdmin ) 
	VALUES (now(), 'SALIDA', NEW.eanArt, NEW.nomArt, NEW.cantArt, 0, 0, 0,  
    (SELECT nitProv FROM tabProveedor  LIMIT 1), 
	(SELECT consecMarca FROM tabMarca LIMIT 1),		
    (SELECT idAdmin FROM tabAdministrador LIMIT 1) 
   
  );

  RETURN NEW;
END;
$$;
 7   DROP FUNCTION public.insertsalidakardexdetalleventa();
       public          postgres    false                        1255    17128    inserttabproveedorarticulo()    FUNCTION     �  CREATE FUNCTION public.inserttabproveedorarticulo() RETURNS trigger
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
       public          postgres    false                       1255    17130    inserttabproveedormarca()    FUNCTION     �  CREATE FUNCTION public.inserttabproveedormarca() RETURNS trigger
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
       public          postgres    false            �            1255    17095    movimientosadmin()    FUNCTION     �  CREATE FUNCTION public.movimientosadmin() RETURNS trigger
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
       public          postgres    false                       1255    17137    updateencabezadoventavalpagar()    FUNCTION     2  CREATE FUNCTION public.updateencabezadoventavalpagar() RETURNS trigger
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
       public          postgres    false            �            1259    16884    conseccateg    SEQUENCE     t   CREATE SEQUENCE public.conseccateg
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.conseccateg;
       public          postgres    false            �            1259    16883 	   conseccli    SEQUENCE     r   CREATE SEQUENCE public.conseccli
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
     DROP SEQUENCE public.conseccli;
       public          postgres    false            �            1259    16890    consecdetventa    SEQUENCE     w   CREATE SEQUENCE public.consecdetventa
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.consecdetventa;
       public          postgres    false            �            1259    16888    conseckardex    SEQUENCE     u   CREATE SEQUENCE public.conseckardex
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.conseckardex;
       public          postgres    false            �            1259    16885    consecmarca    SEQUENCE     t   CREATE SEQUENCE public.consecmarca
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.consecmarca;
       public          postgres    false            �            1259    16887    consecprovart    SEQUENCE     v   CREATE SEQUENCE public.consecprovart
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.consecprovart;
       public          postgres    false            �            1259    16886    consecprovmarca    SEQUENCE     x   CREATE SEQUENCE public.consecprovmarca
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.consecprovmarca;
       public          postgres    false            �            1259    16891 	   consecreg    SEQUENCE     r   CREATE SEQUENCE public.consecreg
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
     DROP SEQUENCE public.consecreg;
       public          postgres    false            �            1259    16889    consecventa    SEQUENCE     t   CREATE SEQUENCE public.consecventa
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.consecventa;
       public          postgres    false            �            1259    16892    tabadministrador    TABLE     :  CREATE TABLE public.tabadministrador (
    idadmin integer NOT NULL,
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
       public         heap    postgres    false            �            1259    16981    tabarticulo    TABLE     �  CREATE TABLE public.tabarticulo (
    eanart character varying NOT NULL,
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
       public         heap    postgres    false            �            1259    16940    tabcategoria    TABLE     �  CREATE TABLE public.tabcategoria (
    conseccateg bigint DEFAULT nextval('public.conseccateg'::regclass) NOT NULL,
    nomcateg character varying NOT NULL,
    estado text DEFAULT 'ACTIVO'::text NOT NULL,
    idadmin integer NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
     DROP TABLE public.tabcategoria;
       public         heap    postgres    false    215            �            1259    16900 
   tabcliente    TABLE     @  CREATE TABLE public.tabcliente (
    conseccli bigint DEFAULT nextval('public.conseccli'::regclass) NOT NULL,
    fecreg timestamp without time zone NOT NULL,
    tipocli character varying NOT NULL,
    telcli character varying NOT NULL,
    emailcli character varying NOT NULL,
    dircli character varying NOT NULL
);
    DROP TABLE public.tabcliente;
       public         heap    postgres    false    214            �            1259    16920    tabclientejuridico    TABLE     d  CREATE TABLE public.tabclientejuridico (
    nitcli character varying NOT NULL,
    conseccli bigint NOT NULL,
    fecreg timestamp without time zone NOT NULL,
    nomempr character varying NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
 &   DROP TABLE public.tabclientejuridico;
       public         heap    postgres    false            �            1259    16908    tabclientenatural    TABLE     ~  CREATE TABLE public.tabclientenatural (
    idcli integer NOT NULL,
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
       public         heap    postgres    false            �            1259    17067    tabdetalleventa    TABLE     G  CREATE TABLE public.tabdetalleventa (
    consecdetventa bigint DEFAULT nextval('public.consecdetventa'::regclass) NOT NULL,
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
       public         heap    postgres    false    221            �            1259    17043    tabencabezadoventa    TABLE       CREATE TABLE public.tabencabezadoventa (
    consecventa bigint DEFAULT nextval('public.consecventa'::regclass) NOT NULL,
    fecventa timestamp without time zone NOT NULL,
    tipofactura character varying NOT NULL,
    idcli integer,
    nitcli character varying,
    totalpagar numeric(10,0),
    idadmin integer NOT NULL,
    estado text DEFAULT 'ACTIVO'::text NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
 &   DROP TABLE public.tabencabezadoventa;
       public         heap    postgres    false    220            �            1259    17002 	   tabkardex    TABLE     �  CREATE TABLE public.tabkardex (
    conseckardex bigint DEFAULT nextval('public.conseckardex'::regclass) NOT NULL,
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
    idadmin integer NOT NULL,
    consecmarca bigint NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
    DROP TABLE public.tabkardex;
       public         heap    postgres    false    219            �            1259    16954    tabmarca    TABLE     f  CREATE TABLE public.tabmarca (
    consecmarca bigint DEFAULT nextval('public.consecmarca'::regclass) NOT NULL,
    nommarca character varying NOT NULL,
    estado text DEFAULT 'ACTIVO'::text NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
    DROP TABLE public.tabmarca;
       public         heap    postgres    false    216            �            1259    16932    tabproveedor    TABLE     �  CREATE TABLE public.tabproveedor (
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
       public         heap    postgres    false            �            1259    17025    tabproveedorarticulo    TABLE     k  CREATE TABLE public.tabproveedorarticulo (
    consecprovart bigint DEFAULT nextval('public.consecprovart'::regclass) NOT NULL,
    nitprov character varying NOT NULL,
    eanart character varying NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
 (   DROP TABLE public.tabproveedorarticulo;
       public         heap    postgres    false    218            �            1259    16963    tabproveedormarca    TABLE     f  CREATE TABLE public.tabproveedormarca (
    consecprovmarca bigint DEFAULT nextval('public.consecprovmarca'::regclass) NOT NULL,
    nitprov character varying NOT NULL,
    consecmarca bigint NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
 %   DROP TABLE public.tabproveedormarca;
       public         heap    postgres    false    217            �            1259    17086    tabregborrados    TABLE     �   CREATE TABLE public.tabregborrados (
    consecreg bigint DEFAULT nextval('public.consecreg'::regclass) NOT NULL,
    fecdelete timestamp without time zone,
    userdelete character varying NOT NULL,
    nomtabla character varying NOT NULL
);
 "   DROP TABLE public.tabregborrados;
       public         heap    postgres    false    222            �          0    16892    tabadministrador 
   TABLE DATA           �   COPY public.tabadministrador (idadmin, fecreg, nomadmin, apeadmin, teladmin, emailadmin, usuario, password, estado, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    223   �       �          0    16981    tabarticulo 
   TABLE DATA           �   COPY public.tabarticulo (eanart, fecreg, nomart, consecmarca, conseccateg, descripart, valunit, porcentaje, valstock, stockmin, stockmax, valreorden, fecvence, estado, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    231   0�       �          0    16940    tabcategoria 
   TABLE DATA           |   COPY public.tabcategoria (conseccateg, nomcateg, estado, idadmin, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    228   M�       �          0    16900 
   tabcliente 
   TABLE DATA           Z   COPY public.tabcliente (conseccli, fecreg, tipocli, telcli, emailcli, dircli) FROM stdin;
    public          postgres    false    224   j�       �          0    16920    tabclientejuridico 
   TABLE DATA           ~   COPY public.tabclientejuridico (nitcli, conseccli, fecreg, nomempr, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    226   ��       �          0    16908    tabclientenatural 
   TABLE DATA           �   COPY public.tabclientenatural (idcli, conseccli, fecreg, nomcli, apecli, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    225   ��       �          0    17067    tabdetalleventa 
   TABLE DATA           �   COPY public.tabdetalleventa (consecdetventa, consecventa, eanart, nomart, cantart, valunit, subtotal, totalpagar, estado, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    235   ��       �          0    17043    tabencabezadoventa 
   TABLE DATA           �   COPY public.tabencabezadoventa (consecventa, fecventa, tipofactura, idcli, nitcli, totalpagar, idadmin, estado, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    234   ��       �          0    17002 	   tabkardex 
   TABLE DATA           �   COPY public.tabkardex (conseckardex, fecmov, tipomov, eanart, nomart, cantart, valcompra, valtotal, valprom, observacion, nitprov, idadmin, consecmarca, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    232   ��       �          0    16954    tabmarca 
   TABLE DATA           o   COPY public.tabmarca (consecmarca, nommarca, estado, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    229   �       �          0    16932    tabproveedor 
   TABLE DATA           �   COPY public.tabproveedor (nitprov, fecreg, nomprov, telprov, emailprov, dirprov, estado, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    227   5�       �          0    17025    tabproveedorarticulo 
   TABLE DATA           |   COPY public.tabproveedorarticulo (consecprovart, nitprov, eanart, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    233   R�       �          0    16963    tabproveedormarca 
   TABLE DATA           �   COPY public.tabproveedormarca (consecprovmarca, nitprov, consecmarca, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    230   o�       �          0    17086    tabregborrados 
   TABLE DATA           T   COPY public.tabregborrados (consecreg, fecdelete, userdelete, nomtabla) FROM stdin;
    public          postgres    false    236   ��       �           0    0    conseccateg    SEQUENCE SET     :   SELECT pg_catalog.setval('public.conseccateg', 1, false);
          public          postgres    false    215            �           0    0 	   conseccli    SEQUENCE SET     8   SELECT pg_catalog.setval('public.conseccli', 1, false);
          public          postgres    false    214            �           0    0    consecdetventa    SEQUENCE SET     =   SELECT pg_catalog.setval('public.consecdetventa', 1, false);
          public          postgres    false    221            �           0    0    conseckardex    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.conseckardex', 1, false);
          public          postgres    false    219            �           0    0    consecmarca    SEQUENCE SET     :   SELECT pg_catalog.setval('public.consecmarca', 1, false);
          public          postgres    false    216            �           0    0    consecprovart    SEQUENCE SET     <   SELECT pg_catalog.setval('public.consecprovart', 1, false);
          public          postgres    false    218            �           0    0    consecprovmarca    SEQUENCE SET     >   SELECT pg_catalog.setval('public.consecprovmarca', 1, false);
          public          postgres    false    217            �           0    0 	   consecreg    SEQUENCE SET     8   SELECT pg_catalog.setval('public.consecreg', 1, false);
          public          postgres    false    222            �           0    0    consecventa    SEQUENCE SET     :   SELECT pg_catalog.setval('public.consecventa', 1, false);
          public          postgres    false    220            �           2606    16899 &   tabadministrador tabadministrador_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.tabadministrador
    ADD CONSTRAINT tabadministrador_pkey PRIMARY KEY (idadmin);
 P   ALTER TABLE ONLY public.tabadministrador DROP CONSTRAINT tabadministrador_pkey;
       public            postgres    false    223            �           2606    16991    tabarticulo tabarticulo_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.tabarticulo
    ADD CONSTRAINT tabarticulo_pkey PRIMARY KEY (eanart);
 F   ALTER TABLE ONLY public.tabarticulo DROP CONSTRAINT tabarticulo_pkey;
       public            postgres    false    231            �           2606    16948    tabcategoria tabcategoria_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.tabcategoria
    ADD CONSTRAINT tabcategoria_pkey PRIMARY KEY (conseccateg);
 H   ALTER TABLE ONLY public.tabcategoria DROP CONSTRAINT tabcategoria_pkey;
       public            postgres    false    228            �           2606    16907    tabcliente tabcliente_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.tabcliente
    ADD CONSTRAINT tabcliente_pkey PRIMARY KEY (conseccli);
 D   ALTER TABLE ONLY public.tabcliente DROP CONSTRAINT tabcliente_pkey;
       public            postgres    false    224            �           2606    16926 *   tabclientejuridico tabclientejuridico_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.tabclientejuridico
    ADD CONSTRAINT tabclientejuridico_pkey PRIMARY KEY (nitcli);
 T   ALTER TABLE ONLY public.tabclientejuridico DROP CONSTRAINT tabclientejuridico_pkey;
       public            postgres    false    226            �           2606    16914 (   tabclientenatural tabclientenatural_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.tabclientenatural
    ADD CONSTRAINT tabclientenatural_pkey PRIMARY KEY (idcli);
 R   ALTER TABLE ONLY public.tabclientenatural DROP CONSTRAINT tabclientenatural_pkey;
       public            postgres    false    225            �           2606    17075 $   tabdetalleventa tabdetalleventa_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.tabdetalleventa
    ADD CONSTRAINT tabdetalleventa_pkey PRIMARY KEY (consecdetventa);
 N   ALTER TABLE ONLY public.tabdetalleventa DROP CONSTRAINT tabdetalleventa_pkey;
       public            postgres    false    235            �           2606    17051 *   tabencabezadoventa tabencabezadoventa_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.tabencabezadoventa
    ADD CONSTRAINT tabencabezadoventa_pkey PRIMARY KEY (consecventa);
 T   ALTER TABLE ONLY public.tabencabezadoventa DROP CONSTRAINT tabencabezadoventa_pkey;
       public            postgres    false    234            �           2606    17009    tabkardex tabkardex_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.tabkardex
    ADD CONSTRAINT tabkardex_pkey PRIMARY KEY (conseckardex);
 B   ALTER TABLE ONLY public.tabkardex DROP CONSTRAINT tabkardex_pkey;
       public            postgres    false    232            �           2606    16962    tabmarca tabmarca_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.tabmarca
    ADD CONSTRAINT tabmarca_pkey PRIMARY KEY (consecmarca);
 @   ALTER TABLE ONLY public.tabmarca DROP CONSTRAINT tabmarca_pkey;
       public            postgres    false    229            �           2606    16939    tabproveedor tabproveedor_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.tabproveedor
    ADD CONSTRAINT tabproveedor_pkey PRIMARY KEY (nitprov);
 H   ALTER TABLE ONLY public.tabproveedor DROP CONSTRAINT tabproveedor_pkey;
       public            postgres    false    227            �           2606    17032 .   tabproveedorarticulo tabproveedorarticulo_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY public.tabproveedorarticulo
    ADD CONSTRAINT tabproveedorarticulo_pkey PRIMARY KEY (consecprovart);
 X   ALTER TABLE ONLY public.tabproveedorarticulo DROP CONSTRAINT tabproveedorarticulo_pkey;
       public            postgres    false    233            �           2606    16970 (   tabproveedormarca tabproveedormarca_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY public.tabproveedormarca
    ADD CONSTRAINT tabproveedormarca_pkey PRIMARY KEY (consecprovmarca);
 R   ALTER TABLE ONLY public.tabproveedormarca DROP CONSTRAINT tabproveedormarca_pkey;
       public            postgres    false    230            �           2606    17093 "   tabregborrados tabregborrados_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.tabregborrados
    ADD CONSTRAINT tabregborrados_pkey PRIMARY KEY (consecreg);
 L   ALTER TABLE ONLY public.tabregborrados DROP CONSTRAINT tabregborrados_pkey;
       public            postgres    false    236            
           2620    17134 .   tabdetalleventa insertsalidakardexdetalleventa    TRIGGER     �   CREATE TRIGGER insertsalidakardexdetalleventa AFTER INSERT ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.insertsalidakardexdetalleventa();
 G   DROP TRIGGER insertsalidakardexdetalleventa ON public.tabdetalleventa;
       public          postgres    false    235    259                       2620    17121 '   tabkardex triggeractualizarstockvalunit    TRIGGER     �   CREATE TRIGGER triggeractualizarstockvalunit AFTER INSERT ON public.tabkardex FOR EACH ROW EXECUTE FUNCTION public.actualizarstockvalunit();
 @   DROP TRIGGER triggeractualizarstockvalunit ON public.tabkardex;
       public          postgres    false    232    238                       2620    17129 +   tabkardex triggerinserttabproveedorarticulo    TRIGGER     �   CREATE TRIGGER triggerinserttabproveedorarticulo AFTER INSERT ON public.tabkardex FOR EACH ROW EXECUTE FUNCTION public.inserttabproveedorarticulo();
 D   DROP TRIGGER triggerinserttabproveedorarticulo ON public.tabkardex;
       public          postgres    false    232    256                       2620    17131 (   tabkardex triggerinserttabproveedormarca    TRIGGER     �   CREATE TRIGGER triggerinserttabproveedormarca AFTER INSERT ON public.tabkardex FOR EACH ROW EXECUTE FUNCTION public.inserttabproveedormarca();
 A   DROP TRIGGER triggerinserttabproveedormarca ON public.tabkardex;
       public          postgres    false    232    257            �           2620    17096 (   tabadministrador triggertabadministrador    TRIGGER     �   CREATE TRIGGER triggertabadministrador BEFORE INSERT OR UPDATE ON public.tabadministrador FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 A   DROP TRIGGER triggertabadministrador ON public.tabadministrador;
       public          postgres    false    237    223            �           2620    17108    tabarticulo triggertabarticulo    TRIGGER     �   CREATE TRIGGER triggertabarticulo BEFORE INSERT OR UPDATE ON public.tabarticulo FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 7   DROP TRIGGER triggertabarticulo ON public.tabarticulo;
       public          postgres    false    237    231            �           2620    17104     tabcategoria triggertabcategoria    TRIGGER     �   CREATE TRIGGER triggertabcategoria BEFORE INSERT OR UPDATE ON public.tabcategoria FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 9   DROP TRIGGER triggertabcategoria ON public.tabcategoria;
       public          postgres    false    237    228            �           2620    17100 ,   tabclientejuridico triggertabclientejuridico    TRIGGER     �   CREATE TRIGGER triggertabclientejuridico BEFORE INSERT OR UPDATE ON public.tabclientejuridico FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 E   DROP TRIGGER triggertabclientejuridico ON public.tabclientejuridico;
       public          postgres    false    226    237            �           2620    17098 *   tabclientenatural triggertabclientenatural    TRIGGER     �   CREATE TRIGGER triggertabclientenatural BEFORE INSERT OR UPDATE ON public.tabclientenatural FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 C   DROP TRIGGER triggertabclientenatural ON public.tabclientenatural;
       public          postgres    false    225    237                       2620    17118 &   tabdetalleventa triggertabdetalleventa    TRIGGER     �   CREATE TRIGGER triggertabdetalleventa BEFORE INSERT OR UPDATE ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 ?   DROP TRIGGER triggertabdetalleventa ON public.tabdetalleventa;
       public          postgres    false    235    237                       2620    17116 ,   tabencabezadoventa triggertabencabezadoventa    TRIGGER     �   CREATE TRIGGER triggertabencabezadoventa BEFORE INSERT OR UPDATE ON public.tabencabezadoventa FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 E   DROP TRIGGER triggertabencabezadoventa ON public.tabencabezadoventa;
       public          postgres    false    237    234                       2620    17110    tabkardex triggertabkardex    TRIGGER     �   CREATE TRIGGER triggertabkardex BEFORE INSERT OR UPDATE ON public.tabkardex FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 3   DROP TRIGGER triggertabkardex ON public.tabkardex;
       public          postgres    false    237    232            �           2620    17106    tabmarca triggertabmarca    TRIGGER     �   CREATE TRIGGER triggertabmarca BEFORE INSERT OR UPDATE ON public.tabmarca FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 1   DROP TRIGGER triggertabmarca ON public.tabmarca;
       public          postgres    false    237    229            �           2620    17102     tabproveedor triggertabproveedor    TRIGGER     �   CREATE TRIGGER triggertabproveedor BEFORE INSERT OR UPDATE ON public.tabproveedor FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 9   DROP TRIGGER triggertabproveedor ON public.tabproveedor;
       public          postgres    false    227    237                       2620    17112 0   tabproveedorarticulo triggertabproveedorarticulo    TRIGGER     �   CREATE TRIGGER triggertabproveedorarticulo BEFORE INSERT OR UPDATE ON public.tabproveedorarticulo FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 I   DROP TRIGGER triggertabproveedorarticulo ON public.tabproveedorarticulo;
       public          postgres    false    237    233            �           2620    17114 *   tabproveedormarca triggertabproveedormarca    TRIGGER     �   CREATE TRIGGER triggertabproveedormarca BEFORE INSERT OR UPDATE ON public.tabproveedormarca FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 C   DROP TRIGGER triggertabproveedormarca ON public.tabproveedormarca;
       public          postgres    false    237    230            �           2620    17097 &   tabadministrador triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabadministrador FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 ?   DROP TRIGGER triggertabregborrados ON public.tabadministrador;
       public          postgres    false    223    237                        2620    17109 !   tabarticulo triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabarticulo FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 :   DROP TRIGGER triggertabregborrados ON public.tabarticulo;
       public          postgres    false    237    231            �           2620    17105 "   tabcategoria triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabcategoria FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 ;   DROP TRIGGER triggertabregborrados ON public.tabcategoria;
       public          postgres    false    237    228            �           2620    17101 (   tabclientejuridico triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabclientejuridico FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 A   DROP TRIGGER triggertabregborrados ON public.tabclientejuridico;
       public          postgres    false    237    226            �           2620    17099 '   tabclientenatural triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabclientenatural FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 @   DROP TRIGGER triggertabregborrados ON public.tabclientenatural;
       public          postgres    false    225    237                       2620    17119 %   tabdetalleventa triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 >   DROP TRIGGER triggertabregborrados ON public.tabdetalleventa;
       public          postgres    false    235    237            	           2620    17117 (   tabencabezadoventa triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabencabezadoventa FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 A   DROP TRIGGER triggertabregborrados ON public.tabencabezadoventa;
       public          postgres    false    234    237                       2620    17111    tabkardex triggertabregborrados    TRIGGER        CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabkardex FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 8   DROP TRIGGER triggertabregborrados ON public.tabkardex;
       public          postgres    false    237    232            �           2620    17107    tabmarca triggertabregborrados    TRIGGER     ~   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabmarca FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 7   DROP TRIGGER triggertabregborrados ON public.tabmarca;
       public          postgres    false    237    229            �           2620    17103 "   tabproveedor triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabproveedor FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 ;   DROP TRIGGER triggertabregborrados ON public.tabproveedor;
       public          postgres    false    227    237                       2620    17113 *   tabproveedorarticulo triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabproveedorarticulo FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 C   DROP TRIGGER triggertabregborrados ON public.tabproveedorarticulo;
       public          postgres    false    237    233            �           2620    17115 '   tabproveedormarca triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabproveedormarca FOR EACH ROW EXECUTE FUNCTION public.movimientosadmin();
 @   DROP TRIGGER triggertabregborrados ON public.tabproveedormarca;
       public          postgres    false    237    230                       2620    17138 ,   tabdetalleventa triggerupdateencabezadoventa    TRIGGER     �   CREATE TRIGGER triggerupdateencabezadoventa AFTER INSERT ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.updateencabezadoventavalpagar();
 E   DROP TRIGGER triggerupdateencabezadoventa ON public.tabdetalleventa;
       public          postgres    false    235    262            �           2606    16949    tabcategoria fkadministrador    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabcategoria
    ADD CONSTRAINT fkadministrador FOREIGN KEY (idadmin) REFERENCES public.tabadministrador(idadmin);
 F   ALTER TABLE ONLY public.tabcategoria DROP CONSTRAINT fkadministrador;
       public          postgres    false    223    3269    228            �           2606    17020    tabkardex fkadministrador    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabkardex
    ADD CONSTRAINT fkadministrador FOREIGN KEY (idadmin) REFERENCES public.tabadministrador(idadmin);
 C   ALTER TABLE ONLY public.tabkardex DROP CONSTRAINT fkadministrador;
       public          postgres    false    3269    223    232            �           2606    17062 "   tabencabezadoventa fkadministrador    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabencabezadoventa
    ADD CONSTRAINT fkadministrador FOREIGN KEY (idadmin) REFERENCES public.tabadministrador(idadmin);
 L   ALTER TABLE ONLY public.tabencabezadoventa DROP CONSTRAINT fkadministrador;
       public          postgres    false    223    3269    234            �           2606    17010    tabkardex fkarticulo    FK CONSTRAINT     |   ALTER TABLE ONLY public.tabkardex
    ADD CONSTRAINT fkarticulo FOREIGN KEY (eanart) REFERENCES public.tabarticulo(eanart);
 >   ALTER TABLE ONLY public.tabkardex DROP CONSTRAINT fkarticulo;
       public          postgres    false    231    3285    232            �           2606    17038    tabproveedorarticulo fkarticulo    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabproveedorarticulo
    ADD CONSTRAINT fkarticulo FOREIGN KEY (eanart) REFERENCES public.tabarticulo(eanart);
 I   ALTER TABLE ONLY public.tabproveedorarticulo DROP CONSTRAINT fkarticulo;
       public          postgres    false    3285    231    233            �           2606    17081    tabdetalleventa fkarticulo    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabdetalleventa
    ADD CONSTRAINT fkarticulo FOREIGN KEY (eanart) REFERENCES public.tabarticulo(eanart);
 D   ALTER TABLE ONLY public.tabdetalleventa DROP CONSTRAINT fkarticulo;
       public          postgres    false    235    231    3285            �           2606    16997    tabarticulo fkcategoria    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabarticulo
    ADD CONSTRAINT fkcategoria FOREIGN KEY (conseccateg) REFERENCES public.tabcategoria(conseccateg);
 A   ALTER TABLE ONLY public.tabarticulo DROP CONSTRAINT fkcategoria;
       public          postgres    false    231    3279    228            �           2606    17057 $   tabencabezadoventa fkclientejuridico    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabencabezadoventa
    ADD CONSTRAINT fkclientejuridico FOREIGN KEY (nitcli) REFERENCES public.tabclientejuridico(nitcli);
 N   ALTER TABLE ONLY public.tabencabezadoventa DROP CONSTRAINT fkclientejuridico;
       public          postgres    false    226    3275    234            �           2606    17052 #   tabencabezadoventa fkclientenatural    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabencabezadoventa
    ADD CONSTRAINT fkclientenatural FOREIGN KEY (idcli) REFERENCES public.tabclientenatural(idcli);
 M   ALTER TABLE ONLY public.tabencabezadoventa DROP CONSTRAINT fkclientenatural;
       public          postgres    false    3273    234    225            �           2606    16927     tabclientejuridico fkclijuridico    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabclientejuridico
    ADD CONSTRAINT fkclijuridico FOREIGN KEY (conseccli) REFERENCES public.tabcliente(conseccli);
 J   ALTER TABLE ONLY public.tabclientejuridico DROP CONSTRAINT fkclijuridico;
       public          postgres    false    224    226    3271            �           2606    16915    tabclientenatural fkclinatural    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabclientenatural
    ADD CONSTRAINT fkclinatural FOREIGN KEY (conseccli) REFERENCES public.tabcliente(conseccli);
 H   ALTER TABLE ONLY public.tabclientenatural DROP CONSTRAINT fkclinatural;
       public          postgres    false    225    3271    224            �           2606    16976    tabproveedormarca fkmarca    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabproveedormarca
    ADD CONSTRAINT fkmarca FOREIGN KEY (consecmarca) REFERENCES public.tabmarca(consecmarca);
 C   ALTER TABLE ONLY public.tabproveedormarca DROP CONSTRAINT fkmarca;
       public          postgres    false    230    229    3281            �           2606    16992    tabarticulo fkmarca    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabarticulo
    ADD CONSTRAINT fkmarca FOREIGN KEY (consecmarca) REFERENCES public.tabmarca(consecmarca);
 =   ALTER TABLE ONLY public.tabarticulo DROP CONSTRAINT fkmarca;
       public          postgres    false    3281    231    229            �           2606    16971    tabproveedormarca fkproveedor    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabproveedormarca
    ADD CONSTRAINT fkproveedor FOREIGN KEY (nitprov) REFERENCES public.tabproveedor(nitprov);
 G   ALTER TABLE ONLY public.tabproveedormarca DROP CONSTRAINT fkproveedor;
       public          postgres    false    230    227    3277            �           2606    17015    tabkardex fkproveedor    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabkardex
    ADD CONSTRAINT fkproveedor FOREIGN KEY (nitprov) REFERENCES public.tabproveedor(nitprov);
 ?   ALTER TABLE ONLY public.tabkardex DROP CONSTRAINT fkproveedor;
       public          postgres    false    232    227    3277            �           2606    17033     tabproveedorarticulo fkproveedor    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabproveedorarticulo
    ADD CONSTRAINT fkproveedor FOREIGN KEY (nitprov) REFERENCES public.tabproveedor(nitprov);
 J   ALTER TABLE ONLY public.tabproveedorarticulo DROP CONSTRAINT fkproveedor;
       public          postgres    false    227    233    3277            �           2606    17076    tabdetalleventa fkventa    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabdetalleventa
    ADD CONSTRAINT fkventa FOREIGN KEY (consecventa) REFERENCES public.tabencabezadoventa(consecventa);
 A   ALTER TABLE ONLY public.tabdetalleventa DROP CONSTRAINT fkventa;
       public          postgres    false    3291    235    234            �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �     