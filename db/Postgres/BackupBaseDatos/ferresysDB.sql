PGDMP                     	    {         
   ferresysDB    15.4    15.4 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    62588 
   ferresysDB    DATABASE     �   CREATE DATABASE "ferresysDB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Colombia.1252';
    DROP DATABASE "ferresysDB";
                postgres    false                        3079    62794 	   uuid-ossp 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
    DROP EXTENSION "uuid-ossp";
                   false            �           0    0    EXTENSION "uuid-ossp"    COMMENT     W   COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
                        false    2            
           1255    62840    actualizarestado()    FUNCTION     �   CREATE FUNCTION public.actualizarestado() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.estado = FALSE THEN
        NEW.estado := FALSE;
    END IF;
	
RETURN NEW;
END;
$$;
 )   DROP FUNCTION public.actualizarestado();
       public          postgres    false            �            1255    62836     actualizarstockvalunitentradas()    FUNCTION     �  CREATE FUNCTION public.actualizarstockvalunitentradas() RETURNS trigger
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
       public          postgres    false            	           1255    62838    actualizarstockvalunitsalidas()    FUNCTION     �  CREATE FUNCTION public.actualizarstockvalunitsalidas() RETURNS trigger
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
       public          postgres    false                       1255    62851 2   asignarpermisousuario(character varying, smallint)    FUNCTION     �  CREATE FUNCTION public.asignarpermisousuario(zidusuario character varying, zconsecpermiso smallint) RETURNS void
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
       public          postgres    false            �            1255    62774    consecutivotabcategoria()    FUNCTION     �   CREATE FUNCTION public.consecutivotabcategoria() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecCateg := (SELECT COALESCE(MAX(consecCateg), 0) + 1 FROM tabCategoria);
    RETURN NEW;
END;
$$;
 0   DROP FUNCTION public.consecutivotabcategoria();
       public          postgres    false            �            1255    62781    consecutivotabdetalleventa()    FUNCTION     �   CREATE FUNCTION public.consecutivotabdetalleventa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecDetVenta := (SELECT COALESCE(MAX(consecDetVenta), 0) + 1 FROM tabDetalleVenta);
    RETURN NEW;
END;
$$;
 3   DROP FUNCTION public.consecutivotabdetalleventa();
       public          postgres    false            �            1255    62778    consecutivotabencabezadoventa()    FUNCTION     �   CREATE FUNCTION public.consecutivotabencabezadoventa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.idEncVenta := (SELECT COALESCE(MAX(idEncVenta), 0) + 1 FROM tabEncabezadoVenta);
    RETURN NEW;
END;
$$;
 6   DROP FUNCTION public.consecutivotabencabezadoventa();
       public          postgres    false            �            1255    62779     consecutivotabencabezadoventa1()    FUNCTION       CREATE FUNCTION public.consecutivotabencabezadoventa1() RETURNS trigger
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
       public          postgres    false            �            1255    62780     consecutivotabencabezadoventa2()    FUNCTION       CREATE FUNCTION public.consecutivotabencabezadoventa2() RETURNS trigger
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
       public          postgres    false            �            1255    62776    consecutivotabkardex()    FUNCTION     �   CREATE FUNCTION public.consecutivotabkardex() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecKardex := (SELECT COALESCE(MAX(consecKardex), 0) + 1 FROM tabKardex);
    RETURN NEW;
END;
$$;
 -   DROP FUNCTION public.consecutivotabkardex();
       public          postgres    false            �            1255    62775    consecutivotabmarca()    FUNCTION     �   CREATE FUNCTION public.consecutivotabmarca() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecMarca := (SELECT COALESCE(MAX(consecMarca), 0) + 1 FROM tabMarca);
    RETURN NEW;
END;
$$;
 ,   DROP FUNCTION public.consecutivotabmarca();
       public          postgres    false            �            1255    62772    consecutivotabpermiso()    FUNCTION     �   CREATE FUNCTION public.consecutivotabpermiso() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecPermiso := (SELECT COALESCE(MAX(consecPermiso), 0) + 1 FROM tabPermiso);
    RETURN NEW;
END;
$$;
 .   DROP FUNCTION public.consecutivotabpermiso();
       public          postgres    false            �            1255    62777    consecutivotabrecibomercancia()    FUNCTION     �   CREATE FUNCTION public.consecutivotabrecibomercancia() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecReciboMcia := (SELECT COALESCE(MAX(consecReciboMcia), 0) + 1 FROM tabReciboMercancia);
    RETURN NEW;
END;
$$;
 6   DROP FUNCTION public.consecutivotabrecibomercancia();
       public          postgres    false            �            1255    62782    consecutivotabregborrados()    FUNCTION     �   CREATE FUNCTION public.consecutivotabregborrados() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecRegBor := (SELECT COALESCE(MAX(consecRegBor), 0) + 1 FROM tabRegBorrados);
    RETURN NEW;
END;
$$;
 2   DROP FUNCTION public.consecutivotabregborrados();
       public          postgres    false            �            1255    62773    consecutivotabusuariopermiso()    FUNCTION     �   CREATE FUNCTION public.consecutivotabusuariopermiso() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.consecUsuarioPermiso := (SELECT COALESCE(MAX(consecUsuarioPermiso), 0) + 1 FROM tabUsuarioPermiso);
    RETURN NEW;
END;
$$;
 5   DROP FUNCTION public.consecutivotabusuariopermiso();
       public          postgres    false                       1255    62856 �   insertarticulo(character varying, character varying, smallint, smallint, text, numeric, numeric, integer, integer, integer, date)    FUNCTION     I  CREATE FUNCTION public.insertarticulo(zeanart character varying, znomart character varying, zconsecmarca smallint, zconseccateg smallint, zdescart text, zporcentaje numeric, ziva numeric, zstockmin integer, zstockmax integer, zvalreorden integer, zfecvence date) RETURNS void
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
       public          postgres    false                       1255    62855 "   insertcategoria(character varying)    FUNCTION     �  CREATE FUNCTION public.insertcategoria(znomcateg character varying) RETURNS void
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
       public          postgres    false                       1255    62852 �   insertcliente(character varying, boolean, character varying, character varying, character varying, character varying, character varying, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.insertcliente(zidcli character varying, ztipocli boolean, znomcli character varying, zapecli character varying, znomreplegal character varying, znomempresa character varying, ztelcli character varying, zemailcli character varying, zdircli character varying) RETURNS void
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
       public          postgres    false                       1255    62863 7   insertdetalleventa(character varying, integer, numeric)    FUNCTION     N  CREATE FUNCTION public.insertdetalleventa(zeanart character varying, zcantart integer, zdescuento numeric) RETURNS bigint
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
       public          postgres    false                       1255    62862 =   insertencventa(boolean, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.insertencventa(ztipofactura boolean, zidcli character varying, zciudad character varying, OUT zconsecfactura bigint, OUT zconseccotizacion bigint) RETURNS record
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
       public          postgres    false                       1255    62857    insertkardexentrada()    FUNCTION     ]  CREATE FUNCTION public.insertkardexentrada() RETURNS trigger
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
       public          postgres    false                       1255    62859    insertkardexsalida()    FUNCTION     ]  CREATE FUNCTION public.insertkardexsalida() RETURNS trigger
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
       public          postgres    false                       1255    62854    insertmarca(character varying)    FUNCTION     f  CREATE FUNCTION public.insertmarca(znommarca character varying) RETURNS void
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
       public          postgres    false                       1255    62850 3   insertpermiso(character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.insertpermiso(znompermiso character varying, zdescpermiso character varying) RETURNS void
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
       public          postgres    false                       1255    62853 n   insertproveedor(character varying, character varying, character varying, character varying, character varying)    FUNCTION     4  CREATE FUNCTION public.insertproveedor(zidprov character varying, znomprov character varying, ztelprov character varying, zemailprov character varying, zdirprov character varying) RETURNS void
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
       public          postgres    false                       1255    62861 g   insertrecibomercancia(character varying, integer, numeric, character varying, smallint, smallint, text)    FUNCTION     �  CREATE FUNCTION public.insertrecibomercancia(zeanart character varying, zcantart integer, zvalcompra numeric, zidprov character varying, zconsecmarca smallint, zconseccateg smallint, zobservacion text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    zMarca tabMarca.consecMarca%type;
    zValTotal tabReciboMercancia.valTotal%type;

BEGIN

IF zCantArt <= 0 THEN
    RAISE EXCEPTION 'La cantidad debe ser un número positivo';
END IF;

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
       public          postgres    false                       1255    62849    insertusuario(character varying, character varying, character varying, character varying, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.insertusuario(zidusuario character varying, znomusuario character varying, zapeusuario character varying, zemailusuario character varying, zusuario character varying, zpassword character varying) RETURNS void
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
       public          postgres    false            �            1255    62811    movimientosusuario()    FUNCTION       CREATE FUNCTION public.movimientosusuario() RETURNS trigger
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
       public          postgres    false            �            1255    62806    uuidtabcliente()    FUNCTION     �   CREATE FUNCTION public.uuidtabcliente() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.codCli := uuid_generate_v4();
    RETURN NEW;
END;
$$;
 '   DROP FUNCTION public.uuidtabcliente();
       public          postgres    false            �            1255    62807    uuidtabproveedor()    FUNCTION     �   CREATE FUNCTION public.uuidtabproveedor() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.codProv := uuid_generate_v4();
    RETURN NEW;
END;
$$;
 )   DROP FUNCTION public.uuidtabproveedor();
       public          postgres    false            �            1255    62805    uuidtabusuario()    FUNCTION     �   CREATE FUNCTION public.uuidtabusuario() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.codUsuario := uuid_generate_v4();
    RETURN NEW;
END;
$$;
 '   DROP FUNCTION public.uuidtabusuario();
       public          postgres    false                       1255    62844    validacionentrada()    FUNCTION     �  CREATE FUNCTION public.validacionentrada() RETURNS trigger
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
       public          postgres    false                       1255    62864 <   validacionloginusuario(character varying, character varying)    FUNCTION       CREATE FUNCTION public.validacionloginusuario(zidusuario character varying, zpassword character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$

DECLARE
    zUsuarioValido BOOLEAN;

BEGIN
    SELECT TRUE
    INTO zUsuarioValido
    FROM tabUsuario
    WHERE idUsuario = zIdUsuario AND password = zPassword;

    IF zUsuarioValido THEN
        RAISE NOTICE 'Inicio de sesión exitoso';
        RETURN TRUE;
		
    ELSE
        RAISE NOTICE 'Credenciales de inicio de sesión incorrectas';
        RETURN FALSE;
    END IF;
END;
$$;
 h   DROP FUNCTION public.validacionloginusuario(zidusuario character varying, zpassword character varying);
       public          postgres    false                       1255    62847    validacionsalida()    FUNCTION     K  CREATE FUNCTION public.validacionsalida() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    zValStock tabArticulo.valStock%type;
    zStockMin tabArticulo.stockMin%type;
    zStockMax tabArticulo.stockMax%type;
    zVar NUMERIC;

BEGIN
    
    SELECT valStock, stockMin, stockMax INTO zValStock, zStockMin, zStockMax FROM tabArticulo WHERE eanArt = NEW.eanArt;
    zVar := NEW.cantArt + zValStock;

        --Estas son las restricciones
        CASE
            -- Verificar que el valor ingresado corresponda a una cantidad contable positiva
            WHEN NEW.cantArt <= 0 THEN
                RAISE EXCEPTION 'Debe ingresar una cantidad';

            -- La salida no puede ser menor que el stock mínimo
            WHEN zVar > 0 AND zVar < zStockMin THEN
                RAISE EXCEPTION 'La cantidad de salida no puede ser menor que el stock mínimo';

            -- No puede sacar la misma cantidad de stock actual o mayor ya que viola la restricción del stock mínimo
            -- Verifica que el valor ingresado no supere al atributo StockMax (Stock Máximo)
            WHEN NEW.cantArt >= zValStock OR NEW.cantArt > zStockMax THEN
                RAISE EXCEPTION 'La cantidad supera las existencias en stock / stock máximo';
            
            -- Verificar el valor de stock no esté en mínimo o sea menor/igual que cero
            WHEN zValStock IS NULL OR zValStock <= 0 THEN
                RAISE EXCEPTION 'No se puede realizar la operación, stock negativo o en cero';
            ELSE

        END CASE;

        -- Este es el caso valido
        CASE 
            -- Que sea la salida sea mayor al stock mínimo
            WHEN zVar <= 0 THEN
                RAISE NOTICE 'Exitoso mayor del stock mínimo';
            ELSE

        END CASE;

    -- Si la validación es exitosa, permite la inserción
RETURN NEW;
END;
$$;
 )   DROP FUNCTION public.validacionsalida();
       public          postgres    false            �            1259    62656    tabarticulo    TABLE     o  CREATE TABLE public.tabarticulo (
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
       public         heap    postgres    false            �            1259    62642    tabcategoria    TABLE       CREATE TABLE public.tabcategoria (
    conseccateg smallint NOT NULL,
    nomcateg character varying NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
     DROP TABLE public.tabcategoria;
       public         heap    postgres    false            �            1259    62622 
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
       public         heap    postgres    false            �            1259    62713    tabdetalleventa    TABLE     O  CREATE TABLE public.tabdetalleventa (
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
       public         heap    postgres    false            �            1259    62696    tabencabezadoventa    TABLE     �  CREATE TABLE public.tabencabezadoventa (
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
       public         heap    postgres    false            �            1259    62742 	   tabkardex    TABLE     �  CREATE TABLE public.tabkardex (
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
       public         heap    postgres    false            �            1259    62649    tabmarca    TABLE       CREATE TABLE public.tabmarca (
    consecmarca smallint NOT NULL,
    nommarca character varying NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
    DROP TABLE public.tabmarca;
       public         heap    postgres    false            �            1259    62598 
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
       public         heap    postgres    false            �            1259    62632    tabproveedor    TABLE     �  CREATE TABLE public.tabproveedor (
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
       public         heap    postgres    false            �            1259    62674    tabrecibomercancia    TABLE     �  CREATE TABLE public.tabrecibomercancia (
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
       public         heap    postgres    false            �            1259    62765    tabregborrados    TABLE     �   CREATE TABLE public.tabregborrados (
    consecregbor bigint NOT NULL,
    fecdelete timestamp without time zone,
    userdelete character varying NOT NULL,
    nomtabla character varying NOT NULL
);
 "   DROP TABLE public.tabregborrados;
       public         heap    postgres    false            �            1259    62589 
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
       public         heap    postgres    false            �            1259    62605    tabusuariopermiso    TABLE     ?  CREATE TABLE public.tabusuariopermiso (
    consecusuariopermiso smallint NOT NULL,
    idusuario character varying NOT NULL,
    consecpermiso smallint NOT NULL,
    fecinsert timestamp without time zone,
    userinsert character varying,
    fecupdate timestamp without time zone,
    userupdate character varying
);
 %   DROP TABLE public.tabusuariopermiso;
       public         heap    postgres    false            �          0    62656    tabarticulo 
   TABLE DATA           �   COPY public.tabarticulo (eanart, nomart, consecmarca, conseccateg, descart, valunit, porcentaje, iva, valstock, stockmin, stockmax, valreorden, fecvence, estado, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    222   �       �          0    62642    tabcategoria 
   TABLE DATA           k   COPY public.tabcategoria (conseccateg, nomcateg, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    220   �!      �          0    62622 
   tabcliente 
   TABLE DATA           �   COPY public.tabcliente (codcli, idcli, tipocli, nomcli, apecli, nomreplegal, nomempresa, telcli, emailcli, dircli, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    218   E"      �          0    62713    tabdetalleventa 
   TABLE DATA           �   COPY public.tabdetalleventa (consecdetventa, idencventa, consecfactura, conseccotizacion, eanart, cantart, valunit, subtotal, iva, descuento, totalpagar, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    225   T#      �          0    62696    tabencabezadoventa 
   TABLE DATA           �   COPY public.tabencabezadoventa (idencventa, consecfactura, conseccotizacion, tipofactura, estadofactura, idcli, ciudad, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    224   �$      �          0    62742 	   tabkardex 
   TABLE DATA           �   COPY public.tabkardex (conseckardex, consecrecibomcia, consecdetventa, tipomov, eanart, cantart, valprom, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    226   %      �          0    62649    tabmarca 
   TABLE DATA           g   COPY public.tabmarca (consecmarca, nommarca, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    221   b&      �          0    62598 
   tabpermiso 
   TABLE DATA           z   COPY public.tabpermiso (consecpermiso, nompermiso, descpermiso, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    216   �&      �          0    62632    tabproveedor 
   TABLE DATA           �   COPY public.tabproveedor (codprov, idprov, nomprov, telprov, emailprov, dirprov, estado, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    219   '      �          0    62674    tabrecibomercancia 
   TABLE DATA           �   COPY public.tabrecibomercancia (consecrecibomcia, eanart, cantart, valcompra, valtotal, idprov, consecmarca, observacion, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    223   �(      �          0    62765    tabregborrados 
   TABLE DATA           W   COPY public.tabregborrados (consecregbor, fecdelete, userdelete, nomtabla) FROM stdin;
    public          postgres    false    227   W)      �          0    62589 
   tabusuario 
   TABLE DATA           �   COPY public.tabusuario (codusuario, idusuario, nomusuario, apeusuario, emailusuario, usuario, password, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    215   t)      �          0    62605    tabusuariopermiso 
   TABLE DATA           �   COPY public.tabusuariopermiso (consecusuariopermiso, idusuario, consecpermiso, fecinsert, userinsert, fecupdate, userupdate) FROM stdin;
    public          postgres    false    217   Z*      �           2606    62663    tabarticulo tabarticulo_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.tabarticulo
    ADD CONSTRAINT tabarticulo_pkey PRIMARY KEY (eanart);
 F   ALTER TABLE ONLY public.tabarticulo DROP CONSTRAINT tabarticulo_pkey;
       public            postgres    false    222            �           2606    62648    tabcategoria tabcategoria_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.tabcategoria
    ADD CONSTRAINT tabcategoria_pkey PRIMARY KEY (conseccateg);
 H   ALTER TABLE ONLY public.tabcategoria DROP CONSTRAINT tabcategoria_pkey;
       public            postgres    false    220            �           2606    62631    tabcliente tabcliente_idcli_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.tabcliente
    ADD CONSTRAINT tabcliente_idcli_key UNIQUE (idcli);
 I   ALTER TABLE ONLY public.tabcliente DROP CONSTRAINT tabcliente_idcli_key;
       public            postgres    false    218            �           2606    62629    tabcliente tabcliente_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.tabcliente
    ADD CONSTRAINT tabcliente_pkey PRIMARY KEY (codcli);
 D   ALTER TABLE ONLY public.tabcliente DROP CONSTRAINT tabcliente_pkey;
       public            postgres    false    218            �           2606    62721 $   tabdetalleventa tabdetalleventa_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.tabdetalleventa
    ADD CONSTRAINT tabdetalleventa_pkey PRIMARY KEY (consecdetventa);
 N   ALTER TABLE ONLY public.tabdetalleventa DROP CONSTRAINT tabdetalleventa_pkey;
       public            postgres    false    225            �           2606    62707 :   tabencabezadoventa tabencabezadoventa_conseccotizacion_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.tabencabezadoventa
    ADD CONSTRAINT tabencabezadoventa_conseccotizacion_key UNIQUE (conseccotizacion);
 d   ALTER TABLE ONLY public.tabencabezadoventa DROP CONSTRAINT tabencabezadoventa_conseccotizacion_key;
       public            postgres    false    224            �           2606    62705 7   tabencabezadoventa tabencabezadoventa_consecfactura_key 
   CONSTRAINT     {   ALTER TABLE ONLY public.tabencabezadoventa
    ADD CONSTRAINT tabencabezadoventa_consecfactura_key UNIQUE (consecfactura);
 a   ALTER TABLE ONLY public.tabencabezadoventa DROP CONSTRAINT tabencabezadoventa_consecfactura_key;
       public            postgres    false    224            �           2606    62703 *   tabencabezadoventa tabencabezadoventa_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.tabencabezadoventa
    ADD CONSTRAINT tabencabezadoventa_pkey PRIMARY KEY (idencventa);
 T   ALTER TABLE ONLY public.tabencabezadoventa DROP CONSTRAINT tabencabezadoventa_pkey;
       public            postgres    false    224            �           2606    62749    tabkardex tabkardex_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.tabkardex
    ADD CONSTRAINT tabkardex_pkey PRIMARY KEY (conseckardex);
 B   ALTER TABLE ONLY public.tabkardex DROP CONSTRAINT tabkardex_pkey;
       public            postgres    false    226            �           2606    62655    tabmarca tabmarca_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.tabmarca
    ADD CONSTRAINT tabmarca_pkey PRIMARY KEY (consecmarca);
 @   ALTER TABLE ONLY public.tabmarca DROP CONSTRAINT tabmarca_pkey;
       public            postgres    false    221            �           2606    62604    tabpermiso tabpermiso_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.tabpermiso
    ADD CONSTRAINT tabpermiso_pkey PRIMARY KEY (consecpermiso);
 D   ALTER TABLE ONLY public.tabpermiso DROP CONSTRAINT tabpermiso_pkey;
       public            postgres    false    216            �           2606    62641 $   tabproveedor tabproveedor_idprov_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.tabproveedor
    ADD CONSTRAINT tabproveedor_idprov_key UNIQUE (idprov);
 N   ALTER TABLE ONLY public.tabproveedor DROP CONSTRAINT tabproveedor_idprov_key;
       public            postgres    false    219            �           2606    62639    tabproveedor tabproveedor_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.tabproveedor
    ADD CONSTRAINT tabproveedor_pkey PRIMARY KEY (codprov);
 H   ALTER TABLE ONLY public.tabproveedor DROP CONSTRAINT tabproveedor_pkey;
       public            postgres    false    219            �           2606    62680 *   tabrecibomercancia tabrecibomercancia_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.tabrecibomercancia
    ADD CONSTRAINT tabrecibomercancia_pkey PRIMARY KEY (consecrecibomcia);
 T   ALTER TABLE ONLY public.tabrecibomercancia DROP CONSTRAINT tabrecibomercancia_pkey;
       public            postgres    false    223            �           2606    62771 "   tabregborrados tabregborrados_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.tabregborrados
    ADD CONSTRAINT tabregborrados_pkey PRIMARY KEY (consecregbor);
 L   ALTER TABLE ONLY public.tabregborrados DROP CONSTRAINT tabregborrados_pkey;
       public            postgres    false    227            �           2606    62597 #   tabusuario tabusuario_idusuario_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.tabusuario
    ADD CONSTRAINT tabusuario_idusuario_key UNIQUE (idusuario);
 M   ALTER TABLE ONLY public.tabusuario DROP CONSTRAINT tabusuario_idusuario_key;
       public            postgres    false    215            �           2606    62595    tabusuario tabusuario_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.tabusuario
    ADD CONSTRAINT tabusuario_pkey PRIMARY KEY (codusuario);
 D   ALTER TABLE ONLY public.tabusuario DROP CONSTRAINT tabusuario_pkey;
       public            postgres    false    215            �           2606    62611 (   tabusuariopermiso tabusuariopermiso_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.tabusuariopermiso
    ADD CONSTRAINT tabusuariopermiso_pkey PRIMARY KEY (consecusuariopermiso);
 R   ALTER TABLE ONLY public.tabusuariopermiso DROP CONSTRAINT tabusuariopermiso_pkey;
       public            postgres    false    217            �           1259    62865    indexean    INDEX     B   CREATE INDEX indexean ON public.tabarticulo USING btree (eanart);
    DROP INDEX public.indexean;
       public            postgres    false    222                       2620    62785 &   tabcategoria autoincrementtabcategoria    TRIGGER     �   CREATE TRIGGER autoincrementtabcategoria BEFORE INSERT ON public.tabcategoria FOR EACH ROW EXECUTE FUNCTION public.consecutivotabcategoria();
 ?   DROP TRIGGER autoincrementtabcategoria ON public.tabcategoria;
       public          postgres    false    220    230            !           2620    62792 ,   tabdetalleventa autoincrementtabdetalleventa    TRIGGER     �   CREATE TRIGGER autoincrementtabdetalleventa BEFORE INSERT ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.consecutivotabdetalleventa();
 E   DROP TRIGGER autoincrementtabdetalleventa ON public.tabdetalleventa;
       public          postgres    false    237    225                       2620    62789 2   tabencabezadoventa autoincrementtabencabezadoventa    TRIGGER     �   CREATE TRIGGER autoincrementtabencabezadoventa BEFORE INSERT ON public.tabencabezadoventa FOR EACH ROW EXECUTE FUNCTION public.consecutivotabencabezadoventa();
 K   DROP TRIGGER autoincrementtabencabezadoventa ON public.tabencabezadoventa;
       public          postgres    false    224    234                       2620    62790 3   tabencabezadoventa autoincrementtabencabezadoventa1    TRIGGER     �   CREATE TRIGGER autoincrementtabencabezadoventa1 BEFORE INSERT ON public.tabencabezadoventa FOR EACH ROW EXECUTE FUNCTION public.consecutivotabencabezadoventa1();
 L   DROP TRIGGER autoincrementtabencabezadoventa1 ON public.tabencabezadoventa;
       public          postgres    false    235    224                       2620    62791 3   tabencabezadoventa autoincrementtabencabezadoventa2    TRIGGER     �   CREATE TRIGGER autoincrementtabencabezadoventa2 BEFORE INSERT ON public.tabencabezadoventa FOR EACH ROW EXECUTE FUNCTION public.consecutivotabencabezadoventa2();
 L   DROP TRIGGER autoincrementtabencabezadoventa2 ON public.tabencabezadoventa;
       public          postgres    false    224    236            '           2620    62787     tabkardex autoincrementtabkardex    TRIGGER     �   CREATE TRIGGER autoincrementtabkardex BEFORE INSERT ON public.tabkardex FOR EACH ROW EXECUTE FUNCTION public.consecutivotabkardex();
 9   DROP TRIGGER autoincrementtabkardex ON public.tabkardex;
       public          postgres    false    226    232                       2620    62786    tabmarca autoincrementtabmarca    TRIGGER     �   CREATE TRIGGER autoincrementtabmarca BEFORE INSERT ON public.tabmarca FOR EACH ROW EXECUTE FUNCTION public.consecutivotabmarca();
 7   DROP TRIGGER autoincrementtabmarca ON public.tabmarca;
       public          postgres    false    231    221            �           2620    62783 "   tabpermiso autoincrementtabpermiso    TRIGGER     �   CREATE TRIGGER autoincrementtabpermiso BEFORE INSERT ON public.tabpermiso FOR EACH ROW EXECUTE FUNCTION public.consecutivotabpermiso();
 ;   DROP TRIGGER autoincrementtabpermiso ON public.tabpermiso;
       public          postgres    false    228    216                       2620    62788 2   tabrecibomercancia autoincrementtabrecibomercancia    TRIGGER     �   CREATE TRIGGER autoincrementtabrecibomercancia BEFORE INSERT ON public.tabrecibomercancia FOR EACH ROW EXECUTE FUNCTION public.consecutivotabrecibomercancia();
 K   DROP TRIGGER autoincrementtabrecibomercancia ON public.tabrecibomercancia;
       public          postgres    false    233    223            *           2620    62793 *   tabregborrados autoincrementtabregborrados    TRIGGER     �   CREATE TRIGGER autoincrementtabregborrados BEFORE INSERT ON public.tabregborrados FOR EACH ROW EXECUTE FUNCTION public.consecutivotabregborrados();
 C   DROP TRIGGER autoincrementtabregborrados ON public.tabregborrados;
       public          postgres    false    227    238                       2620    62784 0   tabusuariopermiso autoincrementtabusuariopermiso    TRIGGER     �   CREATE TRIGGER autoincrementtabusuariopermiso BEFORE INSERT ON public.tabusuariopermiso FOR EACH ROW EXECUTE FUNCTION public.consecutivotabusuariopermiso();
 I   DROP TRIGGER autoincrementtabusuariopermiso ON public.tabusuariopermiso;
       public          postgres    false    217    229                       2620    62858 -   tabrecibomercancia insertentradakardexentrada    TRIGGER     �   CREATE TRIGGER insertentradakardexentrada AFTER INSERT ON public.tabrecibomercancia FOR EACH ROW EXECUTE FUNCTION public.insertkardexentrada();
 F   DROP TRIGGER insertentradakardexentrada ON public.tabrecibomercancia;
       public          postgres    false    223    277            "           2620    62860 (   tabdetalleventa insertsalidakardexsalida    TRIGGER     �   CREATE TRIGGER insertsalidakardexsalida AFTER INSERT ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.insertkardexsalida();
 A   DROP TRIGGER insertsalidakardexsalida ON public.tabdetalleventa;
       public          postgres    false    225    278                       2620    62842 .   tabarticulo triggeractualizarestadotabarticulo    TRIGGER     �   CREATE TRIGGER triggeractualizarestadotabarticulo BEFORE UPDATE ON public.tabarticulo FOR EACH ROW EXECUTE FUNCTION public.actualizarestado();
 G   DROP TRIGGER triggeractualizarestadotabarticulo ON public.tabarticulo;
       public          postgres    false    266    222                       2620    62843 <   tabencabezadoventa triggeractualizarestadotabencabezadoventa    TRIGGER     �   CREATE TRIGGER triggeractualizarestadotabencabezadoventa BEFORE UPDATE ON public.tabencabezadoventa FOR EACH ROW EXECUTE FUNCTION public.actualizarestado();
 U   DROP TRIGGER triggeractualizarestadotabencabezadoventa ON public.tabencabezadoventa;
       public          postgres    false    266    224                       2620    62841 0   tabproveedor triggeractualizarestadotabproveedor    TRIGGER     �   CREATE TRIGGER triggeractualizarestadotabproveedor BEFORE UPDATE ON public.tabproveedor FOR EACH ROW EXECUTE FUNCTION public.actualizarestado();
 I   DROP TRIGGER triggeractualizarestadotabproveedor ON public.tabproveedor;
       public          postgres    false    219    266                       2620    62837 8   tabrecibomercancia triggeractualizarstockvalunitentradas    TRIGGER     �   CREATE TRIGGER triggeractualizarstockvalunitentradas AFTER INSERT ON public.tabrecibomercancia FOR EACH ROW EXECUTE FUNCTION public.actualizarstockvalunitentradas();
 Q   DROP TRIGGER triggeractualizarstockvalunitentradas ON public.tabrecibomercancia;
       public          postgres    false    253    223            #           2620    62839 4   tabdetalleventa triggeractualizarstockvalunitsalidas    TRIGGER     �   CREATE TRIGGER triggeractualizarstockvalunitsalidas AFTER INSERT ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.actualizarstockvalunitsalidas();
 M   DROP TRIGGER triggeractualizarstockvalunitsalidas ON public.tabdetalleventa;
       public          postgres    false    225    265                       2620    62826    tabarticulo triggertabarticulo    TRIGGER     �   CREATE TRIGGER triggertabarticulo BEFORE INSERT OR UPDATE ON public.tabarticulo FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 7   DROP TRIGGER triggertabarticulo ON public.tabarticulo;
       public          postgres    false    222    252                       2620    62822     tabcategoria triggertabcategoria    TRIGGER     �   CREATE TRIGGER triggertabcategoria BEFORE INSERT OR UPDATE ON public.tabcategoria FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 9   DROP TRIGGER triggertabcategoria ON public.tabcategoria;
       public          postgres    false    220    252                       2620    62818    tabcliente triggertabcliente    TRIGGER     �   CREATE TRIGGER triggertabcliente BEFORE INSERT OR UPDATE ON public.tabcliente FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 5   DROP TRIGGER triggertabcliente ON public.tabcliente;
       public          postgres    false    218    252            $           2620    62834 &   tabdetalleventa triggertabdetalleventa    TRIGGER     �   CREATE TRIGGER triggertabdetalleventa BEFORE INSERT OR UPDATE ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 ?   DROP TRIGGER triggertabdetalleventa ON public.tabdetalleventa;
       public          postgres    false    252    225                       2620    62832 ,   tabencabezadoventa triggertabencabezadoventa    TRIGGER     �   CREATE TRIGGER triggertabencabezadoventa BEFORE INSERT OR UPDATE ON public.tabencabezadoventa FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 E   DROP TRIGGER triggertabencabezadoventa ON public.tabencabezadoventa;
       public          postgres    false    224    252            (           2620    62828    tabkardex triggertabkardex    TRIGGER     �   CREATE TRIGGER triggertabkardex BEFORE INSERT OR UPDATE ON public.tabkardex FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 3   DROP TRIGGER triggertabkardex ON public.tabkardex;
       public          postgres    false    252    226                       2620    62824    tabmarca triggertabmarca    TRIGGER     �   CREATE TRIGGER triggertabmarca BEFORE INSERT OR UPDATE ON public.tabmarca FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 1   DROP TRIGGER triggertabmarca ON public.tabmarca;
       public          postgres    false    252    221                        2620    62814    tabpermiso triggertabpermiso    TRIGGER     �   CREATE TRIGGER triggertabpermiso BEFORE INSERT OR UPDATE ON public.tabpermiso FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 5   DROP TRIGGER triggertabpermiso ON public.tabpermiso;
       public          postgres    false    216    252            	           2620    62820     tabproveedor triggertabproveedor    TRIGGER     �   CREATE TRIGGER triggertabproveedor BEFORE INSERT OR UPDATE ON public.tabproveedor FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 9   DROP TRIGGER triggertabproveedor ON public.tabproveedor;
       public          postgres    false    219    252                       2620    62830 ,   tabrecibomercancia triggertabrecibomercancia    TRIGGER     �   CREATE TRIGGER triggertabrecibomercancia BEFORE INSERT OR UPDATE ON public.tabrecibomercancia FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 E   DROP TRIGGER triggertabrecibomercancia ON public.tabrecibomercancia;
       public          postgres    false    223    252                       2620    62827 !   tabarticulo triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabarticulo FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 :   DROP TRIGGER triggertabregborrados ON public.tabarticulo;
       public          postgres    false    222    252                       2620    62823 "   tabcategoria triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabcategoria FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 ;   DROP TRIGGER triggertabregborrados ON public.tabcategoria;
       public          postgres    false    252    220                       2620    62819     tabcliente triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabcliente FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 9   DROP TRIGGER triggertabregborrados ON public.tabcliente;
       public          postgres    false    252    218            %           2620    62835 %   tabdetalleventa triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 >   DROP TRIGGER triggertabregborrados ON public.tabdetalleventa;
       public          postgres    false    252    225                        2620    62833 (   tabencabezadoventa triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabencabezadoventa FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 A   DROP TRIGGER triggertabregborrados ON public.tabencabezadoventa;
       public          postgres    false    252    224            )           2620    62829    tabkardex triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabkardex FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 8   DROP TRIGGER triggertabregborrados ON public.tabkardex;
       public          postgres    false    226    252                       2620    62825    tabmarca triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabmarca FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 7   DROP TRIGGER triggertabregborrados ON public.tabmarca;
       public          postgres    false    252    221                       2620    62815     tabpermiso triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabpermiso FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 9   DROP TRIGGER triggertabregborrados ON public.tabpermiso;
       public          postgres    false    252    216            
           2620    62821 "   tabproveedor triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabproveedor FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 ;   DROP TRIGGER triggertabregborrados ON public.tabproveedor;
       public          postgres    false    219    252                       2620    62831 (   tabrecibomercancia triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabrecibomercancia FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 A   DROP TRIGGER triggertabregborrados ON public.tabrecibomercancia;
       public          postgres    false    223    252            �           2620    62813     tabusuario triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabusuario FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 9   DROP TRIGGER triggertabregborrados ON public.tabusuario;
       public          postgres    false    215    252                       2620    62817 '   tabusuariopermiso triggertabregborrados    TRIGGER     �   CREATE TRIGGER triggertabregborrados AFTER DELETE ON public.tabusuariopermiso FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 @   DROP TRIGGER triggertabregborrados ON public.tabusuariopermiso;
       public          postgres    false    217    252            �           2620    62812    tabusuario triggertabusuario    TRIGGER     �   CREATE TRIGGER triggertabusuario BEFORE INSERT OR UPDATE ON public.tabusuario FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 5   DROP TRIGGER triggertabusuario ON public.tabusuario;
       public          postgres    false    215    252                       2620    62816 *   tabusuariopermiso triggertabusuariopermiso    TRIGGER     �   CREATE TRIGGER triggertabusuariopermiso BEFORE INSERT OR UPDATE ON public.tabusuariopermiso FOR EACH ROW EXECUTE FUNCTION public.movimientosusuario();
 C   DROP TRIGGER triggertabusuariopermiso ON public.tabusuariopermiso;
       public          postgres    false    217    252                       2620    62809    tabcliente uuidcliente    TRIGGER     u   CREATE TRIGGER uuidcliente BEFORE INSERT ON public.tabcliente FOR EACH ROW EXECUTE FUNCTION public.uuidtabcliente();
 /   DROP TRIGGER uuidcliente ON public.tabcliente;
       public          postgres    false    250    218                       2620    62810    tabproveedor uuidproveedor    TRIGGER     {   CREATE TRIGGER uuidproveedor BEFORE INSERT ON public.tabproveedor FOR EACH ROW EXECUTE FUNCTION public.uuidtabproveedor();
 3   DROP TRIGGER uuidproveedor ON public.tabproveedor;
       public          postgres    false    251    219            �           2620    62808    tabusuario uuidusuario    TRIGGER     u   CREATE TRIGGER uuidusuario BEFORE INSERT ON public.tabusuario FOR EACH ROW EXECUTE FUNCTION public.uuidtabusuario();
 /   DROP TRIGGER uuidusuario ON public.tabusuario;
       public          postgres    false    215    249                       2620    62845 $   tabrecibomercancia validacionentrada    TRIGGER     �   CREATE TRIGGER validacionentrada BEFORE INSERT ON public.tabrecibomercancia FOR EACH ROW EXECUTE FUNCTION public.validacionentrada();
 =   DROP TRIGGER validacionentrada ON public.tabrecibomercancia;
       public          postgres    false    223    267            &           2620    62848     tabdetalleventa validacionsalida    TRIGGER     �   CREATE TRIGGER validacionsalida BEFORE INSERT ON public.tabdetalleventa FOR EACH ROW EXECUTE FUNCTION public.validacionsalida();
 9   DROP TRIGGER validacionsalida ON public.tabdetalleventa;
       public          postgres    false    282    225            �           2606    62681    tabrecibomercancia fkarticulo    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabrecibomercancia
    ADD CONSTRAINT fkarticulo FOREIGN KEY (eanart) REFERENCES public.tabarticulo(eanart);
 G   ALTER TABLE ONLY public.tabrecibomercancia DROP CONSTRAINT fkarticulo;
       public          postgres    false    222    3294    223            �           2606    62732    tabdetalleventa fkarticulo    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabdetalleventa
    ADD CONSTRAINT fkarticulo FOREIGN KEY (eanart) REFERENCES public.tabarticulo(eanart);
 D   ALTER TABLE ONLY public.tabdetalleventa DROP CONSTRAINT fkarticulo;
       public          postgres    false    3294    222    225            �           2606    62750    tabkardex fkarticulo    FK CONSTRAINT     |   ALTER TABLE ONLY public.tabkardex
    ADD CONSTRAINT fkarticulo FOREIGN KEY (eanart) REFERENCES public.tabarticulo(eanart);
 >   ALTER TABLE ONLY public.tabkardex DROP CONSTRAINT fkarticulo;
       public          postgres    false    222    3294    226            �           2606    62669    tabarticulo fkcategoria    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabarticulo
    ADD CONSTRAINT fkcategoria FOREIGN KEY (conseccateg) REFERENCES public.tabcategoria(conseccateg);
 A   ALTER TABLE ONLY public.tabarticulo DROP CONSTRAINT fkcategoria;
       public          postgres    false    222    220    3289            �           2606    62708    tabencabezadoventa fkcliente    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabencabezadoventa
    ADD CONSTRAINT fkcliente FOREIGN KEY (idcli) REFERENCES public.tabcliente(idcli);
 F   ALTER TABLE ONLY public.tabencabezadoventa DROP CONSTRAINT fkcliente;
       public          postgres    false    224    3281    218            �           2606    62737 "   tabdetalleventa fkconseccotizacion    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabdetalleventa
    ADD CONSTRAINT fkconseccotizacion FOREIGN KEY (conseccotizacion) REFERENCES public.tabencabezadoventa(conseccotizacion);
 L   ALTER TABLE ONLY public.tabdetalleventa DROP CONSTRAINT fkconseccotizacion;
       public          postgres    false    225    3298    224            �           2606    62727    tabdetalleventa fkconsecfactura    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabdetalleventa
    ADD CONSTRAINT fkconsecfactura FOREIGN KEY (consecfactura) REFERENCES public.tabencabezadoventa(consecfactura);
 I   ALTER TABLE ONLY public.tabdetalleventa DROP CONSTRAINT fkconsecfactura;
       public          postgres    false    225    3300    224            �           2606    62760    tabkardex fkdetalleventa    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabkardex
    ADD CONSTRAINT fkdetalleventa FOREIGN KEY (consecdetventa) REFERENCES public.tabdetalleventa(consecdetventa);
 B   ALTER TABLE ONLY public.tabkardex DROP CONSTRAINT fkdetalleventa;
       public          postgres    false    3304    225    226            �           2606    62722    tabdetalleventa fkidencventa    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabdetalleventa
    ADD CONSTRAINT fkidencventa FOREIGN KEY (idencventa) REFERENCES public.tabencabezadoventa(idencventa);
 F   ALTER TABLE ONLY public.tabdetalleventa DROP CONSTRAINT fkidencventa;
       public          postgres    false    224    3302    225            �           2606    62664    tabarticulo fkmarca    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabarticulo
    ADD CONSTRAINT fkmarca FOREIGN KEY (consecmarca) REFERENCES public.tabmarca(consecmarca);
 =   ALTER TABLE ONLY public.tabarticulo DROP CONSTRAINT fkmarca;
       public          postgres    false    221    3291    222            �           2606    62691    tabrecibomercancia fkmarca    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabrecibomercancia
    ADD CONSTRAINT fkmarca FOREIGN KEY (consecmarca) REFERENCES public.tabmarca(consecmarca);
 D   ALTER TABLE ONLY public.tabrecibomercancia DROP CONSTRAINT fkmarca;
       public          postgres    false    221    3291    223            �           2606    62617    tabusuariopermiso fkpermiso    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabusuariopermiso
    ADD CONSTRAINT fkpermiso FOREIGN KEY (consecpermiso) REFERENCES public.tabpermiso(consecpermiso);
 E   ALTER TABLE ONLY public.tabusuariopermiso DROP CONSTRAINT fkpermiso;
       public          postgres    false    216    217    3277            �           2606    62686    tabrecibomercancia fkproveedor    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabrecibomercancia
    ADD CONSTRAINT fkproveedor FOREIGN KEY (idprov) REFERENCES public.tabproveedor(idprov);
 H   ALTER TABLE ONLY public.tabrecibomercancia DROP CONSTRAINT fkproveedor;
       public          postgres    false    219    3285    223            �           2606    62755    tabkardex fkrecibomercancia    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabkardex
    ADD CONSTRAINT fkrecibomercancia FOREIGN KEY (consecrecibomcia) REFERENCES public.tabrecibomercancia(consecrecibomcia);
 E   ALTER TABLE ONLY public.tabkardex DROP CONSTRAINT fkrecibomercancia;
       public          postgres    false    223    226    3296            �           2606    62612    tabusuariopermiso fkusuario    FK CONSTRAINT     �   ALTER TABLE ONLY public.tabusuariopermiso
    ADD CONSTRAINT fkusuario FOREIGN KEY (idusuario) REFERENCES public.tabusuario(idusuario);
 E   ALTER TABLE ONLY public.tabusuariopermiso DROP CONSTRAINT fkusuario;
       public          postgres    false    215    217    3273            �   �   x����j�0���S�b$Yr��;�v��$a��8�c��G�5nG;���,�BB?�C�VԵ> �������c�	J<�K��C?�>��aL�m^(�D�p�[K�E�g�7�`�l�A�)t�����3�e}�����:f#�I�橂o��e­��2���A�TeԢ�Y����阦a��r����:��<�4�Âc�$
��`�����C1Nz���#*��Z�w�����F(y      �   h   x�3�tN,IM�/:�6ѐ����X��@��T��������@�����Ԉ� ��$�(��3��������Ϙ�#��(1735�$�M������������1��=... #s.      �   �   x�]�=n�0�g�:ˠ$R?��݊��H�l(���z�^�nZ/8�=�%E$.m�6<�6p+�!��F�b�Ӹ&�Vv�����?������v}N�n[�7��:߳�������
I�`�ҧ�>Uq�K^R���k�$H�p�R���H;����m�68���*�o�T�xc�q���Ab�5��VF�fY4�p{���Gv����IH��}v���{0������|*	���d$k%*%AzLv������hb      �     x���MN�0�s
.�����C��"� ���i�pm/*YQ��4z�G������x(&o�&��)��#˅���BQͪ �̑s�x�}�}��~����)8WUpv�>�r
."¢��.`;\�]��r��Ex�θQ1��h���s.#M1�U�����(cE���,�u(��p�@�6��n�q���ȶ�:�*`4W'����}��e
��b���2ë�v#?�<�ڎ���N?�V�Ӄf�d.�0��U�ֹ	^u�ekl���j!2ϻ��s,Q5m����۶}�jS      �   w   x�e�1�0@��9E/@d;NC2ҝd� BH-� ܿ0����D��z4<��B��QGFva��F1IH-��D���:�e;��>w9�ѷZ/�탮��e��Krwÿ��1���%�      �   J  x���KN�0�uz
.0�߉s�9�l�%���7]@4U%GU��n�b�t��GBbQ+�!VI!!$�����5�,�P0}~��_�����u�D㵘
B���`8���q�ވ�b0TI& �ɐ�bz�1b��4�r-䥌��ۗBi"�Ƞ�(�^y)���]��B٫��O@!Z�LSu����g�*�G��jk� +:N��G ���rU�����Y� �%��tz*}%X�l$�<�(kA2x2G O���@nPr0���J<ER�@�!qZ6��c�w�)�2�l�ف"��C��tK���/�<w�c�� ���Gᖷm��{      �   ]   x�3��M,JN4�4202�54�50U0��21�26�37�4�4�,�/.I/J-��".#�#�s�:z{�8�i15�2�Գ4116�D����� �j%�      �   �   x�e�A
�0D��)�Z����;�]��]7�~J mJO���܈0�qrF���8i0ho6m^�&��}��D�q�1	\Յ�E�WRUjG6��1��O������p�mm/d�5&���\ ��q6!��>��M�@[�kL�_�5+sUJ^��ƜR�pk8�      �     x���MJ�@�םS\w������Ną�f6��!�1C&���^��M�.D(����������:2H�,JO���
������k)y�A<�'�6d�y�1��{8_�ҥ�,�\R>?^6�E�B-AIE-����6�c &q���i.Wq|��c(��R�d�!��s]�b��<��9�t(�cKF#l��/:�?�2 GGՍ��q��!�T��%k� ����8�=��?	dM-�P���e:�a��IaK��ހ�%���u?1�]�4_ቀL      �   �   x���=�0��9E.��v�����K�F���?܊Sp1\� `������;�EYը<�&�4�[�C�	���d�h/q�õ܃%`d�f�-Սs.�LiYOs\�=���*/�	��Sǃ�7��;��� _G�݁�{"`F�K��<*l��nӈ���AxiXrFt�hsc���N�      �      x������ � �      �   �   x�]�1n�0@љ>E/ C�H9�� {N����ԈmR�Z=C/֠K� �Ë�}��&�v2$ɚ�뒡)Xv'O��)e����E���)C̥h>ꗬ��m�����(R��[�uޠ5�?�|?Xl�:�=�ǭh���UCIS�.'�bP��F2cd���Ni�����C8�#�)IY�����˼H��܋�ucB����8��;�����6M���Q�      �   D   x�3�4400566037�4�4202�54�50U0��25�22�3337�0�,�/.I/J-��"�=... ��/     