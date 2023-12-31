PGDMP         $                {         
   ferresysDB    15.5    15.5 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    34154 
   ferresysDB    DATABASE        CREATE DATABASE "ferresysDB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Spain.1252';
    DROP DATABASE "ferresysDB";
                postgres    false                        3079    34362 	   uuid-ossp 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
    DROP EXTENSION "uuid-ossp";
                   false            �           0    0    EXTENSION "uuid-ossp"    COMMENT     W   COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
                        false    2                       1255    34416     actualizarstockvalunitentradas()    FUNCTION     �  CREATE FUNCTION public.actualizarstockvalunitentradas() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  zValStock tabArticulo.valStock%type;
  zValUnit tabArticulo.valUnit%type;
  zPorcentaje tabArticulo.porcentaje%type;
  zValPromedio tabKardex.valprom%type;
  
BEGIN

select sum(valProm ) into zValPromedio from tabKardex WHERE eanArt = NEW.eanArt;
select Porcentaje into zPorcentaje from tabArticulo where eanArt = NEW.eanArt;
 
zValStock := (SELECT COALESCE(valStock, 0) + NEW.cantArt FROM tabArticulo WHERE eanArt = NEW.eanArt);
zValUnit :=zValPromedio* zPorcentaje ;
    

UPDATE tabArticulo SET valStock = zValStock, valUnit = zValUnit WHERE eanArt = NEW.eanArt;

RETURN NEW;
END;
$$;
 7   DROP FUNCTION public.actualizarstockvalunitentradas();
       public          postgres    false                       1255    34418    actualizarstockvalunitsalidas()    FUNCTION     �  CREATE FUNCTION public.actualizarstockvalunitsalidas() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  zValStock tabArticulo.valStock%type;
  zValUnit tabArticulo.valUnit%type;
  
BEGIN

      zValStock := (SELECT COALESCE(valStock, 0) - NEW.cantArt FROM tabArticulo WHERE eanArt = NEW.eanArt);
      zValUnit := (SELECT valUnit FROM tabArticulo WHERE eanArt = NEW.eanArt);
  

  UPDATE tabArticulo SET valStock = zValStock, valUnit = zValUnit WHERE eanArt = NEW.eanArt;

RETURN NEW;
END;
$$;
 6   DROP FUNCTION public.actualizarstockvalunitsalidas();
       public          postgres    false                       1255    34426 2   asignarpermisousuario(character varying, smallint)    FUNCTION     �  CREATE FUNCTION public.asignarpermisousuario(zidusuario character varying, zconsecpermiso smallint) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN

    -- Verificamos si el usuario y el permiso ya  existen en la db.
    IF NOT EXISTS (SELECT 1 FROM tabUsuario WHERE idUsuario = zIdUsuario) THEN
       RAISE EXCEPTION 'Usuario no existe: %', zIdUsuario;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM tabPermiso WHERE consecPermiso = zConsecPermiso) THEN
       RAISE EXCEPTION 'No existe un permiso: %', zConsecPermiso;
    END IF;
	
	IF EXISTS (SELECT idUsuario FROM tabUsuarioPermiso WHERE idUsuario=zIdUsuario and consecPermiso <> zConsecPermiso) THEN
	  --se continua con la insercion del nuevo permiso para el mismo usuario.
	END IF;
	
	IF EXISTS (SELECT idUsuario FROM tabUsuarioPermiso WHERE idUsuario=zIdUsuario and consecPermiso = zConsecPermiso) THEN
	   RAISE EXCEPTION 'Usuario ya tiene permisos asignados: %', zConsecPermiso;
	END IF;
	
	-- Insertamos el registro en tabUsuarioPermiso
    INSERT INTO tabUsuarioPermiso (idUsuario, consecPermiso)
    VALUES (zIdUsuario, zConsecPermiso);

    RAISE NOTICE 'Permiso asignado con éxito';
	
	
END;
$$;
 c   DROP FUNCTION public.asignarpermisousuario(zidusuario character varying, zconsecpermiso smallint);
       public          postgres    false            �            1255    34342    consecutivotabcategoria()    FUNCTION     �   CREATE FUNCTION public.consecutivotabcategoria() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecCateg := (SELECT COALESCE(MAX(consecCateg), 0) + 1 FROM tabCategoria);
    RETURN NEW;
END;
$$;
 0   DROP FUNCTION public.consecutivotabcategoria();
       public          postgres    false            �            1255    34349    consecutivotabdetalleventa()    FUNCTION     �   CREATE FUNCTION public.consecutivotabdetalleventa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecDetVenta := (SELECT COALESCE(MAX(consecDetVenta), 0) + 1 FROM tabDetalleVenta);
    RETURN NEW;
END;
$$;
 3   DROP FUNCTION public.consecutivotabdetalleventa();
       public          postgres    false            �            1255    34346    consecutivotabencabezadoventa()    FUNCTION     �   CREATE FUNCTION public.consecutivotabencabezadoventa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.idEncVenta := (SELECT COALESCE(MAX(idEncVenta), 0) + 1 FROM tabEncabezadoVenta);
    RETURN NEW;
END;
$$;
 6   DROP FUNCTION public.consecutivotabencabezadoventa();
       public          postgres    false            �            1255    34347     consecutivotabencabezadoventa1()    FUNCTION       CREATE FUNCTION public.consecutivotabencabezadoventa1() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.tipoFactura = TRUE THEN
    NEW.consecFactura := (SELECT COALESCE(MAX(consecFactura), 111) + 1 FROM tabEncabezadoVenta);
    END IF;
	RETURN NEW;
END;
$$;
 7   DROP FUNCTION public.consecutivotabencabezadoventa1();
       public          postgres    false            �            1255    34348     consecutivotabencabezadoventa2()    FUNCTION       CREATE FUNCTION public.consecutivotabencabezadoventa2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.tipoFactura = FALSE THEN
    NEW.consecCotizacion := (SELECT COALESCE(MAX(consecCotizacion), 222) + 1 FROM tabEncabezadoVenta);
    END IF;
	RETURN NEW;
END;
$$;
 7   DROP FUNCTION public.consecutivotabencabezadoventa2();
       public          postgres    false            �            1255    34344    consecutivotabkardex()    FUNCTION     �   CREATE FUNCTION public.consecutivotabkardex() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecKardex := (SELECT COALESCE(MAX(consecKardex), 0) + 1 FROM tabKardex);
    RETURN NEW;
END;
$$;
 -   DROP FUNCTION public.consecutivotabkardex();
       public          postgres    false            �            1255    34343    consecutivotabmarca()    FUNCTION     �   CREATE FUNCTION public.consecutivotabmarca() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecMarca := (SELECT COALESCE(MAX(consecMarca), 0) + 1 FROM tabMarca);
    RETURN NEW;
END;
$$;
 ,   DROP FUNCTION public.consecutivotabmarca();
       public          postgres    false            �            1255    34340    consecutivotabpermiso()    FUNCTION     �   CREATE FUNCTION public.consecutivotabpermiso() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecPermiso := (SELECT COALESCE(MAX(consecPermiso), 0) + 1 FROM tabPermiso);
    RETURN NEW;
END;
$$;
 .   DROP FUNCTION public.consecutivotabpermiso();
       public          postgres    false            �            1255    34345    consecutivotabrecibomercancia()    FUNCTION     �   CREATE FUNCTION public.consecutivotabrecibomercancia() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecReciboMcia := (SELECT COALESCE(MAX(consecReciboMcia), 0) + 1 FROM tabReciboMercancia);
    RETURN NEW;
END;
$$;
 6   DROP FUNCTION public.consecutivotabrecibomercancia();
       public          postgres    false            �            1255    34350    consecutivotabregborrados()    FUNCTION     �   CREATE FUNCTION public.consecutivotabregborrados() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecRegBor := (SELECT COALESCE(MAX(consecRegBor), 0) + 1 FROM tabRegBorrados);
    RETURN NEW;
END;
$$;
 2   DROP FUNCTION public.consecutivotabregborrados();
       public          postgres    false            �            1255    34341    consecutivotabusuariopermiso()    FUNCTION     �   CREATE FUNCTION public.consecutivotabusuariopermiso() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecUsuarioPermiso := (SELECT COALESCE(MAX(consecUsuarioPermiso), 0) + 1 FROM tabUsuarioPermiso);
    RETURN NEW;
END;
$$;
 5   DROP FUNCTION public.consecutivotabusuariopermiso();
       public          postgres    false                       1255    34431 "   insertcategoria(character varying)    FUNCTION     �  CREATE FUNCTION public.insertcategoria(znomcateg character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    categoriaExistente BOOLEAN;
BEGIN
    -- Verificamos si ya existe un registro con el mismo nomCateg
    SELECT EXISTS (SELECT 1 FROM tabCategoria WHERE nomCateg = zNomCateg) INTO categoriaExistente;

    IF categoriaExistente THEN
        RAISE EXCEPTION 'Ya existe una categoría con el mismo nombre: %', zNomCateg;
    ELSE
        -- Insertamos una nueva categoría si no existe

        INSERT INTO tabCategoria(nomCateg)
        VALUES (zNomCateg);

        RAISE NOTICE 'Categoría registrada con éxito';
    END IF;
END;
$$;
 C   DROP FUNCTION public.insertcategoria(znomcateg character varying);
       public          postgres    false                       1255    34428 �   insertclientejuridico(character varying, character varying, boolean, character varying, character varying, character varying, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.insertclientejuridico(zidcli character varying, zdivcli character varying, ztipocli boolean, znomreplegal character varying, znomempresa character varying, ztelcli character varying, zemailcli character varying, zdircli character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
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
$$;
   DROP FUNCTION public.insertclientejuridico(zidcli character varying, zdivcli character varying, ztipocli boolean, znomreplegal character varying, znomempresa character varying, ztelcli character varying, zemailcli character varying, zdircli character varying);
       public          postgres    false                       1255    34427 �   insertclientenatural(character varying, boolean, character varying, character varying, character varying, character varying, character varying)    FUNCTION     `  CREATE FUNCTION public.insertclientenatural(zidcli character varying, ztipocli boolean, znomcli character varying, zapecli character varying, ztelcli character varying, zemailcli character varying, zdircli character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
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
$$;
 �   DROP FUNCTION public.insertclientenatural(zidcli character varying, ztipocli boolean, znomcli character varying, zapecli character varying, ztelcli character varying, zemailcli character varying, zdircli character varying);
       public          postgres    false                       1255    34438 7   insertdetalleventa(character varying, integer, numeric)    FUNCTION     o  CREATE FUNCTION public.insertdetalleventa(zeanart character varying, zcantart integer, zdescuento numeric) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE
    zValUnit tabArticulo.valUnit%type;
    zSubTotal tabDetalleVenta.subTotal%type;
    zIva tabArticulo.iva%type;
    zTotalPagar tabDetalleVenta.totalPagar%type;
    zIdEncVenta BIGINT;
    zConsecFactura BIGINT;
    zConsecCotizacion BIGINT;
    
BEGIN
    -- Obtener el valor unitario (valUnit) del artículo desde la tabla "tabArticulo"
    SELECT valUnit INTO zValUnit FROM tabArticulo WHERE eanArt = zEanArt;
    SELECT iva INTO zIva FROM tabArticulo WHERE eanArt = zEanArt;
    
    -- Calcular el subtotal y el total a pagar
    zSubtotal := zCantArt * zValUnit;
    zTotalPagar := (zSubtotal * zIva)-zdescuento;
    
    --obtener el idEncVenta desde la tabEncabezadoVenta
    SELECT idEncVenta into zIdEncVenta from tabEncabezadoVenta ORDER BY idEncVenta DESC LIMIT 1;
    
    -- Obtener el consecutivo de venta (consecFactura-consecCotizacion) desde la tabla "tabEncabezadoVenta"
    SELECT consecFactura INTO zConsecFactura FROM tabEncabezadoVenta ORDER BY idEncVenta DESC LIMIT 1 ;
    SELECT consecCotizacion INTO zConsecCotizacion FROM tabEncabezadoVenta  ORDER BY  idEncVenta  DESC LIMIT 1 ;
    
    -- Insertar los datos en la tabla "tabDetalleVenta"
    INSERT INTO tabDetalleVenta (eanArt, cantArt, valUnit, subTotal, iva, descuento, totalPagar, consecFactura, consecCotizacion,idEncVenta )
    VALUES (zEanArt, zCantArt, zValUnit, zSubTotal, zIva, zDescuento, zTotalPagar, zConsecFactura, zConsecCotizacion,zIdEncVenta);
   
    RETURN zIdEncVenta;
    
END;
$$;
 j   DROP FUNCTION public.insertdetalleventa(zeanart character varying, zcantart integer, zdescuento numeric);
       public          postgres    false                       1255    34437 =   insertencventa(boolean, character varying, character varying)    FUNCTION     (  CREATE FUNCTION public.insertencventa(ztipofactura boolean, zidcli character varying, zciudad character varying, OUT zconsecfactura bigint, OUT zconseccotizacion bigint) RETURNS record
    LANGUAGE plpgsql
    AS $$

DECLARE 


BEGIN
    IF zTipoFactura = TRUE THEN -- Factura legal
        
        INSERT INTO tabEncabezadoVenta (tipoFactura, idCli, ciudad)
        VALUES (zTipoFactura, zIdCli, zCiudad )
        RETURNING consecFactura INTO zConsecFactura;
        zConsecCotizacion:= NULL;
        
    ELSE -- Cotización
       
        INSERT INTO tabEncabezadoVenta  (tipoFactura, idCli, ciudad)
        VALUES (zTipoFactura, zIdCli, zCiudad)
        RETURNING consecCotizacion INTO zConsecCotizacion;
        zConsecFactura := NULL; -- No asignar consecutivo para cotizaciones
    END IF;
END;
$$;
 �   DROP FUNCTION public.insertencventa(ztipofactura boolean, zidcli character varying, zciudad character varying, OUT zconsecfactura bigint, OUT zconseccotizacion bigint);
       public          postgres    false                       1255    34432    insertkardexentrada()    FUNCTION     �  CREATE FUNCTION public.insertkardexentrada() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE
zValProm tabKardex.valProm%type;
zValTotal tabReciboMercancia.valTotal%type;
zReciboMcia tabReciboMercancia.consecReciboMcia%type;

BEGIN
    /* Si el tipo de movimiento es entrada*/
    SELECT valTotal INTO zValTotal FROM tabReciboMercancia where consecReciboMcia= new.consecReciboMcia;
    SELECT consecReciboMcia INTO zReciboMcia FROM tabReciboMercancia  where consecReciboMcia= new.consecReciboMcia;
    
    zValProm := zValTotal / new.cantArt;
    
    INSERT INTO tabKardex (consecReciboMcia,tipoMov, eanArt, cantArt, valProm) 
    VALUES (zReciboMcia, TRUE, NEW.eanArt, NEW.cantArt, zValProm);
        
    RETURN NEW;
   
END;
$$;
 ,   DROP FUNCTION public.insertkardexentrada();
       public          postgres    false                       1255    34434    insertkardexsalida()    FUNCTION     �  CREATE FUNCTION public.insertkardexsalida() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE
zValProm tabKardex.valProm%type :=0;

zConsecDetVenta tabDetalleVenta.consecDetVenta%type;

BEGIN
    
    SELECT consecDetVenta INTO zConsecDetVenta FROM tabDetalleVenta  where consecDetVenta= new.consecDetVenta;
    
        INSERT INTO tabKardex (
        tipoMov, eanArt, cantArt, consecDetVenta) 
        VALUES (FALSE, NEW.eanArt, NEW.cantArt, zConsecDetVenta);
        RETURN NEW;
   
END;
$$;
 +   DROP FUNCTION public.insertkardexsalida();
       public          postgres    false                       1255    34430    insertmarca(character varying)    FUNCTION     f  CREATE FUNCTION public.insertmarca(znommarca character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    marcaExistente BOOLEAN;
BEGIN
    -- Verificar si ya existe un registro con el mismo nomMarca
    SELECT EXISTS (SELECT 1 FROM tabMarca WHERE nomMarca = zNomMarca) INTO marcaExistente;

    IF marcaExistente THEN
    
        RAISE EXCEPTION 'Ya existe una marca con el mismo nombre: %', zNomMarca;
    ELSE

        -- Insertar nueva marca si no existe
        INSERT INTO tabMarca(nomMarca)
        VALUES (zNomMarca);
        RAISE NOTICE 'Marca registrada con éxito';
    END IF;
END;
$$;
 ?   DROP FUNCTION public.insertmarca(znommarca character varying);
       public          postgres    false                       1255    34425 3   insertpermiso(character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.insertpermiso(znompermiso character varying, zdescpermiso character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE
    permisoExistente BOOLEAN;
	
BEGIN
    -- Verificamos si ya existe un registro con el mismo nomPermiso
    SELECT EXISTS (SELECT 1 FROM tabPermiso WHERE nomPermiso = zNomPermiso) INTO permisoExistente;

    IF permisoExistente THEN
        RAISE EXCEPTION 'Ya existe un permiso con el mismo nombre: %', zNomPermiso;

    ELSE

        -- Insertamos nuevo permiso si no existe
        INSERT INTO tabPermiso (nomPermiso, descPermiso)
        VALUES (zNomPermiso, zDescPermiso);

        RAISE NOTICE 'permiso registrado con éxito';
    END IF;
END;
$$;
 c   DROP FUNCTION public.insertpermiso(znompermiso character varying, zdescpermiso character varying);
       public          postgres    false                       1255    34429 �   insertproveedor(character varying, character varying, character varying, character varying, character varying, character varying)    FUNCTION     c  CREATE FUNCTION public.insertproveedor(zidprov character varying, zdivprov character varying, znomprov character varying, ztelprov character varying, zemailprov character varying, zdirprov character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    proveedorExistente BOOLEAN;

BEGIN
    -- Verificamos si ya existe un registro con el mismo idProv
    SELECT EXISTS (SELECT 1 FROM tabProveedor WHERE idProv = zIdProv) INTO proveedorExistente;

    IF proveedorExistente THEN
        RAISE EXCEPTION 'El proveedor ya esta registrado: %', zIdProv;

    ELSE
        -- Insertamos nuevo proveedor si no existe

        INSERT INTO tabProveedor(idProv, divProv, nomProv, telProv, emailProv, dirProv)
        VALUES (zIdProv, zDivProv, zNomProv, zTelProv, zEmailProv, zDirProv);

        RAISE NOTICE 'Proveedor registrado con éxito';
    END IF;
END;
$$;
 �   DROP FUNCTION public.insertproveedor(zidprov character varying, zdivprov character varying, znomprov character varying, ztelprov character varying, zemailprov character varying, zdirprov character varying);
       public          postgres    false                       1255    34436 S   insertrecibomercancia(character varying, integer, numeric, character varying, text)    FUNCTION     �  CREATE FUNCTION public.insertrecibomercancia(zeanart character varying, zcantart integer, zvalcompra numeric, zidprov character varying, zobservacion text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    zValTotal tabReciboMercancia.valTotal%type;

BEGIN

IF zCantArt <= 0 THEN
    RAISE EXCEPTION 'La cantidad debe ser un número positivo';
END IF;


zValTotal := zCantArt * zValCompra;

IF EXISTS (SELECT 1 FROM tabReciboMercancia WHERE eanArt = zEanArt) THEN

   INSERT INTO tabReciboMercancia(eanArt, cantArt, valCompra, valTotal, idProv, observacion)
        VALUES (zEanArt, zCantArt, zValCompra, zValTotal, zIdProv, zObservacion);
    
ELSE     
        -- Insertar el nuevo registro de recibo de mercancia.
   INSERT INTO tabReciboMercancia(eanArt, cantArt, valCompra, valTotal, idProv, observacion)
   VALUES (zEanArt, zCantArt, zValCompra, zValTotal, zIdProv, zObservacion);

   RAISE NOTICE 'Artículo registrado con éxito';
        
END IF; 
END;
$$;
 �   DROP FUNCTION public.insertrecibomercancia(zeanart character varying, zcantart integer, zvalcompra numeric, zidprov character varying, zobservacion text);
       public          postgres    false                       1255    34424    insertusuario(character varying, character varying, character varying, character varying, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.insertusuario(zidusuario character varying, znomusuario character varying, zapeusuario character varying, zemailusuario character varying, zusuario character varying, zpassword character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE
    usuarioExistente BOOLEAN;

BEGIN
    -- Verificamos si el usuario ya existe en la db.

    --SELECT EXISTS (SELECT 1 FROM tabUsuario WHERE usuario = zUsuario) INTO usuarioExistente;
    SELECT EXISTS (SELECT 1 FROM tabUsuario WHERE usuario = zUsuario AND idUsuario = zIdUsuario) INTO usuarioExistente;

    IF usuarioExistente THEN
        RAISE EXCEPTION 'Usuario ya existe: %,%', zUsuario,zIdUsuario;

    ELSE
        -- Insertamos  nuevo usuario si no existe en la db.

        INSERT INTO tabUsuario (idUsuario, nomUsuario, apeUsuario, emailUsuario, usuario, password)
        VALUES (zIdUsuario, zNomUsuario, zApeUsuario, zEmailUsuario, zUsuario, zPassword);
        RAISE NOTICE 'Registro Exitoso';
    END IF;
END;
$$;
 �   DROP FUNCTION public.insertusuario(zidusuario character varying, znomusuario character varying, zapeusuario character varying, zemailusuario character varying, zusuario character varying, zpassword character varying);
       public          postgres    false                       1255    34391    movimientosusuario()    FUNCTION       CREATE FUNCTION public.movimientosusuario() RETURNS trigger
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
	  VALUES(current_timestamp,current_user,TG_RELNAME);--cambiar por usuario de la pagina
	
	  RETURN OLD;
	END IF ;
END;

$$;
 +   DROP FUNCTION public.movimientosusuario();
       public          postgres    false            �            1255    34374    uuidtabcliente()    FUNCTION     �   CREATE FUNCTION public.uuidtabcliente() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.codCli := uuid_generate_v4();
    RETURN NEW;
END;
$$;
 '   DROP FUNCTION public.uuidtabcliente();
       public          postgres    false            �            1255    34375    uuidtabproveedor()    FUNCTION     �   CREATE FUNCTION public.uuidtabproveedor() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.codProv := uuid_generate_v4();
    RETURN NEW;
END;
$$;
 )   DROP FUNCTION public.uuidtabproveedor();
       public          postgres    false            �            1255    34373    uuidtabusuario()    FUNCTION     �   CREATE FUNCTION public.uuidtabusuario() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.codUsuario := uuid_generate_v4();
    RETURN NEW;
END;
$$;
 '   DROP FUNCTION public.uuidtabusuario();
       public          postgres    false                       1255    34420    validacionentrada()    FUNCTION     �  CREATE FUNCTION public.validacionentrada() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    zStockMax tabArticulo.stockMax%type;
    zValStock tabArticulo.valStock%type;
    zCantArtZvalStock NUMERIC;

BEGIN
    -- obtenemos el valor del stock máximo de la tabArticulo
    SELECT stockMax, valStock INTO zStockMax, zValStock FROM tabArticulo WHERE eanArt = NEW.eanArt;
    zCantArtZvalStock := NEW.cantArt + zValStock;

    CASE
        -- Verificar si la cantidad ingresada supera el stock máximo
        WHEN NEW.cantArt > zStockMax THEN
            RAISE EXCEPTION 'La cantidad ingresada supera el stock máximo establecido para: %', NEW.eanArt;

        WHEN zCantArtZvalStock > zStockMax THEN
            RAISE EXCEPTION 'Las cantidades de entrada superaron el stock máximo';
        ELSE

    END CASE;

    -- Si la validación es exitosa, permite la inserción
    RETURN NEW;
END;
$$;
 *   DROP FUNCTION public.validacionentrada();
       public          postgres    false            �            1255    34379    validacionid()    FUNCTION       CREATE FUNCTION public.validacionid() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    zId VARCHAR := '^[0-9]{1,10}$';
    zIdValue VARCHAR;
BEGIN
    IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
        CASE
            WHEN TG_RELID = 'tabcliente'::regclass THEN
                zIdValue := NEW.idCli;
            WHEN TG_RELID = 'tabproveedor'::regclass THEN
                zIdValue := NEW.idProv;
            WHEN TG_RELID = 'tabusuario'::regclass THEN
                zIdValue := NEW.idUsuario;
            ELSE
                RAISE EXCEPTION 'Error trigger';
        END CASE;

        IF zIdValue IS NOT NULL AND zIdValue !~ zId THEN
            RAISE EXCEPTION 'Porfavor ingresar solo números de hasta 10 digitos';
        END IF;
    END IF;

    RETURN NEW;
END;
$_$;
 %   DROP FUNCTION public.validacionid();
       public          postgres    false                       1255    34422    validacionsalida()    FUNCTION     �  CREATE FUNCTION public.validacionsalida() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    zValStock tabArticulo.valStock%type;
    zStockMin tabArticulo.stockMin%type;
    zStockMax tabArticulo.stockMax%type;
    zVar NUMERIC;

BEGIN
    
    SELECT valStock, stockMin, stockMax INTO zValStock, zStockMin, zStockMax FROM tabArticulo WHERE eanArt = NEW.eanArt;
    zVar := ABS(NEW.cantArt - zValStock);

        --Estas son las restricciones
        CASE
            
            WHEN NEW.cantArt <= 0 THEN
                RAISE EXCEPTION 'Debe ingresar una cantidad válida';

            WHEN zVar > 0 AND zVar < zStockMin THEN
                RAISE EXCEPTION 'La cantidad de salida hace que el stock actual quede por debajo del stock mínimo';

            WHEN NEW.cantArt > zStockMax THEN
                RAISE EXCEPTION 'La cantidad supera las existencias en stock máximo';

            WHEN NEW.cantArt >= zValStock THEN
                RAISE EXCEPTION 'La cantidad supera las existencias en stock';
            
            WHEN zValStock IS NULL OR zValStock <= 0 THEN
                RAISE EXCEPTION 'No se puede realizar la operación, stock en cero';
            ELSE

        END CASE;

        CASE 
            -- Que sea la salida sea mayor al stock mínimo
            WHEN zVar <= 0 THEN
                RAISE NOTICE 'Exitoso mayor del stock mínimo';
            ELSE

        END CASE;

RETURN NEW;
END;
$$;
 )   DROP FUNCTION public.validacionsalida();
       public          postgres    false            �            1255    34383    validaciontel()    FUNCTION     �  CREATE FUNCTION public.validaciontel() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    zTel VARCHAR := '^[0-9]{1,10}$';
    zTelValue VARCHAR;
BEGIN
    IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
        CASE
            WHEN TG_RELID = 'tabcliente'::regclass THEN
                zTelValue := NEW.telCli;
            WHEN TG_RELID = 'tabproveedor'::regclass THEN
                zTelValue := NEW.telProv;
            
            ELSE
                RAISE EXCEPTION 'Error trigger';
        END CASE;

        IF zTelValue IS NOT NULL AND zTelValue !~ zTel THEN
            RAISE EXCEPTION 'Porfavor ingresar solo números de hasta 10 digitos para el número de teléfono';
        END IF;
    END IF;

    RETURN NEW;
END;
$_$;
 &   DROP FUNCTION public.validaciontel();
       public          postgres    false                       1255    34387    validaremailgenerico()    FUNCTION     �  CREATE FUNCTION public.validaremailgenerico() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    emailRegex VARCHAR := '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$';
    emailValue VARCHAR;
BEGIN
    IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
        CASE
            WHEN TG_RELID = 'tabusuario'::regclass THEN
                emailValue := NEW.emailUsuario;
            WHEN TG_RELID = 'tabcliente'::regclass THEN
                emailValue := NEW.emailCli;
            WHEN TG_RELID = 'tabproveedor'::regclass THEN
                emailValue := NEW.emailProv;
            ELSE
                RAISE EXCEPTION 'Tabla no soportada por el trigger.';
        END CASE;

        IF emailValue IS NOT NULL AND emailValue !~ emailRegex THEN
            RAISE EXCEPTION 'El formato del correo electrónico no es válido para la tabla %.', TG_RELID::text;
        END IF;
    END IF;

    RETURN NEW;
END;
$_$;
 -   DROP FUNCTION public.validaremailgenerico();
       public          postgres    false            �            1259    34234    tabarticulo    TABLE     o  CREATE TABLE public.tabarticulo (
    eanart character varying NOT NULL,
    nomart character varying NOT NULL,
    consecmarca smallint NOT NULL,
    conseccateg smallint NOT NULL,
    descart text,
    valunit numeric(10,0),
    porcentaje numeric(10,2),
    iva numeric(10,2) NOT NULL,
    valstock integer,
    stockmin integer NOT NULL,
    stockmax integer NOT NULL,
    valreorden integer NOT NULL,
    fecvence date,
    estado boolean DEFAULT true NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
    DROP TABLE public.tabarticulo;
       public         heap    postgres    false            �            1259    34218    tabcategoria    TABLE     5  CREATE TABLE public.tabcategoria (
    conseccateg smallint NOT NULL,
    nomcateg character varying NOT NULL,
    estado boolean DEFAULT true NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
     DROP TABLE public.tabcategoria;
       public         heap    postgres    false            �            1259    34199 
   tabcliente    TABLE     #  CREATE TABLE public.tabcliente (
    codcli uuid NOT NULL,
    idcli character varying NOT NULL,
    divcli character varying,
    tipocli boolean NOT NULL,
    nomcli character varying,
    apecli character varying,
    nomreplegal character varying,
    nomempresa character varying,
    telcli character varying(10) NOT NULL,
    emailcli character varying,
    dircli character varying,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
    DROP TABLE public.tabcliente;
       public         heap    postgres    false            �            1259    34281    tabdetalleventa    TABLE     O  CREATE TABLE public.tabdetalleventa (
    consecdetventa bigint NOT NULL,
    idencventa bigint NOT NULL,
    consecfactura bigint,
    conseccotizacion bigint,
    eanart character varying NOT NULL,
    cantart integer NOT NULL,
    valunit numeric(10,0) NOT NULL,
    subtotal numeric(10,0) NOT NULL,
    iva numeric(10,2) DEFAULT 0.19 NOT NULL,
    descuento numeric(10,0) DEFAULT 0 NOT NULL,
    totalpagar numeric(10,0) NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
 #   DROP TABLE public.tabdetalleventa;
       public         heap    postgres    false            �            1259    34269    tabencabezadoventa    TABLE     �  CREATE TABLE public.tabencabezadoventa (
    idencventa bigint NOT NULL,
    consecfactura bigint,
    conseccotizacion bigint,
    tipofactura boolean NOT NULL,
    estadofactura boolean DEFAULT true NOT NULL,
    idcli character varying NOT NULL,
    ciudad character varying NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
 &   DROP TABLE public.tabencabezadoventa;
       public         heap    postgres    false            �            1259    34310 	   tabkardex    TABLE     �  CREATE TABLE public.tabkardex (
    conseckardex bigint NOT NULL,
    consecrecibomcia bigint,
    consecdetventa bigint,
    tipomov boolean DEFAULT true NOT NULL,
    eanart character varying NOT NULL,
    cantart integer NOT NULL,
    valprom numeric(10,0),
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
    DROP TABLE public.tabkardex;
       public         heap    postgres    false            �            1259    34226    tabmarca    TABLE     1  CREATE TABLE public.tabmarca (
    consecmarca smallint NOT NULL,
    nommarca character varying NOT NULL,
    estado boolean DEFAULT true NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
    DROP TABLE public.tabmarca;
       public         heap    postgres    false            �            1259    34175 
   tabpermiso    TABLE     ,  CREATE TABLE public.tabpermiso (
    consecpermiso smallint NOT NULL,
    nompermiso character varying NOT NULL,
    descpermiso text NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
    DROP TABLE public.tabpermiso;
       public         heap    postgres    false            �            1259    34208    tabproveedor    TABLE     �  CREATE TABLE public.tabproveedor (
    codprov uuid NOT NULL,
    idprov character varying NOT NULL,
    divprov character varying,
    nomprov character varying NOT NULL,
    telprov character varying NOT NULL,
    emailprov character varying NOT NULL,
    dirprov character varying NOT NULL,
    estado boolean DEFAULT true NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
     DROP TABLE public.tabproveedor;
       public         heap    postgres    false            �            1259    34252    tabrecibomercancia    TABLE     �  CREATE TABLE public.tabrecibomercancia (
    consecrecibomcia bigint NOT NULL,
    eanart character varying NOT NULL,
    cantart integer NOT NULL,
    valcompra numeric(10,0),
    valtotal numeric(10,0),
    idprov character varying NOT NULL,
    observacion text,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
 &   DROP TABLE public.tabrecibomercancia;
       public         heap    postgres    false            �            1259    34333    tabregborrados    TABLE     �   CREATE TABLE public.tabregborrados (
    consecregbor bigint NOT NULL,
    fecdelete timestamp without time zone,
    userdelete character varying NOT NULL,
    nomtabla character varying NOT NULL
);
 "   DROP TABLE public.tabregborrados;
       public         heap    postgres    false            �            1259    34155 
   tabusuario    TABLE     �  CREATE TABLE public.tabusuario (
    codusuario uuid NOT NULL,
    idusuario character varying NOT NULL,
    nomusuario character varying NOT NULL,
    apeusuario character varying NOT NULL,
    emailusuario character varying NOT NULL,
    usuario character varying NOT NULL,
    password character varying NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
    DROP TABLE public.tabusuario;
       public         heap    postgres    false            �            1259    34182    tabusuariopermiso    TABLE     ?  CREATE TABLE public.tabusuariopermiso (
    consecusuariopermiso smallint NOT NULL,
    idusuario character varying NOT NULL,
    consecpermiso smallint NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
 %   DROP TABLE public.tabusuariopermiso;
       public         heap    postgres    false            �            1259    34165    usuarios    TABLE     5  CREATE TABLE public.usuarios (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    correo character varying(100) NOT NULL,
    contrasena character varying(255) NOT NULL,
    confirmationcode character varying(255),
    confirmed boolean,
    resetpasswordtoken character varying(255)
);
    DROP TABLE public.usuarios;
       public         heap    postgres    false            �            1259    34164    usuarios_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.usuarios_id_seq;
       public          postgres    false    217            �           0    0    usuarios_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;
          public          postgres    false    216            �           2604    34168    usuarios id    DEFAULT     j   ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);
 :   ALTER TABLE public.usuarios ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            �          0    34234    tabarticulo 
   TABLE DATA           �   COPY public.tabarticulo (eanart, nomart, consecmarca, conseccateg, descart, valunit, porcentaje, iva, valstock, stockmin, stockmax, valreorden, fecvence, estado, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    224   V)      �          0    34218    tabcategoria 
   TABLE DATA           s   COPY public.tabcategoria (conseccateg, nomcateg, estado, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    222   s)      �          0    34199 
   tabcliente 
   TABLE DATA           �   COPY public.tabcliente (codcli, idcli, divcli, tipocli, nomcli, apecli, nomreplegal, nomempresa, telcli, emailcli, dircli, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    220   �)      �          0    34281    tabdetalleventa 
   TABLE DATA           �   COPY public.tabdetalleventa (consecdetventa, idencventa, consecfactura, conseccotizacion, eanart, cantart, valunit, subtotal, iva, descuento, totalpagar, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    227   �)      �          0    34269    tabencabezadoventa 
   TABLE DATA           �   COPY public.tabencabezadoventa (idencventa, consecfactura, conseccotizacion, tipofactura, estadofactura, idcli, ciudad, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    226   �)      �          0    34310 	   tabkardex 
   TABLE DATA           �   COPY public.tabkardex (conseckardex, consecrecibomcia, consecdetventa, tipomov, eanart, cantart, valprom, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    228   �)      �          0    34226    tabmarca 
   TABLE DATA           o   COPY public.tabmarca (consecmarca, nommarca, estado, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    223   *      �          0    34175 
   tabpermiso 
   TABLE DATA           z   COPY public.tabpermiso (consecpermiso, nompermiso, descpermiso, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    218   !*      �          0    34208    tabproveedor 
   TABLE DATA           �   COPY public.tabproveedor (codprov, idprov, divprov, nomprov, telprov, emailprov, dirprov, estado, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    221   >*      �          0    34252    tabrecibomercancia 
   TABLE DATA           �   COPY public.tabrecibomercancia (consecrecibomcia, eanart, cantart, valcompra, valtotal, idprov, observacion, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    225   [*      �          0    34333    tabregborrados 
   TABLE DATA           W   COPY public.tabregborrados (consecregbor, fecdelete, userdelete, nomtabla) FROM stdin;
    public          postgres    false    229   x*      �          0    34155 
   tabusuario 
   TABLE DATA           �   COPY public.tabusuario (codusuario, idusuario, nomusuario, apeusuario, emailusuario, usuario, password, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    215   �*      �          0    34182    tabusuariopermiso 
   TABLE DATA           �   COPY public.tabusuariopermiso (consecusuariopermiso, idusuario, consecpermiso, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    219   �*      �          0    34165    usuarios 
   TABLE DATA           s   COPY public.usuarios (id, nombre, correo, contrasena, confirmationcode, confirmed, resetpasswordtoken) FROM stdin;
    public          postgres    false    217   �*      �           0    0    usuarios_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.usuarios_id_seq', 1, false);
          public          postgres    false    216            �           2606    34241    tabarticulo tabarticulo_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.tabarticulo
    ADD CONSTRAINT tabarticulo_pkey PRIMARY KEY (eanart);
 F   ALTER TABLE ONLY public.tabarticulo DROP CONSTRAINT tabarticulo_pkey;
       public            postgres    false    224            �           2606    34225    tabcategoria tabcategoria_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.tabcategoria
    ADD CONSTRAINT tabcategoria_pkey PRIMARY KEY (conseccateg);
 H   ALTER TABLE ONLY public.tabcategoria DROP CONSTRAINT tabcategoria_pkey;
       public            postgres    false    222            �           2606    34207    tabcliente tabcliente_idcli_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.tabcliente
    ADD CONSTRAINT tabcliente_idcli_key UNIQUE (idcli);
 I   ALTER TABLE ONLY public.tabcliente DROP CONSTRAINT tabcliente_idcli_key;
       public            postgres    false    220            �           2606    34205    tabcliente tabcliente_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.tabcliente
    ADD CONSTRAINT tabcliente_pkey PRIMARY KEY (codcli);
 D   ALTER TABLE ONLY public.tabcliente DROP CONSTRAINT tabcliente_pkey;
       public            postgres    false    220            �           2606    34289 $   tabdetalleventa tabdetalleventa_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.tabdetalleventa
    ADD CONSTRAINT tabdetalleventa_pkey PRIMARY KEY (consecdetventa);
 N   ALTER TABLE ONLY public.tabdetalleventa DROP CONSTRAINT tabdetalleventa_pkey;
       public            postgres    false    227            �           2606    34280 :   tabencabezadoventa tabencabezadoventa_conseccotizacion_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.tabencabezadoventa
    ADD CONSTRAINT tabencabezadoventa_conseccotizacion_key UNIQUE (conseccotizacion);
 d   ALTER TABLE ONLY public.tabencabezadoventa DROP CONSTRAINT tabencabezadoventa_conseccotizacion_key;
       public            postgres    false    226            �           2606    34278 7   tabencabezadoventa tabencabezadoventa_consecfactura_key 
   CONSTRAINT     {   ALTER TABLE ONLY public.tabencabezadoventa
    ADD CONSTRAINT tabencabezadoventa_consecfactura_key UNIQUE (consecfactura);
 a   ALTER TABLE ONLY public.tabencabezadoventa DROP CONSTRAINT tabencabezadoventa_consecfactura_key;
       public            postgres    false    226            �           2606    34276 *   tabencabezadoventa tabencabezadoventa_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.tabencabezadoventa
    ADD CONSTRAINT tabencabezadoventa_pkey PRIMARY KEY (idencventa);
 T   ALTER TABLE ONLY public.tabencabezadoventa DROP CONSTRAINT tabencabezadoventa_pkey;
       public            postgres    false    226            �           2606    34317    tabkardex tabkardex_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.tabkardex
    ADD CONSTRAINT tabkardex_pkey PRIMARY KEY (conseckardex);
 B   ALTER TABLE ONLY public.tabkardex DROP CONSTRAINT tabkardex_pkey;
       public            postgres    false    228            �           2606    34233    tabmarca tabmarca_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.tabmarca
    ADD CONSTRAINT tabmarca_pkey PRIMARY KEY (consecmarca);
 @   ALTER TABLE ONLY public.tabmarca DROP CONSTRAINT tabmarca_pkey;
       public            postgres    false    223            �           2606    34181    tabpermiso tabpermiso_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.tabpermiso
    ADD CONSTRAINT tabpermiso_pkey PRIMARY KEY (consecpermiso);
 D   ALTER TABLE ONLY public.tabpermiso DROP CONSTRAINT tabpermiso_pkey;
       public            postgres    false    218            �           2606    34217 $   tabproveedor tabproveedor_idprov_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.tabproveedor
    ADD CONSTRAINT tabproveedor_idprov_key UNIQUE (idprov);
 N   ALTER TABLE ONLY public.tabproveedor DROP CONSTRAINT tabproveedor_idprov_key;
       public            postgres    false    221            �           2606    34215    tabproveedor tabproveedor_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.tabproveedor
    ADD CONSTRAINT tabproveedor_pkey PRIMARY KEY (codprov);
 H   ALTER TABLE ONLY public.tabproveedor DROP CONSTRAINT tabproveedor_pkey;
       public            postgres    false    221            �           2606    34258 *   tabrecibomercancia tabrecibomercancia_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.tabrecibomercancia
    ADD CONSTRAINT tabrecibomercancia_pkey PRIMARY KEY (consecrecibomcia);
 T   ALTER TABLE ONLY public.tabrecibomercancia DROP CONSTRAINT tabrecibomercancia_pkey;
       public            postgres    false    225            �           2606    34339 "   tabregborrados tabregborrados_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.tabregborrados
    ADD CONSTRAINT tabregborrados_pkey PRIMARY KEY (consecregbor);
 L   ALTER TABLE ONLY public.tabregborrados DROP CONSTRAINT tabregborrados_pkey;
       public            postgres    false    229            �           2606    34163 #   tabusuario tabusuario_idusuario_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.tabusuario
    ADD CONSTRAINT tabusuario_idusuario_key UNIQUE (idusuario);
 M   ALTER TABLE ONLY public.tabusuario DROP CONSTRAINT tabusuario_idusuario_key;
       public            postgres    false    215            �           2606    34161    tabusuario tabusuario_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.tabusuario
    ADD CONSTRAINT tabusuario_pkey PRIMARY KEY (codusuario);
 D   ALTER TABLE ONLY public.tabusuario DROP CONSTRAINT tabusuario_pkey;
       public            postgres    false    215            �           2606    34188 (   tabusuariopermiso tabusuariopermiso_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.tabusuariopermiso
    ADD CONSTRAINT tabusuariopermiso_pkey PRIMARY KEY (consecusuariopermiso);
 R   ALTER TABLE ONLY public.tabusuariopermiso DROP CONSTRAINT tabusuariopermiso_pkey;
       public            postgres    false    219            �           2606    34174    usuarios usuarios_correo_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_correo_key UNIQUE (correo);
 F   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_correo_key;
       public            postgres    false    217            �           2606    34172    usuarios usuarios_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_pkey;
       public            postgres    false    217            �           1259    34439    indexean    INDEX     B   CREATE INDEX indexean ON public.tabarticulo USING btree (eanart);
    DROP INDEX public.indexean;
       public            postgres    false    224                       2620    34353 &   tabcategoria autoincrementtabcategoria    TRIGGER     �   CREATE TRIGGER autoincrementtabcategoria BEFORE INSERT ON public.tabcategoria FOR EACH ROW EXECUTE FUNCTION public.consecutivotabcategoria();
 ?   DROP TRIGGER autoincrementtabcategoria ON public.tabcategoria;
       public          postgres    false    232    222            0           2620    34360 ,   tabdetalleventa autoincrementtabdetalleventa    TRIGGER     �   CREATE TRIGGER autoincrementtabdetalleventa BEFORE INSERT ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.consecutivotabdetalleventa();
 E   DROP TRIGGER autoincrementtabdetalleventa ON public.tabdetalleventa;
       public          postgres    false    239    227            +           2620    34357 2   tabencabezadoventa autoincrementtabencabezadoventa    TRIGGER     �   CREATE TRIGGER autoincrementtabencabezadoventa BEFORE INSERT ON public.tabencabezadoventa FOR EACH ROW EXECUTE FUNCTION public.consecutivotabencabezadoventa();
 K   DROP TRIGGER autoincrementtabencabezadoventa ON public.tabencabezadoventa;
       public          postgres    false    236    226            ,           2620    34358 3   tabencabezadoventa autoincrementtabencabezadoventa1    TRIGGER     �   CREATE TRIGGER autoincrementtabencabezadoventa1 BEFORE INSERT ON public.tabencabezadoventa FOR EACH ROW EXECUTE FUNCTION public.consecutivotabencabezadoventa1();
 L   DROP TRIGGER autoincrementtabencabezadoventa1 ON public.tabencabezadoventa;
       public          postgres    false    226    237            -           2620    34359 3   tabencabezadoventa autoincrementtabencabezadoventa2    TRIGGER     �   CREATE TRIGGER autoincrementtabencabezadoventa2 BEFORE INSERT ON public.tabencabezadoventa FOR EACH ROW EXECUTE FUNCTION public.consecutivotabencabezadoventa2();
 L   DROP TRIGGER autoincrementtabencabezadoventa2 ON public.tabencabezadoventa;
       public          postgres    false    238    226            6           2620    34355     tabkardex autoincrementtabkardex    TRIGGER     �   CREATE TRIGGER autoincrementtabkardex BEFORE INSERT ON public.tabkardex FOR EACH ROW EXECUTE FUNCTION public.consecutivotabkardex();
 9   DROP TRIGGER autoincrementtabkardex ON public.tabkardex;
       public          postgres    false    228    234                        2620    34354    tabmarca autoincrementtabmarca    TRIGGER     �   CREATE TRIGGER autoincrementtabmarca BEFORE INSERT ON public.tabmarca FOR EACH ROW EXECUTE FUNCTION public.consecutivotabmarca();
 7   DROP TRIGGER autoincrementtabmarca ON public.tabmarca;
       public          postgres    false    233    223                       2620    34351 "   tabpermiso autoincrementtabpermiso    TRIGGER     �   CREATE TRIGGER autoincrementtabpermiso BEFORE INSERT ON public.tabpermiso FOR EACH ROW EXECUTE FUNCTION public.consecutivotabpermiso();
 ;   DROP TRIGGER autoincrementtabpermiso ON public.tabpermiso;
       public          postgres    false    218    230            %           2620    34356 2   tabrecibomercancia autoincrementtabrecibomercancia    TRIGGER     �   CREATE TRIGGER autoincrementtabrecibomercancia BEFORE INSERT ON public.tabrecibomercancia FOR EACH ROW EXECUTE FUNCTION public.consecutivotabrecibomercancia();
 K   DROP TRIGGER autoincrementtabrecibomercancia ON public.tabrecibomercancia;
       public          postgres    false    235    225            9           2620    34361 *   tabregborrados autoincrementtabregborrados    TRIGGER     �   CREATE TRIGGER autoincrementtabregborrados BEFORE INSERT ON public.tabregborrados FOR EACH ROW EXECUTE FUNCTION public.consecutivotabregborrados();
 C   DROP TRIGGER autoincrementtabregborrados ON public.tabregborrados;
       public          postgres    false    240    229                       2620    34352 0   tabusuariopermiso autoincrementtabusuariopermiso    TRIGGER     �   CREATE TRIGGER autoincrementtabusuariopermiso BEFORE INSERT ON public.tabusuariopermiso FOR EACH ROW EXECUTE FUNCTION public.consecutivotabusuariopermiso();
 I   DROP TRIGGER autoincrementtabusuariopermiso ON public.tabusuariopermiso;
       public          postgres    false    231    219            &           2620    34433 -   tabrecibomercancia insertentradakardexentrada    TRIGGER     �   CREATE TRIGGER insertentradakardexentrada AFTER INSERT ON public.tabrecibomercancia FOR EACH ROW EXECUTE FUNCTION public.insertkardexentrada();
 F   DROP TRIGGER insertentradakardexentrada ON public.tabrecibomercancia;
       public          postgres    false    281    225            1           2620    34435 (   tabdetalleventa insertsalidakardexsalida    TRIGGER     �   CREATE TRIGGER insertsalidakardexsalida AFTER INSERT ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.insertkardexsalida();
 A   DROP TRIGGER insertsalidakardexsalida ON public.tabdetalleventa;
       public          postgres    false    282    227                       2620    34380    tabcliente nitcliente    TRIGGER     r   CREATE TRIGGER nitcliente BEFORE INSERT ON public.tabcliente FOR EACH ROW EXECUTE FUNCTION public.validacionid();
 .   DROP TRIGGER nitcliente ON public.tabcliente;
       public          postgres    false    220    254                       2620    34381    tabproveedor nitproveedor    TRIGGER     v   CREATE TRIGGER nitproveedor BEFORE INSERT ON public.tabproveedor FOR EACH ROW EXECUTE FUNCTION public.validacionid();
 2   DROP TRIGGER nitproveedor ON public.tabproveedor;
       public          postgres    false    254    221                       2620    34382    tabusuario nitusuario    TRIGGER     r   CREATE TRIGGER nitusuario BEFORE INSERT ON public.tabusuario FOR EACH ROW EXECUTE FUNCTION public.validacionid();
 .   DROP TRIGGER nitusuario ON public.tabusuario;
       public          postgres    false    254    215                       2620    34384    tabcliente telcliente    TRIGGER     s   CREATE TRIGGER telcliente BEFORE INSERT ON public.tabcliente FOR EACH ROW EXECUTE FUNCTION public.validaciontel();
 .   DROP TRIGGER telcliente ON public.tabcliente;
       public          postgres    false    255    220                       2620    34385    tabproveedor telproveedor    TRIGGER     w   CREATE TRIGGER telproveedor BEFORE INSERT ON public.tabproveedor FOR EACH ROW EXECUTE FUNCTION public.validaciontel();
 2   DROP TRIGGER telproveedor ON public.tabproveedor;
       public          postgres    false    221    255            '           2620    34417 8   tabrecibomercancia triggeractualizarstockvalunitentradas    TRIGGER     �   CREATE TRIGGER triggeractualizarstockvalunitentradas AFTER INSERT ON public.tabrecibomercancia FOR EACH ROW EXECUTE FUNCTION public.actualizarstockvalunitentradas();
 Q   DROP TRIGGER triggeractualizarstockvalunitentradas ON public.tabrecibomercancia;
       public          postgres    false    269    225            2           2620    34419 4   tabdetalleventa triggeractualizarstockvalunitsalidas    TRIGGER     �   CREATE TRIGGER triggeractualizarstockvalunitsalidas AFTER INSERT ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.actualizarstockvalunitsalidas();
 M   DROP TRIGGER triggeractualizarstockvalunitsalidas ON public.tabdetalleventa;
       public          postgres    false    270    227            #           2620    34406    tabarticulo triggertabarticulo    TRIGGER     �   CREATE TRIGGER triggertabarticulo BEFORE INSERT OR UPDATE ON public.tabarticulo FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 7   DROP TRIGGER triggertabarticulo ON public.tabarticulo;
       public          postgres    false    268    224                       2620    34402     tabcategoria triggertabcategoria    TRIGGER     �   CREATE TRIGGER triggertabcategoria BEFORE INSERT OR UPDATE ON public.tabcategoria FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 9   DROP TRIGGER triggertabcategoria ON public.tabcategoria;
       public          postgres    false    268    222                       2620    34398    tabcliente triggertabcliente    TRIGGER     �   CREATE TRIGGER triggertabcliente BEFORE INSERT OR UPDATE ON public.tabcliente FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 5   DROP TRIGGER triggertabcliente ON public.tabcliente;
       public          postgres    false    220    268            3           2620    34414 &   tabdetalleventa triggertabdetalleventa    TRIGGER     �   CREATE TRIGGER triggertabdetalleventa BEFORE INSERT OR UPDATE ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 ?   DROP TRIGGER triggertabdetalleventa ON public.tabdetalleventa;
       public          postgres    false    268    227            .           2620    34412 ,   tabencabezadoventa triggertabencabezadoventa    TRIGGER     �   CREATE TRIGGER triggertabencabezadoventa BEFORE INSERT OR UPDATE ON public.tabencabezadoventa FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 E   DROP TRIGGER triggertabencabezadoventa ON public.tabencabezadoventa;
       public          postgres    false    268    226            7           2620    34408    tabkardex triggertabkardex    TRIGGER     �   CREATE TRIGGER triggertabkardex BEFORE INSERT OR UPDATE ON public.tabkardex FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 3   DROP TRIGGER triggertabkardex ON public.tabkardex;
       public          postgres    false    268    228            !           2620    34404    tabmarca triggertabmarca    TRIGGER     �   CREATE TRIGGER triggertabmarca BEFORE INSERT OR UPDATE ON public.tabmarca FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 1   DROP TRIGGER triggertabmarca ON public.tabmarca;
       public          postgres    false    223    268                       2620    34394    tabpermiso triggertabpermiso    TRIGGER     �   CREATE TRIGGER triggertabpermiso BEFORE INSERT OR UPDATE ON public.tabpermiso FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 5   DROP TRIGGER triggertabpermiso ON public.tabpermiso;
       public          postgres    false    218    268                       2620    34400     tabproveedor triggertabproveedor    TRIGGER     �   CREATE TRIGGER triggertabproveedor BEFORE INSERT OR UPDATE ON public.tabproveedor FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 9   DROP TRIGGER triggertabproveedor ON public.tabproveedor;
       public          postgres    false    268    221            (           2620    34410 ,   tabrecibomercancia triggertabrecibomercancia    TRIGGER     �   CREATE TRIGGER triggertabrecibomercancia BEFORE INSERT OR UPDATE ON public.tabrecibomercancia FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 E   DROP TRIGGER triggertabrecibomercancia ON public.tabrecibomercancia;
       public          postgres    false    225    268            $           2620    34407 !   tabarticulo triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabarticulo FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 :   DROP TRIGGER triggertabregborrados ON public.tabarticulo;
       public          postgres    false    224    268                       2620    34403 "   tabcategoria triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabcategoria FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 ;   DROP TRIGGER triggertabregborrados ON public.tabcategoria;
       public          postgres    false    222    268                       2620    34399     tabcliente triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabcliente FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 9   DROP TRIGGER triggertabregborrados ON public.tabcliente;
       public          postgres    false    268    220            4           2620    34415 %   tabdetalleventa triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 >   DROP TRIGGER triggertabregborrados ON public.tabdetalleventa;
       public          postgres    false    268    227            /           2620    34413 (   tabencabezadoventa triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabencabezadoventa FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 A   DROP TRIGGER triggertabregborrados ON public.tabencabezadoventa;
       public          postgres    false    226    268            8           2620    34409    tabkardex triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabkardex FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 8   DROP TRIGGER triggertabregborrados ON public.tabkardex;
       public          postgres    false    268    228            "           2620    34405    tabmarca triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabmarca FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 7   DROP TRIGGER triggertabregborrados ON public.tabmarca;
       public          postgres    false    268    223                       2620    34395     tabpermiso triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabpermiso FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 9   DROP TRIGGER triggertabregborrados ON public.tabpermiso;
       public          postgres    false    268    218                       2620    34401 "   tabproveedor triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabproveedor FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 ;   DROP TRIGGER triggertabregborrados ON public.tabproveedor;
       public          postgres    false    268    221            )           2620    34411 (   tabrecibomercancia triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabrecibomercancia FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 A   DROP TRIGGER triggertabregborrados ON public.tabrecibomercancia;
       public          postgres    false    225    268                       2620    34393     tabusuario triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabusuario FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 9   DROP TRIGGER triggertabregborrados ON public.tabusuario;
       public          postgres    false    268    215                       2620    34397 '   tabusuariopermiso triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabusuariopermiso FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 @   DROP TRIGGER triggertabregborrados ON public.tabusuariopermiso;
       public          postgres    false    268    219                       2620    34392    tabusuario triggertabusuario    TRIGGER     �   CREATE TRIGGER triggertabusuario BEFORE INSERT OR UPDATE ON public.tabusuario FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 5   DROP TRIGGER triggertabusuario ON public.tabusuario;
       public          postgres    false    268    215                       2620    34396 *   tabusuariopermiso triggertabusuariopermiso    TRIGGER     �   CREATE TRIGGER triggertabusuariopermiso BEFORE INSERT OR UPDATE ON public.tabusuariopermiso FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 C   DROP TRIGGER triggertabusuariopermiso ON public.tabusuariopermiso;
       public          postgres    false    219    268                       2620    34377    tabcliente uuidcliente    TRIGGER     u   CREATE TRIGGER uuidcliente BEFORE INSERT ON public.tabcliente FOR EACH ROW EXECUTE FUNCTION public.uuidtabcliente();
 /   DROP TRIGGER uuidcliente ON public.tabcliente;
       public          postgres    false    220    252                       2620    34378    tabproveedor uuidproveedor    TRIGGER     {   CREATE TRIGGER uuidproveedor BEFORE INSERT ON public.tabproveedor FOR EACH ROW EXECUTE FUNCTION public.uuidtabproveedor();
 3   DROP TRIGGER uuidproveedor ON public.tabproveedor;
       public          postgres    false    221    253            	           2620    34376    tabusuario uuidusuario    TRIGGER     u   CREATE TRIGGER uuidusuario BEFORE INSERT ON public.tabusuario FOR EACH ROW EXECUTE FUNCTION public.uuidtabusuario();
 /   DROP TRIGGER uuidusuario ON public.tabusuario;
       public          postgres    false    215    251            *           2620    34421 $   tabrecibomercancia validacionentrada    TRIGGER     �   CREATE TRIGGER validacionentrada BEFORE INSERT ON public.tabrecibomercancia FOR EACH ROW EXECUTE FUNCTION public.validacionentrada();
 =   DROP TRIGGER validacionentrada ON public.tabrecibomercancia;
       public          postgres    false    271    225            5           2620    34423     tabdetalleventa validacionsalida    TRIGGER     �   CREATE TRIGGER validacionsalida BEFORE INSERT ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.validacionsalida();
 9   DROP TRIGGER validacionsalida ON public.tabdetalleventa;
       public          postgres    false    272    227                       2620    34389    tabcliente validaremailcliente    TRIGGER     �   CREATE TRIGGER validaremailcliente BEFORE INSERT ON public.tabcliente FOR EACH ROW EXECUTE FUNCTION public.validaremailgenerico();
 7   DROP TRIGGER validaremailcliente ON public.tabcliente;
       public          postgres    false    220    267                       2620    34390 "   tabproveedor validaremailproveedor    TRIGGER     �   CREATE TRIGGER validaremailproveedor BEFORE INSERT ON public.tabproveedor FOR EACH ROW EXECUTE FUNCTION public.validaremailgenerico();
 ;   DROP TRIGGER validaremailproveedor ON public.tabproveedor;
       public          postgres    false    221    267            
           2620    34388    tabusuario validaremailusuario    TRIGGER     �   CREATE TRIGGER validaremailusuario BEFORE INSERT ON public.tabusuario FOR EACH ROW EXECUTE FUNCTION public.validaremailgenerico();
 7   DROP TRIGGER validaremailusuario ON public.tabusuario;
       public          postgres    false    215    267            �           2606    34259    tabrecibomercancia fkarticulo    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabrecibomercancia
    ADD CONSTRAINT fkarticulo FOREIGN KEY (eanart) REFERENCES public.tabarticulo(eanart) ON DELETE CASCADE;
 G   ALTER TABLE ONLY public.tabrecibomercancia DROP CONSTRAINT fkarticulo;
       public          postgres    false    225    3306    224            �           2606    34300    tabdetalleventa fkarticulo    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabdetalleventa
    ADD CONSTRAINT fkarticulo FOREIGN KEY (eanart) REFERENCES public.tabarticulo(eanart) ON DELETE CASCADE;
 D   ALTER TABLE ONLY public.tabdetalleventa DROP CONSTRAINT fkarticulo;
       public          postgres    false    227    3306    224                       2606    34318    tabkardex fkarticulo    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabkardex
    ADD CONSTRAINT fkarticulo FOREIGN KEY (eanart) REFERENCES public.tabarticulo(eanart) ON DELETE CASCADE;
 >   ALTER TABLE ONLY public.tabkardex DROP CONSTRAINT fkarticulo;
       public          postgres    false    228    3306    224            �           2606    34247    tabarticulo fkcategoria    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabarticulo
    ADD CONSTRAINT fkcategoria FOREIGN KEY (conseccateg) REFERENCES public.tabcategoria(conseccateg) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.tabarticulo DROP CONSTRAINT fkcategoria;
       public          postgres    false    224    222    3301                        2606    34305 "   tabdetalleventa fkconseccotizacion    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabdetalleventa
    ADD CONSTRAINT fkconseccotizacion FOREIGN KEY (conseccotizacion) REFERENCES public.tabencabezadoventa(conseccotizacion) ON DELETE CASCADE;
 L   ALTER TABLE ONLY public.tabdetalleventa DROP CONSTRAINT fkconseccotizacion;
       public          postgres    false    227    3310    226                       2606    34295    tabdetalleventa fkconsecfactura    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabdetalleventa
    ADD CONSTRAINT fkconsecfactura FOREIGN KEY (consecfactura) REFERENCES public.tabencabezadoventa(consecfactura) ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.tabdetalleventa DROP CONSTRAINT fkconsecfactura;
       public          postgres    false    226    3312    227                       2606    34328    tabkardex fkdetalleventa    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabkardex
    ADD CONSTRAINT fkdetalleventa FOREIGN KEY (consecdetventa) REFERENCES public.tabdetalleventa(consecdetventa) ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.tabkardex DROP CONSTRAINT fkdetalleventa;
       public          postgres    false    3316    228    227                       2606    34290    tabdetalleventa fkidencventa    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabdetalleventa
    ADD CONSTRAINT fkidencventa FOREIGN KEY (idencventa) REFERENCES public.tabencabezadoventa(idencventa) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.tabdetalleventa DROP CONSTRAINT fkidencventa;
       public          postgres    false    227    3314    226            �           2606    34242    tabarticulo fkmarca    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabarticulo
    ADD CONSTRAINT fkmarca FOREIGN KEY (consecmarca) REFERENCES public.tabmarca(consecmarca) ON DELETE CASCADE;
 =   ALTER TABLE ONLY public.tabarticulo DROP CONSTRAINT fkmarca;
       public          postgres    false    224    3303    223            �           2606    34194    tabusuariopermiso fkpermiso    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabusuariopermiso
    ADD CONSTRAINT fkpermiso FOREIGN KEY (consecpermiso) REFERENCES public.tabpermiso(consecpermiso);
 E   ALTER TABLE ONLY public.tabusuariopermiso DROP CONSTRAINT fkpermiso;
       public          postgres    false    218    219    3289            �           2606    34264    tabrecibomercancia fkproveedor    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabrecibomercancia
    ADD CONSTRAINT fkproveedor FOREIGN KEY (idprov) REFERENCES public.tabproveedor(idprov) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.tabrecibomercancia DROP CONSTRAINT fkproveedor;
       public          postgres    false    225    221    3297                       2606    34323    tabkardex fkrecibomercancia    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabkardex
    ADD CONSTRAINT fkrecibomercancia FOREIGN KEY (consecrecibomcia) REFERENCES public.tabrecibomercancia(consecrecibomcia) ON DELETE CASCADE;
 E   ALTER TABLE ONLY public.tabkardex DROP CONSTRAINT fkrecibomercancia;
       public          postgres    false    228    3308    225            �           2606    34189    tabusuariopermiso fkusuario    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabusuariopermiso
    ADD CONSTRAINT fkusuario FOREIGN KEY (idusuario) REFERENCES public.tabusuario(idusuario);
 E   ALTER TABLE ONLY public.tabusuariopermiso DROP CONSTRAINT fkusuario;
       public          postgres    false    3281    215    219            �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �     