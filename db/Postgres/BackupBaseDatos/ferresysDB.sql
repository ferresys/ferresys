PGDMP     $                    {         
   dbFerreSys    15.3    15.3 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    95041 
   dbFerreSys    DATABASE     �   CREATE DATABASE "dbFerreSys" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Colombia.1252';
    DROP DATABASE "dbFerreSys";
                postgres    false                        3079    95243 	   uuid-ossp 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
    DROP EXTENSION "uuid-ossp";
                   false            �           0    0    EXTENSION "uuid-ossp"    COMMENT     W   COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
                        false    2            �            1255    95285     actualizarstockvalunitentradas()    FUNCTION     �  CREATE FUNCTION public.actualizarstockvalunitentradas() RETURNS trigger
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
       public          postgres    false            
           1255    95287    actualizarstockvalunitsalidas()    FUNCTION     �  CREATE FUNCTION public.actualizarstockvalunitsalidas() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  zValStock tabArticulo.valStock%type;
  zValUnit tabArticulo.valUnit%type;
  --zPorcentaje tabArticulo.porcentaje%type;

BEGIN
--select Porcentaje into zPorcentaje from tabArticulo where eanArt = NEW.eanArt;
 -- IF NEW.tipoMov = TRUE THEN
    	--zValStock := (SELECT COALESCE(valStock, 0) + NEW.cantArt FROM tabArticulo WHERE eanArt = NEW.eanArt);
    	--zValUnit := NEW.valProm * zPorcentaje ; --(el porcentaje debe ser ingresado como 1.20, 1.30, 1.10..etc)
	--zValUnit :=(select valProm from tabKardex where consecKardex= consecKardex)* zPorcentaje ;
  	-- ELSIF NEW.tipoMov = FALSE THEN
    	zValStock := (SELECT COALESCE(valStock, 0) - NEW.cantArt FROM tabArticulo WHERE eanArt = NEW.eanArt);
    	zValUnit := (SELECT valUnit FROM tabArticulo WHERE eanArt = NEW.eanArt);
  --END IF;*/

  UPDATE tabArticulo SET valStock = zValStock, valUnit = zValUnit WHERE eanArt = NEW.eanArt;

RETURN NEW;
END;
$$;
 6   DROP FUNCTION public.actualizarstockvalunitsalidas();
       public          postgres    false                       1255    95291 2   asignarpermisousuario(character varying, smallint)    FUNCTION     �  CREATE FUNCTION public.asignarpermisousuario(zidusuario character varying, zconsecpermiso smallint) RETURNS void
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
       public          postgres    false            �            1255    95223    consecutivotabcategoria()    FUNCTION     �   CREATE FUNCTION public.consecutivotabcategoria() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecCateg := (SELECT COALESCE(MAX(consecCateg), 0) + 1 FROM tabCategoria);
    RETURN NEW;
END;
$$;
 0   DROP FUNCTION public.consecutivotabcategoria();
       public          postgres    false            �            1255    95230    consecutivotabdetalleventa()    FUNCTION     �   CREATE FUNCTION public.consecutivotabdetalleventa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecDetVenta := (SELECT COALESCE(MAX(consecDetVenta), 0) + 1 FROM tabDetalleVenta);
    RETURN NEW;
END;
$$;
 3   DROP FUNCTION public.consecutivotabdetalleventa();
       public          postgres    false            �            1255    95227    consecutivotabencabezadoventa()    FUNCTION     �   CREATE FUNCTION public.consecutivotabencabezadoventa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.idEncVenta := (SELECT COALESCE(MAX(idEncVenta), 0) + 1 FROM tabEncabezadoVenta);
    RETURN NEW;
END;
$$;
 6   DROP FUNCTION public.consecutivotabencabezadoventa();
       public          postgres    false            �            1255    95228     consecutivotabencabezadoventa1()    FUNCTION       CREATE FUNCTION public.consecutivotabencabezadoventa1() RETURNS trigger
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
       public          postgres    false            �            1255    95229     consecutivotabencabezadoventa2()    FUNCTION       CREATE FUNCTION public.consecutivotabencabezadoventa2() RETURNS trigger
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
       public          postgres    false            �            1255    95225    consecutivotabkardex()    FUNCTION     �   CREATE FUNCTION public.consecutivotabkardex() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecKardex := (SELECT COALESCE(MAX(consecKardex), 0) + 1 FROM tabKardex);
    RETURN NEW;
END;
$$;
 -   DROP FUNCTION public.consecutivotabkardex();
       public          postgres    false            �            1255    95224    consecutivotabmarca()    FUNCTION     �   CREATE FUNCTION public.consecutivotabmarca() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecMarca := (SELECT COALESCE(MAX(consecMarca), 0) + 1 FROM tabMarca);
    RETURN NEW;
END;
$$;
 ,   DROP FUNCTION public.consecutivotabmarca();
       public          postgres    false            �            1255    95221    consecutivotabpermiso()    FUNCTION     �   CREATE FUNCTION public.consecutivotabpermiso() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecPermiso := (SELECT COALESCE(MAX(consecPermiso), 0) + 1 FROM tabPermiso);
    RETURN NEW;
END;
$$;
 .   DROP FUNCTION public.consecutivotabpermiso();
       public          postgres    false            �            1255    95226    consecutivotabrecibomercancia()    FUNCTION     �   CREATE FUNCTION public.consecutivotabrecibomercancia() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecReciboMcia := (SELECT COALESCE(MAX(consecReciboMcia), 0) + 1 FROM tabReciboMercancia);
    RETURN NEW;
END;
$$;
 6   DROP FUNCTION public.consecutivotabrecibomercancia();
       public          postgres    false            �            1255    95231    consecutivotabregborrados()    FUNCTION     �   CREATE FUNCTION public.consecutivotabregborrados() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecRegBor := (SELECT COALESCE(MAX(consecRegBor), 0) + 1 FROM tabRegBorrados);
    RETURN NEW;
END;
$$;
 2   DROP FUNCTION public.consecutivotabregborrados();
       public          postgres    false            �            1255    95222    consecutivotabusuariopermiso()    FUNCTION     �   CREATE FUNCTION public.consecutivotabusuariopermiso() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecUsuarioPermiso := (SELECT COALESCE(MAX(consecUsuarioPermiso), 0) + 1 FROM tabUsuarioPermiso);
    RETURN NEW;
END;
$$;
 5   DROP FUNCTION public.consecutivotabusuariopermiso();
       public          postgres    false                       1255    95296 �   insertarticulo(character varying, character varying, smallint, smallint, text, numeric, numeric, integer, integer, integer, date)    FUNCTION     I  CREATE FUNCTION public.insertarticulo(zeanart character varying, znomart character varying, zconsecmarca smallint, zconseccateg smallint, zdescart text, zporcentaje numeric, ziva numeric, zstockmin integer, zstockmax integer, zvalreorden integer, zfecvence date) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE

    articuloExistente BOOLEAN;
    zMarca tabMarca.consecMarca%type;
    zCategoria tabCategoria.consecCateg%type;

BEGIN
    -- Verificamos si ya existe un registro con el mismo eanArt
    SELECT EXISTS (SELECT 1 FROM tabArticulo WHERE eanArt = zEanArt) INTO articuloExistente;

    IF articuloExistente THEN
        RAISE EXCEPTION 'Ya existe un artículo con el mismo EAN: %', zEanArt;

    ELSE
        -- Obtener los valores de marca y categoría
        SELECT consecMarca INTO zMarca FROM tabMarca WHERE consecMarca = zConsecMarca;
        SELECT consecCateg INTO zCategoria FROM tabCategoria WHERE consecCateg = zConsecCateg;

        -- Insertar el nuevo artículo si no existe
        INSERT INTO tabArticulo(eanArt, nomArt, consecMarca, consecCateg, descArt, porcentaje, iva, stockMin, stockMax, valReorden, fecVence)
        VALUES (zEanArt, zNomArt, zMarca, zCategoria, zDescArt, zPorcentaje, zIva, zStockMin, zStockMax, zValReorden, zFecVence);

        RAISE NOTICE 'Artículo registrado con éxito';
    END IF;
END;
$$;
   DROP FUNCTION public.insertarticulo(zeanart character varying, znomart character varying, zconsecmarca smallint, zconseccateg smallint, zdescart text, zporcentaje numeric, ziva numeric, zstockmin integer, zstockmax integer, zvalreorden integer, zfecvence date);
       public          postgres    false                       1255    95295 "   insertcategoria(character varying)    FUNCTION     �  CREATE FUNCTION public.insertcategoria(znomcateg character varying) RETURNS void
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
       public          postgres    false                       1255    95292 �   insertcliente(character varying, boolean, character varying, character varying, character varying, character varying, character varying, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.insertcliente(zidcli character varying, ztipocli boolean, znomcli character varying, zapecli character varying, znomreplegal character varying, znomempresa character varying, ztelcli character varying, zemailcli character varying, zdircli character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    clienteExistente BOOLEAN;

BEGIN
    -- Verificamos si ya existe un registro con el mismo idCli
    SELECT EXISTS (SELECT 1 FROM tabCliente WHERE idCli = zIdCli) INTO clienteExistente;

    IF clienteExistente THEN
        RAISE EXCEPTION 'Cliente ya esta registrado: %', zIdCli;

    ELSE

        -- Insertar nuevo cliente si no existe
        INSERT INTO tabCliente (idCli, tipoCli, nomCli, apeCli, nomRepLegal, nomEmpresa, telCli, emailCli, dirCli)
        VALUES (zIdCli, zTipoCli, zNomCli, zApeCli, zNomRepLegal, zNomEmpresa, zTelCli, zEmailCli, zDirCli);
        RAISE NOTICE 'Cliente registrado con éxito';
    END IF;
END;
$$;
   DROP FUNCTION public.insertcliente(zidcli character varying, ztipocli boolean, znomcli character varying, zapecli character varying, znomreplegal character varying, znomempresa character varying, ztelcli character varying, zemailcli character varying, zdircli character varying);
       public          postgres    false                       1255    95310 7   insertdetalleventa(character varying, integer, numeric)    FUNCTION     N  CREATE FUNCTION public.insertdetalleventa(zeanart character varying, zcantart integer, zdescuento numeric) RETURNS bigint
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
    --SELECT consecFactura INTO zConsecFactura FROM tabEncabezadoVenta WHERE consecFactura ORDER BY idEncVenta DESC LIMIT 1 ;
	--SELECT consecCotizacion INTO zConsecCotizacion FROM tabEncabezadoVenta WHERE consecCotizacion  ORDER BY idEncVenta DESC LIMIT 1 ;
	SELECT consecFactura INTO zConsecFactura FROM tabEncabezadoVenta ORDER BY idEncVenta DESC LIMIT 1 ;
    SELECT consecCotizacion INTO zConsecCotizacion FROM tabEncabezadoVenta  ORDER BY  idEncVenta  DESC LIMIT 1 ;
    
	-- Insertar los datos en la tabla "tabDetalleVenta"
    INSERT INTO tabDetalleVenta (eanArt, cantArt, valUnit, subTotal, iva, descuento, totalPagar, consecFactura, consecCotizacion,idEncVenta )
    VALUES (zEanArt, zCantArt, zValUnit, zSubTotal, zIva, zDescuento, zTotalPagar, zConsecFactura, zConsecCotizacion,zIdEncVenta);
   
	RETURN zIdEncVenta;
	
END;
$$;
 j   DROP FUNCTION public.insertdetalleventa(zeanart character varying, zcantart integer, zdescuento numeric);
       public          postgres    false                       1255    95302 =   insertencventa(boolean, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.insertencventa(ztipofactura boolean, zidcli character varying, zciudad character varying, OUT zconsecfactura bigint, OUT zconseccotizacion bigint) RETURNS record
    LANGUAGE plpgsql
    AS $$

DECLARE 
zCliente VARCHAR;

BEGIN
    IF zTipoFactura = TRUE THEN -- Factura legal
	    SELECT idCli INTO zCliente from tabCliente where idCli=zIdCli;
        INSERT INTO tabEncabezadoVenta (tipoFactura, idCli, ciudad)
        VALUES (zTipoFactura, zCliente, zCiudad )
        RETURNING consecFactura INTO zConsecFactura;
	    zConsecCotizacion:= NULL;
		
    ELSE -- Cotización
	    SELECT idCli INTO zCliente from tabCliente where idCli=zIdCli;
        INSERT INTO tabEncabezadoVenta  (tipoFactura, idCli, ciudad)
        VALUES (zTipoFactura, zCliente, zCiudad)
        RETURNING consecCotizacion INTO zConsecCotizacion;
		zConsecFactura := NULL; -- No asignar consecutivo para cotizaciones
    END IF;
END;
$$;
 �   DROP FUNCTION public.insertencventa(ztipofactura boolean, zidcli character varying, zciudad character varying, OUT zconsecfactura bigint, OUT zconseccotizacion bigint);
       public          postgres    false                       1255    95297    insertkardexentrada()    FUNCTION     ]  CREATE FUNCTION public.insertkardexentrada() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
zValProm tabKardex.valProm%type;
zValTotal tabReciboMercancia.valTotal%type;
zReciboMcia tabReciboMercancia.consecReciboMcia%type;
--zCantArt INTEGER;
BEGIN
    /* Si el tipo de movimiento es entrada*/
	SELECT valTotal INTO zValTotal FROM tabReciboMercancia where consecReciboMcia= new.consecReciboMcia;
    SELECT consecReciboMcia INTO zReciboMcia FROM tabReciboMercancia  where consecReciboMcia= new.consecReciboMcia;
	--SELECT cantArt INTO zCantArt FROM tabReciboMercancia where consecReciboMcia= new.consecReciboMcia;
	--IF zTipoMov = TRUE THEN
    zValProm := zValTotal / new.cantArt;
    
	INSERT INTO tabKardex (consecReciboMcia,tipoMov, eanArt, cantArt, valProm) 
    VALUES (zReciboMcia, TRUE, NEW.eanArt, NEW.cantArt, zValProm);
        
    RETURN NEW;
   -- END IF;

    /* Si el tipo de movimiento es salida*/
   -- IF zTipoMov = FALSE THEN
       /* INSERT INTO tabKardex (
        tipoMov, eanArt, cantArt) 
        VALUES (FALSE, NEW.eanArt, NEW.cantArt);
        RETURN NEW;
    --END IF;*/
END;
$$;
 ,   DROP FUNCTION public.insertkardexentrada();
       public          postgres    false                       1255    95299    insertkardexsalida()    FUNCTION     ]  CREATE FUNCTION public.insertkardexsalida() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
zValProm tabKardex.valProm%type :=0;
--zValTotal NUMERIC;
--zReciboMcia BIGINT;
zConsecDetVenta tabDetalleVenta.consecDetVenta%type;
--zCantArt INTEGER;
BEGIN
    /* Si el tipo de movimiento es salida*/
	
	--SELECT valTotal INTO zValTotal FROM tabReciboMercancia where consecReciboMcia= new.consecReciboMcia;
    SELECT consecDetVenta INTO zConsecDetVenta FROM tabDetalleVenta  where consecDetVenta= new.consecDetVenta;
	--SELECT cantArt INTO zCantArt FROM tabReciboMercancia where consecReciboMcia= new.consecReciboMcia;
	--IF zTipoMov = TRUE THEN
       -- zValProm := zValTotal / new.cantArt;
        INSERT INTO tabKardex (
        tipoMov, eanArt, cantArt, consecDetVenta) 
        VALUES (FALSE, NEW.eanArt, NEW.cantArt, zConsecDetVenta);
        RETURN NEW;
   -- END IF;

    /* Si el tipo de movimiento es salida*/
   -- IF zTipoMov = FALSE THEN
       /* INSERT INTO tabKardex (
        tipoMov, eanArt, cantArt) 
        VALUES (FALSE, NEW.eanArt, NEW.cantArt);
        RETURN NEW;
    --END IF;*/
END;
$$;
 +   DROP FUNCTION public.insertkardexsalida();
       public          postgres    false            �            1255    95294    insertmarca(character varying)    FUNCTION     f  CREATE FUNCTION public.insertmarca(znommarca character varying) RETURNS void
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
       public          postgres    false                       1255    95290 3   insertpermiso(character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.insertpermiso(znompermiso character varying, zdescpermiso character varying) RETURNS void
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
       public          postgres    false                       1255    95293 n   insertproveedor(character varying, character varying, character varying, character varying, character varying)    FUNCTION     4  CREATE FUNCTION public.insertproveedor(zidprov character varying, znomprov character varying, ztelprov character varying, zemailprov character varying, zdirprov character varying) RETURNS void
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

        INSERT INTO tabProveedor(idProv, nomProv, telProv, emailProv, dirProv)
        VALUES (zIdProv, zNomProv, zTelProv, zEmailProv, zDirProv);

        RAISE NOTICE 'Proveedor registrado con éxito';
    END IF;
END;
$$;
 �   DROP FUNCTION public.insertproveedor(zidprov character varying, znomprov character varying, ztelprov character varying, zemailprov character varying, zdirprov character varying);
       public          postgres    false                       1255    95301 g   insertrecibomercancia(character varying, integer, numeric, character varying, smallint, smallint, text)    FUNCTION     <  CREATE FUNCTION public.insertrecibomercancia(zeanart character varying, zcantart integer, zvalcompra numeric, zidprov character varying, zconsecmarca smallint, zconseccateg smallint, zobservacion text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    zMarca tabMarca.consecMarca%type;
    zValTotal tabReciboMercancia.valTotal%type;

BEGIN

SELECT consecMarca INTO zMarca FROM tabMarca WHERE consecMarca = zConsecMarca;
zValTotal := zCantArt * zValCompra;

IF EXISTS (SELECT 1 FROM tabReciboMercancia WHERE eanArt = zEanArt) THEN

   INSERT INTO tabReciboMercancia(eanArt, cantArt, valCompra, valTotal, idProv, consecMarca, observacion)
        VALUES (zEanArt, zCantArt, zValCompra, zValTotal, zIdProv, zConsecMarca, zObservacion);
	
ELSE     
        -- Insertar el nuevo registro de recibo de mercancia.
   INSERT INTO tabReciboMercancia(eanArt, cantArt, valCompra, valTotal, idProv, consecMarca, observacion)
   VALUES (zEanArt, zCantArt, zValCompra, zValTotal, zIdProv, zConsecMarca, zObservacion);

   RAISE NOTICE 'Artículo registrado con éxito';
		
END IF;	
END;
$$;
 �   DROP FUNCTION public.insertrecibomercancia(zeanart character varying, zcantart integer, zvalcompra numeric, zidprov character varying, zconsecmarca smallint, zconseccateg smallint, zobservacion text);
       public          postgres    false                       1255    95289    insertusuario(character varying, character varying, character varying, character varying, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.insertusuario(zidusuario character varying, znomusuario character varying, zapeusuario character varying, zemailusuario character varying, zusuario character varying, zpassword character varying) RETURNS void
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
       public          postgres    false            �            1255    95260    movimientosusuario()    FUNCTION       CREATE FUNCTION public.movimientosusuario() RETURNS trigger
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
       public          postgres    false            �            1255    95255    uuidtabcliente()    FUNCTION     �   CREATE FUNCTION public.uuidtabcliente() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.codCli := uuid_generate_v4();
    RETURN NEW;
END;
$$;
 '   DROP FUNCTION public.uuidtabcliente();
       public          postgres    false            �            1255    95256    uuidtabproveedor()    FUNCTION     �   CREATE FUNCTION public.uuidtabproveedor() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.codProv := uuid_generate_v4();
    RETURN NEW;
END;
$$;
 )   DROP FUNCTION public.uuidtabproveedor();
       public          postgres    false            �            1255    95254    uuidtabusuario()    FUNCTION     �   CREATE FUNCTION public.uuidtabusuario() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.codUsuario := uuid_generate_v4();
    RETURN NEW;
END;
$$;
 '   DROP FUNCTION public.uuidtabusuario();
       public          postgres    false            �            1259    95109    tabarticulo    TABLE     o  CREATE TABLE public.tabarticulo (
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
       public         heap    postgres    false            �            1259    95095    tabcategoria    TABLE       CREATE TABLE public.tabcategoria (
    conseccateg smallint NOT NULL,
    nomcateg character varying NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
     DROP TABLE public.tabcategoria;
       public         heap    postgres    false            �            1259    95075 
   tabcliente    TABLE        CREATE TABLE public.tabcliente (
    codcli uuid NOT NULL,
    idcli character varying NOT NULL,
    tipocli boolean DEFAULT true NOT NULL,
    nomcli character varying,
    apecli character varying,
    nomreplegal character varying,
    nomempresa character varying,
    telcli character varying NOT NULL,
    emailcli character varying NOT NULL,
    dircli character varying NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
    DROP TABLE public.tabcliente;
       public         heap    postgres    false            �            1259    95166    tabdetalleventa    TABLE     F  CREATE TABLE public.tabdetalleventa (
    consecdetventa bigint NOT NULL,
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
    userupdate character varying,
    idencventa bigint
);
 #   DROP TABLE public.tabdetalleventa;
       public         heap    postgres    false            �            1259    95149    tabencabezadoventa    TABLE     �  CREATE TABLE public.tabencabezadoventa (
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
       public         heap    postgres    false            �            1259    95190 	   tabkardex    TABLE     �  CREATE TABLE public.tabkardex (
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
       public         heap    postgres    false            �            1259    95102    tabmarca    TABLE       CREATE TABLE public.tabmarca (
    consecmarca smallint NOT NULL,
    nommarca character varying NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
    DROP TABLE public.tabmarca;
       public         heap    postgres    false            �            1259    95051 
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
       public         heap    postgres    false            �            1259    95085    tabproveedor    TABLE     �  CREATE TABLE public.tabproveedor (
    codprov uuid NOT NULL,
    idprov character varying NOT NULL,
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
       public         heap    postgres    false            �            1259    95127    tabrecibomercancia    TABLE     �  CREATE TABLE public.tabrecibomercancia (
    consecrecibomcia bigint NOT NULL,
    eanart character varying NOT NULL,
    cantart integer NOT NULL,
    valcompra numeric(10,0),
    valtotal numeric(10,0),
    idprov character varying NOT NULL,
    consecmarca smallint NOT NULL,
    observacion text,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
 &   DROP TABLE public.tabrecibomercancia;
       public         heap    postgres    false            �            1259    95213    tabregborrados    TABLE     �   CREATE TABLE public.tabregborrados (
    consecregbor bigint NOT NULL,
    fecdelete timestamp without time zone,
    userdelete character varying NOT NULL,
    nomtabla character varying NOT NULL
);
 "   DROP TABLE public.tabregborrados;
       public         heap    postgres    false            �            1259    95042 
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
       public         heap    postgres    false            �            1259    95058    tabusuariopermiso    TABLE     ?  CREATE TABLE public.tabusuariopermiso (
    consecusuariopermiso smallint NOT NULL,
    idusuario character varying NOT NULL,
    consecpermiso smallint NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
 %   DROP TABLE public.tabusuariopermiso;
       public         heap    postgres    false            �          0    95109    tabarticulo 
   TABLE DATA           �   COPY public.tabarticulo (eanart, nomart, consecmarca, conseccateg, descart, valunit, porcentaje, iva, valstock, stockmin, stockmax, valreorden, fecvence, estado, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    222   �      �          0    95095    tabcategoria 
   TABLE DATA           k   COPY public.tabcategoria (conseccateg, nomcateg, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    220   �      �          0    95075 
   tabcliente 
   TABLE DATA           �   COPY public.tabcliente (codcli, idcli, tipocli, nomcli, apecli, nomreplegal, nomempresa, telcli, emailcli, dircli, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    218         �          0    95166    tabdetalleventa 
   TABLE DATA           �   COPY public.tabdetalleventa (consecdetventa, consecfactura, conseccotizacion, eanart, cantart, valunit, subtotal, iva, descuento, totalpagar, fecinsert, userinsert, fecupdate, userupdate, idencventa) FROM stdin;
    public          postgres    false    225   	      �          0    95149    tabencabezadoventa 
   TABLE DATA           �   COPY public.tabencabezadoventa (idencventa, consecfactura, conseccotizacion, tipofactura, estadofactura, idcli, ciudad, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    224   �	      �          0    95190 	   tabkardex 
   TABLE DATA           �   COPY public.tabkardex (conseckardex, consecrecibomcia, consecdetventa, tipomov, eanart, cantart, valprom, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    226    
      �          0    95102    tabmarca 
   TABLE DATA           g   COPY public.tabmarca (consecmarca, nommarca, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    221   �
      �          0    95051 
   tabpermiso 
   TABLE DATA           z   COPY public.tabpermiso (consecpermiso, nompermiso, descpermiso, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    216   .      �          0    95085    tabproveedor 
   TABLE DATA           �   COPY public.tabproveedor (codprov, idprov, nomprov, telprov, emailprov, dirprov, estado, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    219   �      �          0    95127    tabrecibomercancia 
   TABLE DATA           �   COPY public.tabrecibomercancia (consecrecibomcia, eanart, cantart, valcompra, valtotal, idprov, consecmarca, observacion, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    223   �      �          0    95213    tabregborrados 
   TABLE DATA           W   COPY public.tabregborrados (consecregbor, fecdelete, userdelete, nomtabla) FROM stdin;
    public          postgres    false    227   Y      �          0    95042 
   tabusuario 
   TABLE DATA           �   COPY public.tabusuario (codusuario, idusuario, nomusuario, apeusuario, emailusuario, usuario, password, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    215   �      �          0    95058    tabusuariopermiso 
   TABLE DATA           �   COPY public.tabusuariopermiso (consecusuariopermiso, idusuario, consecpermiso, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    217   �      �           2606    95116    tabarticulo tabarticulo_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.tabarticulo
    ADD CONSTRAINT tabarticulo_pkey PRIMARY KEY (eanart);
 F   ALTER TABLE ONLY public.tabarticulo DROP CONSTRAINT tabarticulo_pkey;
       public            postgres    false    222            �           2606    95101    tabcategoria tabcategoria_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.tabcategoria
    ADD CONSTRAINT tabcategoria_pkey PRIMARY KEY (conseccateg);
 H   ALTER TABLE ONLY public.tabcategoria DROP CONSTRAINT tabcategoria_pkey;
       public            postgres    false    220            �           2606    95084    tabcliente tabcliente_idcli_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.tabcliente
    ADD CONSTRAINT tabcliente_idcli_key UNIQUE (idcli);
 I   ALTER TABLE ONLY public.tabcliente DROP CONSTRAINT tabcliente_idcli_key;
       public            postgres    false    218            �           2606    95082    tabcliente tabcliente_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.tabcliente
    ADD CONSTRAINT tabcliente_pkey PRIMARY KEY (codcli);
 D   ALTER TABLE ONLY public.tabcliente DROP CONSTRAINT tabcliente_pkey;
       public            postgres    false    218            �           2606    95174 $   tabdetalleventa tabdetalleventa_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.tabdetalleventa
    ADD CONSTRAINT tabdetalleventa_pkey PRIMARY KEY (consecdetventa);
 N   ALTER TABLE ONLY public.tabdetalleventa DROP CONSTRAINT tabdetalleventa_pkey;
       public            postgres    false    225            �           2606    95160 :   tabencabezadoventa tabencabezadoventa_conseccotizacion_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.tabencabezadoventa
    ADD CONSTRAINT tabencabezadoventa_conseccotizacion_key UNIQUE (conseccotizacion);
 d   ALTER TABLE ONLY public.tabencabezadoventa DROP CONSTRAINT tabencabezadoventa_conseccotizacion_key;
       public            postgres    false    224            �           2606    95158 7   tabencabezadoventa tabencabezadoventa_consecfactura_key 
   CONSTRAINT     {   ALTER TABLE ONLY public.tabencabezadoventa
    ADD CONSTRAINT tabencabezadoventa_consecfactura_key UNIQUE (consecfactura);
 a   ALTER TABLE ONLY public.tabencabezadoventa DROP CONSTRAINT tabencabezadoventa_consecfactura_key;
       public            postgres    false    224            �           2606    95156 *   tabencabezadoventa tabencabezadoventa_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.tabencabezadoventa
    ADD CONSTRAINT tabencabezadoventa_pkey PRIMARY KEY (idencventa);
 T   ALTER TABLE ONLY public.tabencabezadoventa DROP CONSTRAINT tabencabezadoventa_pkey;
       public            postgres    false    224            �           2606    95197    tabkardex tabkardex_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.tabkardex
    ADD CONSTRAINT tabkardex_pkey PRIMARY KEY (conseckardex);
 B   ALTER TABLE ONLY public.tabkardex DROP CONSTRAINT tabkardex_pkey;
       public            postgres    false    226            �           2606    95108    tabmarca tabmarca_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.tabmarca
    ADD CONSTRAINT tabmarca_pkey PRIMARY KEY (consecmarca);
 @   ALTER TABLE ONLY public.tabmarca DROP CONSTRAINT tabmarca_pkey;
       public            postgres    false    221            �           2606    95057    tabpermiso tabpermiso_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.tabpermiso
    ADD CONSTRAINT tabpermiso_pkey PRIMARY KEY (consecpermiso);
 D   ALTER TABLE ONLY public.tabpermiso DROP CONSTRAINT tabpermiso_pkey;
       public            postgres    false    216            �           2606    95094 $   tabproveedor tabproveedor_idprov_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.tabproveedor
    ADD CONSTRAINT tabproveedor_idprov_key UNIQUE (idprov);
 N   ALTER TABLE ONLY public.tabproveedor DROP CONSTRAINT tabproveedor_idprov_key;
       public            postgres    false    219            �           2606    95092    tabproveedor tabproveedor_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.tabproveedor
    ADD CONSTRAINT tabproveedor_pkey PRIMARY KEY (codprov);
 H   ALTER TABLE ONLY public.tabproveedor DROP CONSTRAINT tabproveedor_pkey;
       public            postgres    false    219            �           2606    95133 *   tabrecibomercancia tabrecibomercancia_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.tabrecibomercancia
    ADD CONSTRAINT tabrecibomercancia_pkey PRIMARY KEY (consecrecibomcia);
 T   ALTER TABLE ONLY public.tabrecibomercancia DROP CONSTRAINT tabrecibomercancia_pkey;
       public            postgres    false    223            �           2606    95219 "   tabregborrados tabregborrados_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.tabregborrados
    ADD CONSTRAINT tabregborrados_pkey PRIMARY KEY (consecregbor);
 L   ALTER TABLE ONLY public.tabregborrados DROP CONSTRAINT tabregborrados_pkey;
       public            postgres    false    227            �           2606    95050 #   tabusuario tabusuario_idusuario_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.tabusuario
    ADD CONSTRAINT tabusuario_idusuario_key UNIQUE (idusuario);
 M   ALTER TABLE ONLY public.tabusuario DROP CONSTRAINT tabusuario_idusuario_key;
       public            postgres    false    215            �           2606    95048    tabusuario tabusuario_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.tabusuario
    ADD CONSTRAINT tabusuario_pkey PRIMARY KEY (codusuario);
 D   ALTER TABLE ONLY public.tabusuario DROP CONSTRAINT tabusuario_pkey;
       public            postgres    false    215            �           2606    95064 (   tabusuariopermiso tabusuariopermiso_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.tabusuariopermiso
    ADD CONSTRAINT tabusuariopermiso_pkey PRIMARY KEY (consecusuariopermiso);
 R   ALTER TABLE ONLY public.tabusuariopermiso DROP CONSTRAINT tabusuariopermiso_pkey;
       public            postgres    false    217                       2620    95234 &   tabcategoria autoincrementtabcategoria    TRIGGER     �   CREATE TRIGGER autoincrementtabcategoria BEFORE INSERT ON public.tabcategoria FOR EACH ROW EXECUTE FUNCTION public.consecutivotabcategoria();
 ?   DROP TRIGGER autoincrementtabcategoria ON public.tabcategoria;
       public          postgres    false    230    220                       2620    95241 ,   tabdetalleventa autoincrementtabdetalleventa    TRIGGER     �   CREATE TRIGGER autoincrementtabdetalleventa BEFORE INSERT ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.consecutivotabdetalleventa();
 E   DROP TRIGGER autoincrementtabdetalleventa ON public.tabdetalleventa;
       public          postgres    false    237    225                       2620    95238 2   tabencabezadoventa autoincrementtabencabezadoventa    TRIGGER     �   CREATE TRIGGER autoincrementtabencabezadoventa BEFORE INSERT ON public.tabencabezadoventa FOR EACH ROW EXECUTE FUNCTION public.consecutivotabencabezadoventa();
 K   DROP TRIGGER autoincrementtabencabezadoventa ON public.tabencabezadoventa;
       public          postgres    false    224    234                       2620    95239 3   tabencabezadoventa autoincrementtabencabezadoventa1    TRIGGER     �   CREATE TRIGGER autoincrementtabencabezadoventa1 BEFORE INSERT ON public.tabencabezadoventa FOR EACH ROW EXECUTE FUNCTION public.consecutivotabencabezadoventa1();
 L   DROP TRIGGER autoincrementtabencabezadoventa1 ON public.tabencabezadoventa;
       public          postgres    false    224    235                       2620    95240 3   tabencabezadoventa autoincrementtabencabezadoventa2    TRIGGER     �   CREATE TRIGGER autoincrementtabencabezadoventa2 BEFORE INSERT ON public.tabencabezadoventa FOR EACH ROW EXECUTE FUNCTION public.consecutivotabencabezadoventa2();
 L   DROP TRIGGER autoincrementtabencabezadoventa2 ON public.tabencabezadoventa;
       public          postgres    false    224    236                       2620    95236     tabkardex autoincrementtabkardex    TRIGGER     �   CREATE TRIGGER autoincrementtabkardex BEFORE INSERT ON public.tabkardex FOR EACH ROW EXECUTE FUNCTION public.consecutivotabkardex();
 9   DROP TRIGGER autoincrementtabkardex ON public.tabkardex;
       public          postgres    false    226    232            	           2620    95235    tabmarca autoincrementtabmarca    TRIGGER     �   CREATE TRIGGER autoincrementtabmarca BEFORE INSERT ON public.tabmarca FOR EACH ROW EXECUTE FUNCTION public.consecutivotabmarca();
 7   DROP TRIGGER autoincrementtabmarca ON public.tabmarca;
       public          postgres    false    221    231            �           2620    95232 "   tabpermiso autoincrementtabpermiso    TRIGGER     �   CREATE TRIGGER autoincrementtabpermiso BEFORE INSERT ON public.tabpermiso FOR EACH ROW EXECUTE FUNCTION public.consecutivotabpermiso();
 ;   DROP TRIGGER autoincrementtabpermiso ON public.tabpermiso;
       public          postgres    false    228    216                       2620    95237 2   tabrecibomercancia autoincrementtabrecibomercancia    TRIGGER     �   CREATE TRIGGER autoincrementtabrecibomercancia BEFORE INSERT ON public.tabrecibomercancia FOR EACH ROW EXECUTE FUNCTION public.consecutivotabrecibomercancia();
 K   DROP TRIGGER autoincrementtabrecibomercancia ON public.tabrecibomercancia;
       public          postgres    false    233    223                        2620    95242 *   tabregborrados autoincrementtabregborrados    TRIGGER     �   CREATE TRIGGER autoincrementtabregborrados BEFORE INSERT ON public.tabregborrados FOR EACH ROW EXECUTE FUNCTION public.consecutivotabregborrados();
 C   DROP TRIGGER autoincrementtabregborrados ON public.tabregborrados;
       public          postgres    false    227    238            �           2620    95233 0   tabusuariopermiso autoincrementtabusuariopermiso    TRIGGER     �   CREATE TRIGGER autoincrementtabusuariopermiso BEFORE INSERT ON public.tabusuariopermiso FOR EACH ROW EXECUTE FUNCTION public.consecutivotabusuariopermiso();
 I   DROP TRIGGER autoincrementtabusuariopermiso ON public.tabusuariopermiso;
       public          postgres    false    217    229                       2620    95298 -   tabrecibomercancia insertentradakardexentrada    TRIGGER     �   CREATE TRIGGER insertentradakardexentrada AFTER INSERT ON public.tabrecibomercancia FOR EACH ROW EXECUTE FUNCTION public.insertkardexentrada();
 F   DROP TRIGGER insertentradakardexentrada ON public.tabrecibomercancia;
       public          postgres    false    223    274                       2620    95300 (   tabdetalleventa insertsalidakardexsalida    TRIGGER     �   CREATE TRIGGER insertsalidakardexsalida AFTER INSERT ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.insertkardexsalida();
 A   DROP TRIGGER insertsalidakardexsalida ON public.tabdetalleventa;
       public          postgres    false    275    225                       2620    95286 8   tabrecibomercancia triggeractualizarstockvalunitentradas    TRIGGER     �   CREATE TRIGGER triggeractualizarstockvalunitentradas AFTER INSERT ON public.tabrecibomercancia FOR EACH ROW EXECUTE FUNCTION public.actualizarstockvalunitentradas();
 Q   DROP TRIGGER triggeractualizarstockvalunitentradas ON public.tabrecibomercancia;
       public          postgres    false    253    223                       2620    95288 4   tabdetalleventa triggeractualizarstockvalunitsalidas    TRIGGER     �   CREATE TRIGGER triggeractualizarstockvalunitsalidas AFTER INSERT ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.actualizarstockvalunitsalidas();
 M   DROP TRIGGER triggeractualizarstockvalunitsalidas ON public.tabdetalleventa;
       public          postgres    false    266    225                       2620    95275    tabarticulo triggertabarticulo    TRIGGER     �   CREATE TRIGGER triggertabarticulo BEFORE INSERT OR UPDATE ON public.tabarticulo FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 7   DROP TRIGGER triggertabarticulo ON public.tabarticulo;
       public          postgres    false    252    222                       2620    95271     tabcategoria triggertabcategoria    TRIGGER     �   CREATE TRIGGER triggertabcategoria BEFORE INSERT OR UPDATE ON public.tabcategoria FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 9   DROP TRIGGER triggertabcategoria ON public.tabcategoria;
       public          postgres    false    220    252                        2620    95267    tabcliente triggertabcliente    TRIGGER     �   CREATE TRIGGER triggertabcliente BEFORE INSERT OR UPDATE ON public.tabcliente FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 5   DROP TRIGGER triggertabcliente ON public.tabcliente;
       public          postgres    false    218    252                       2620    95283 &   tabdetalleventa triggertabdetalleventa    TRIGGER     �   CREATE TRIGGER triggertabdetalleventa BEFORE INSERT OR UPDATE ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 ?   DROP TRIGGER triggertabdetalleventa ON public.tabdetalleventa;
       public          postgres    false    252    225                       2620    95281 ,   tabencabezadoventa triggertabencabezadoventa    TRIGGER     �   CREATE TRIGGER triggertabencabezadoventa BEFORE INSERT OR UPDATE ON public.tabencabezadoventa FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 E   DROP TRIGGER triggertabencabezadoventa ON public.tabencabezadoventa;
       public          postgres    false    224    252                       2620    95277    tabkardex triggertabkardex    TRIGGER     �   CREATE TRIGGER triggertabkardex BEFORE INSERT OR UPDATE ON public.tabkardex FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 3   DROP TRIGGER triggertabkardex ON public.tabkardex;
       public          postgres    false    252    226            
           2620    95273    tabmarca triggertabmarca    TRIGGER     �   CREATE TRIGGER triggertabmarca BEFORE INSERT OR UPDATE ON public.tabmarca FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 1   DROP TRIGGER triggertabmarca ON public.tabmarca;
       public          postgres    false    252    221            �           2620    95263    tabpermiso triggertabpermiso    TRIGGER     �   CREATE TRIGGER triggertabpermiso BEFORE INSERT OR UPDATE ON public.tabpermiso FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 5   DROP TRIGGER triggertabpermiso ON public.tabpermiso;
       public          postgres    false    216    252                       2620    95269     tabproveedor triggertabproveedor    TRIGGER     �   CREATE TRIGGER triggertabproveedor BEFORE INSERT OR UPDATE ON public.tabproveedor FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 9   DROP TRIGGER triggertabproveedor ON public.tabproveedor;
       public          postgres    false    219    252                       2620    95279 ,   tabrecibomercancia triggertabrecibomercancia    TRIGGER     �   CREATE TRIGGER triggertabrecibomercancia BEFORE INSERT OR UPDATE ON public.tabrecibomercancia FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 E   DROP TRIGGER triggertabrecibomercancia ON public.tabrecibomercancia;
       public          postgres    false    252    223                       2620    95276 !   tabarticulo triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabarticulo FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 :   DROP TRIGGER triggertabregborrados ON public.tabarticulo;
       public          postgres    false    252    222                       2620    95272 "   tabcategoria triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabcategoria FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 ;   DROP TRIGGER triggertabregborrados ON public.tabcategoria;
       public          postgres    false    252    220                       2620    95268     tabcliente triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabcliente FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 9   DROP TRIGGER triggertabregborrados ON public.tabcliente;
       public          postgres    false    218    252                       2620    95284 %   tabdetalleventa triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 >   DROP TRIGGER triggertabregborrados ON public.tabdetalleventa;
       public          postgres    false    252    225                       2620    95282 (   tabencabezadoventa triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabencabezadoventa FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 A   DROP TRIGGER triggertabregborrados ON public.tabencabezadoventa;
       public          postgres    false    224    252                       2620    95278    tabkardex triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabkardex FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 8   DROP TRIGGER triggertabregborrados ON public.tabkardex;
       public          postgres    false    226    252                       2620    95274    tabmarca triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabmarca FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 7   DROP TRIGGER triggertabregborrados ON public.tabmarca;
       public          postgres    false    252    221            �           2620    95264     tabpermiso triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabpermiso FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 9   DROP TRIGGER triggertabregborrados ON public.tabpermiso;
       public          postgres    false    252    216                       2620    95270 "   tabproveedor triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabproveedor FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 ;   DROP TRIGGER triggertabregborrados ON public.tabproveedor;
       public          postgres    false    219    252                       2620    95280 (   tabrecibomercancia triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabrecibomercancia FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 A   DROP TRIGGER triggertabregborrados ON public.tabrecibomercancia;
       public          postgres    false    223    252            �           2620    95262     tabusuario triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabusuario FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 9   DROP TRIGGER triggertabregborrados ON public.tabusuario;
       public          postgres    false    215    252            �           2620    95266 '   tabusuariopermiso triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabusuariopermiso FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 @   DROP TRIGGER triggertabregborrados ON public.tabusuariopermiso;
       public          postgres    false    252    217            �           2620    95261    tabusuario triggertabusuario    TRIGGER     �   CREATE TRIGGER triggertabusuario BEFORE INSERT OR UPDATE ON public.tabusuario FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 5   DROP TRIGGER triggertabusuario ON public.tabusuario;
       public          postgres    false    215    252            �           2620    95265 *   tabusuariopermiso triggertabusuariopermiso    TRIGGER     �   CREATE TRIGGER triggertabusuariopermiso BEFORE INSERT OR UPDATE ON public.tabusuariopermiso FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 C   DROP TRIGGER triggertabusuariopermiso ON public.tabusuariopermiso;
       public          postgres    false    252    217                       2620    95258    tabcliente uuidcliente    TRIGGER     u   CREATE TRIGGER uuidcliente BEFORE INSERT ON public.tabcliente FOR EACH ROW EXECUTE FUNCTION public.uuidtabcliente();
 /   DROP TRIGGER uuidcliente ON public.tabcliente;
       public          postgres    false    218    250                       2620    95259    tabproveedor uuidproveedor    TRIGGER     {   CREATE TRIGGER uuidproveedor BEFORE INSERT ON public.tabproveedor FOR EACH ROW EXECUTE FUNCTION public.uuidtabproveedor();
 3   DROP TRIGGER uuidproveedor ON public.tabproveedor;
       public          postgres    false    251    219            �           2620    95257    tabusuario uuidusuario    TRIGGER     u   CREATE TRIGGER uuidusuario BEFORE INSERT ON public.tabusuario FOR EACH ROW EXECUTE FUNCTION public.uuidtabusuario();
 /   DROP TRIGGER uuidusuario ON public.tabusuario;
       public          postgres    false    249    215            �           2606    95134    tabrecibomercancia fkarticulo    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabrecibomercancia
    ADD CONSTRAINT fkarticulo FOREIGN KEY (eanart) REFERENCES public.tabarticulo(eanart);
 G   ALTER TABLE ONLY public.tabrecibomercancia DROP CONSTRAINT fkarticulo;
       public          postgres    false    222    223    3289            �           2606    95180    tabdetalleventa fkarticulo    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabdetalleventa
    ADD CONSTRAINT fkarticulo FOREIGN KEY (eanart) REFERENCES public.tabarticulo(eanart);
 D   ALTER TABLE ONLY public.tabdetalleventa DROP CONSTRAINT fkarticulo;
       public          postgres    false    222    3289    225            �           2606    95198    tabkardex fkarticulo    FK CONSTRAINT     |   ALTER TABLE ONLY public.tabkardex
    ADD CONSTRAINT fkarticulo FOREIGN KEY (eanart) REFERENCES public.tabarticulo(eanart);
 >   ALTER TABLE ONLY public.tabkardex DROP CONSTRAINT fkarticulo;
       public          postgres    false    226    222    3289            �           2606    95122    tabarticulo fkcategoria    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabarticulo
    ADD CONSTRAINT fkcategoria FOREIGN KEY (conseccateg) REFERENCES public.tabcategoria(conseccateg);
 A   ALTER TABLE ONLY public.tabarticulo DROP CONSTRAINT fkcategoria;
       public          postgres    false    222    220    3285            �           2606    95161    tabencabezadoventa fkcliente    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabencabezadoventa
    ADD CONSTRAINT fkcliente FOREIGN KEY (idcli) REFERENCES public.tabcliente(idcli);
 F   ALTER TABLE ONLY public.tabencabezadoventa DROP CONSTRAINT fkcliente;
       public          postgres    false    224    3277    218            �           2606    95185 "   tabdetalleventa fkconseccotizacion    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabdetalleventa
    ADD CONSTRAINT fkconseccotizacion FOREIGN KEY (conseccotizacion) REFERENCES public.tabencabezadoventa(conseccotizacion);
 L   ALTER TABLE ONLY public.tabdetalleventa DROP CONSTRAINT fkconseccotizacion;
       public          postgres    false    224    225    3293            �           2606    95175    tabdetalleventa fkconsecfactura    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabdetalleventa
    ADD CONSTRAINT fkconsecfactura FOREIGN KEY (consecfactura) REFERENCES public.tabencabezadoventa(consecfactura);
 I   ALTER TABLE ONLY public.tabdetalleventa DROP CONSTRAINT fkconsecfactura;
       public          postgres    false    224    225    3295            �           2606    95208    tabkardex fkdetalleventa    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabkardex
    ADD CONSTRAINT fkdetalleventa FOREIGN KEY (consecdetventa) REFERENCES public.tabdetalleventa(consecdetventa);
 B   ALTER TABLE ONLY public.tabkardex DROP CONSTRAINT fkdetalleventa;
       public          postgres    false    3299    226    225            �           2606    95304    tabdetalleventa fkidencventa    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabdetalleventa
    ADD CONSTRAINT fkidencventa FOREIGN KEY (idencventa) REFERENCES public.tabencabezadoventa(idencventa) NOT VALID;
 F   ALTER TABLE ONLY public.tabdetalleventa DROP CONSTRAINT fkidencventa;
       public          postgres    false    225    224    3297            �           2606    95117    tabarticulo fkmarca    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabarticulo
    ADD CONSTRAINT fkmarca FOREIGN KEY (consecmarca) REFERENCES public.tabmarca(consecmarca);
 =   ALTER TABLE ONLY public.tabarticulo DROP CONSTRAINT fkmarca;
       public          postgres    false    221    3287    222            �           2606    95144    tabrecibomercancia fkmarca    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabrecibomercancia
    ADD CONSTRAINT fkmarca FOREIGN KEY (consecmarca) REFERENCES public.tabmarca(consecmarca);
 D   ALTER TABLE ONLY public.tabrecibomercancia DROP CONSTRAINT fkmarca;
       public          postgres    false    223    3287    221            �           2606    95070    tabusuariopermiso fkpermiso    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabusuariopermiso
    ADD CONSTRAINT fkpermiso FOREIGN KEY (consecpermiso) REFERENCES public.tabpermiso(consecpermiso);
 E   ALTER TABLE ONLY public.tabusuariopermiso DROP CONSTRAINT fkpermiso;
       public          postgres    false    216    217    3273            �           2606    95139    tabrecibomercancia fkproveedor    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabrecibomercancia
    ADD CONSTRAINT fkproveedor FOREIGN KEY (idprov) REFERENCES public.tabproveedor(idprov);
 H   ALTER TABLE ONLY public.tabrecibomercancia DROP CONSTRAINT fkproveedor;
       public          postgres    false    219    3281    223            �           2606    95203    tabkardex fkrecibomercancia    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabkardex
    ADD CONSTRAINT fkrecibomercancia FOREIGN KEY (consecrecibomcia) REFERENCES public.tabrecibomercancia(consecrecibomcia);
 E   ALTER TABLE ONLY public.tabkardex DROP CONSTRAINT fkrecibomercancia;
       public          postgres    false    223    226    3291            �           2606    95065    tabusuariopermiso fkusuario    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabusuariopermiso
    ADD CONSTRAINT fkusuario FOREIGN KEY (idusuario) REFERENCES public.tabusuario(idusuario);
 E   ALTER TABLE ONLY public.tabusuariopermiso DROP CONSTRAINT fkusuario;
       public          postgres    false    217    215    3269            �   �   x���=�1Fk����l�G3�q�%�F(R (���؋m`W���ɶ���>�$�]��B�n���,Et<չç��)}]ǹ�Q�^���yI@�!����������.�_������@��9��P����c��d��QF��%�}.Բi~����Ĕ2��C�}�3�"c�����c��(����Q�      �   ^   x�3��H-*J��L�+I,�4202�5��52Q04�2��2��371��0�,�/.I/J-��".#Nל�+�K�2���34ҳ47125A����� �s\      �   �   x�mλn�0��Y~
�iH)���:g�-9H�D�����^��(p�8��B�W�%B�4����X4�)'��d����歝��^��G&NB�m���:��b�G��J����2App
H������Ṋ�ǭ���%�
RU�
�s7r͘��SLS�9�(���n�lʹ�>�cg{������V˾��Ҩ��/�0��	DO�      �   �   x��̽�@��ڞ�r���wC0AZD	"�/.("*,���< @i>�l
�㓭E(h4"�#T�&i���G��Rᙠ�uy\��e�Ƃ_���ᶮ(եf�]e�\��J���f�۵x���m�0�/�6      �   ~   x��̹�0К�"X�HIT�<�!H\��쟳r�L̠6�����H.*������2uB@��[�TU�KA�v]�i>.����=�NoVY� e�v��M�[��\�7�/��ݚw�= ��9�      �   �   x���=�0��9�忸N�tF��ECEZ�,/��Oz�+��1A�>[�T����J��0x>����.�r����J���*�����vĩa�1�1��d��]r�t@�l�l���@���F��Rw���L0As�|�0cJ��NV�      �   S   x�3��u��q�4202�5��52Q04�26�25ճ�05�4�,�/.I/J-��".#N�pG�,Z,�,,,,Mе��qqq -��      �   �   x��ͽ
�0�9y��@K��j��� Ԧԟ��4�R�^I��oq΁3�Jr0͹5l��uw�G��&Ȯ,���\��y	ѧe��ڧC6���Y�2.Y)�J�|���T���8����?X?��֍��z�/ ��)D.劋�sJ�w�D:      �   �   x�mιj�@ �z���#4�� )B�ʐ��^6&� ���M�^>�(F9��R����q�-#�����| !g�Ct�}�yݟ�t��r]��yn=sGH
+�ȂcD֞܎m�qp΋W�����g����G'�-7)X-��Q0��Y�T5V�=^������Ԃ�
Kz����C��`���l`"�ߍ��u�79�D�      �   �   x���K�0 ���� �|
v\����R�P�ËY%j�n�L�L������&�@0o��O�����-��M?�k������L��S��Y��e=�@}�����Av=���jlNm�ڏ�K������5B��|���	��Y�/nɸ���^���F!      �   `  x���K��0������|H��t�I�"h���(z��@7���&+~@`�����;�w�_PFH#'G>cLo?��o����9}|����@���8��C�4�������8$��?���z�Ϸ�4�.��ǰ�UV�e����o���w:���JFY��(uǀ.�@���P�qt�@��ip	w�����H�ad:���K!��+N���}إ��.7}p����~�m��م��,����DR�8�H|�׵�h$q������0�l�.����Ec�c���>&��hBd��,�nYi�(u!���a_[��q�!�q��!�A,�;�	%�ެ�A���tF�S0�J˽?y<80C%���a��D��ҊQV�1�J7F�N'� c`�I|̵�Cl��F P�Nd��c�Ǹ�y���,Ee��v7+�[n�0�Mf��$��#����GZɍ B+�
`'>p����X�>�}�WX,����kJ�R�e얺� �s�)Puy:�����8��q\J��;o�I�ad:#�q,���[H:��qإ��H�`y�]��t������v����,7�Xe����P~��~ ������>�J3���@�J�      �   �   x���;N�@��z|
.0����+U'H3�2Ip��ǩi���ﾞJ�94�]�W�I{@W��l�@�8k;����^��s��mj���/�Ʋ�p]��n��Tb+��-��,/$Ό֋D���=��mp��R�L�'���jG����^�C���H.2E�e�O�w���s�ӼC�Ɉ#���4�� �J�      �   o   x�mλ�@��x�
7�j���Q�+ �A@����&�� a�1��jڠ����	�*"���ǹ쿃�｢7lQU�&i&����v���[�?���N1����8s)��{2�     