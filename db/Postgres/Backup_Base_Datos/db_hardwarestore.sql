PGDMP         $                {            db_hardwarestore    15.3    15.3 r    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    57975    db_hardwarestore    DATABASE     �   CREATE DATABASE db_hardwarestore WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Colombia.1252';
     DROP DATABASE db_hardwarestore;
                postgres    false            �            1255    58130    actualizar_estado()    FUNCTION     �   CREATE FUNCTION public.actualizar_estado() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.estado = 'inactivo' THEN
        NEW.estado := 'inactivo';
    END IF;
	
RETURN NEW;
END;
$$;
 *   DROP FUNCTION public.actualizar_estado();
       public          postgres    false            �            1255    58138    actualizar_stock_val_unit()    FUNCTION     �  CREATE FUNCTION public.actualizar_stock_val_unit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  zval_stock tab_articulo.val_stock%type;
  zval_unit tab_articulo.val_unit%type;
  
BEGIN

  IF NEW.tipo_mov = 'ENTRADA' THEN
    	zval_stock := (SELECT COALESCE(val_stock, 0) + NEW.cant_art FROM tab_articulo WHERE ean_art = NEW.ean_art);
    	zval_unit := NEW.val_prom * 1.20;
	
  	 ELSIF NEW.tipo_mov = 'SALIDA' THEN
    	zval_stock := (SELECT COALESCE(val_stock, 0) - NEW.cant_art FROM tab_articulo WHERE ean_art = NEW.ean_art);
    	zval_unit := (SELECT val_unit FROM tab_articulo WHERE ean_art = NEW.ean_art);
  END IF;

  UPDATE tab_articulo SET val_stock = zval_stock, val_unit = zval_unit WHERE ean_art = NEW.ean_art;

RETURN NEW;
END;
$$;
 2   DROP FUNCTION public.actualizar_stock_val_unit();
       public          postgres    false            �            1255    58193 m   insert_articulo(character varying, character varying, bigint, bigint, text, character varying, integer, date)    FUNCTION     �  CREATE FUNCTION public.insert_articulo(zean_art character varying, znom_art character varying, zconsec_marca bigint, zconsec_categ bigint, zdescrip_art text, zunid_med character varying, ziva integer, zfec_vence date) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    zfec_reg timestamp := current_timestamp;--now(); puede ser current_timestamp o now();
	zmarca tab_marca.consec_marca%type;
	zcategoria tab_categoria.consec_categ%type;
BEGIN

SELECT consec_marca INTO zmarca FROM tab_marca WHERE consec_marca=zconsec_marca;
SELECT consec_categ INTO zcategoria FROM tab_categoria WHERE consec_categ=zconsec_categ; 
    
	INSERT INTO tab_articulo(ean_art, fec_reg, nom_art,consec_marca, consec_categ, descrip_art, unid_med, iva, fec_vence)
    VALUES (zean_art, zfec_reg, znom_art, zmarca, zcategoria, zdescrip_art, zunid_med, ziva, zfec_vence);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$;
 �   DROP FUNCTION public.insert_articulo(zean_art character varying, znom_art character varying, zconsec_marca bigint, zconsec_categ bigint, zdescrip_art text, zunid_med character varying, ziva integer, zfec_vence date);
       public          postgres    false            �            1255    58194 #   insert_categoria(character varying)    FUNCTION     �   CREATE FUNCTION public.insert_categoria(znom_categ character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
      
BEGIN

    INSERT INTO tab_categoria(nom_categ)
    VALUES (znom_categ);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$;
 E   DROP FUNCTION public.insert_categoria(znom_categ character varying);
       public          postgres    false                        1255    58195 �   insert_cliente(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.insert_cliente(ztipo_cli character varying, zid_cli character varying, znom_cli character varying, zape_cli character varying, znom_empr character varying, ztel_cli character varying, zemail_cli character varying, zdir_cli character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    
    zfec_reg timestamp := current_timestamp; --now();
	
BEGIN

    INSERT INTO tab_cliente(fec_reg, tipo_cli, id_cli, nom_cli, ape_cli, nom_empr, tel_cli, email_cli, dir_cli)
    VALUES (zfec_reg, ztipo_cli, zid_cli, znom_cli, zape_cli, znom_empr, ztel_cli, zemail_cli, zdir_cli);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$;
   DROP FUNCTION public.insert_cliente(ztipo_cli character varying, zid_cli character varying, znom_cli character varying, zape_cli character varying, znom_empr character varying, ztel_cli character varying, zemail_cli character varying, zdir_cli character varying);
       public          postgres    false                       1255    58201 9   insert_detalle_venta(character varying, integer, numeric)    FUNCTION       CREATE FUNCTION public.insert_detalle_venta(zean_art character varying, zcant_art integer, zdescuento numeric) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    zval_unit NUMERIC(10);
    zsubtotal NUMERIC(10);
    ziva NUMERIC(10);
    ztotal_pagar NUMERIC(10);
    zconsec_venta BIGINT;
BEGIN
    -- Obtener el valor unitario (val_unit) del artículo desde la tabla "tab_articulo"
    SELECT val_unit INTO zval_unit FROM tab_articulo WHERE ean_art = zean_art;

    -- Calcular el subtotal, el valor del IVA y el total a pagar
    zsubtotal := zcant_art * zval_unit;
    SELECT iva INTO ziva FROM tab_articulo WHERE ean_art = zean_art;
    ztotal_pagar :=  (zsubtotal * ziva)/100+(zsubtotal)-zdescuento;

    -- Obtener el consecutivo de venta (consec_venta) desde la tabla "tab_encabezado_venta"
    SELECT consec_venta INTO zconsec_venta FROM tab_encabezado_venta ORDER BY consec_venta DESC LIMIT 1;

    -- Insertar los datos en la tabla "tab_detalle_venta"
    INSERT INTO tab_detalle_venta (nom_art, cant_art, val_unit, Subtotal, Descuento, val_iva, Total_Pagar, consec_venta, ean_art)
    VALUES ((SELECT nom_art FROM tab_articulo WHERE ean_art = zean_art), zcant_art, zval_unit, zsubtotal, zdescuento, ziva, ztotal_pagar, zconsec_venta, zean_art);

    RETURN;
END;
$$;
 n   DROP FUNCTION public.insert_detalle_venta(zean_art character varying, zcant_art integer, zdescuento numeric);
       public          postgres    false                       1255    58198 *   insert_encabezado_venta(character varying)    FUNCTION       CREATE FUNCTION public.insert_encabezado_venta(zid_cli character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE 
zfec_venta timestamp:= current_timestamp;

BEGIN
	insert into tab_encabezado_venta (fec_venta,id_cli)
	values(zfec_venta, zid_cli);

RETURN ;
END;
$$;
 I   DROP FUNCTION public.insert_encabezado_venta(zid_cli character varying);
       public          postgres    false            �            1255    58192 f   insert_kardex(character varying, character varying, character varying, integer, numeric, text, bigint)    FUNCTION     j  CREATE FUNCTION public.insert_kardex(ztipo_mov character varying, zean_art character varying, znom_art character varying, zcant_art integer, zval_compra numeric, zobservacion text, zconsec_prov bigint) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    zfec_mov timestamp := current_timestamp; --now(); puede ser current_timestamp o now();
    zval_prom tab_kardex.val_prom%type;
    zval_total tab_kardex.val_total%type;
	
BEGIN
    IF ztipo_mov ='ENTRADA' THEN
        zval_total := zcant_art * zval_compra;
        zval_prom := zval_total / zcant_art;
		
    	ELSIF ztipo_mov ='SALIDA' THEN
        zval_total := 0; -- No se realiza el cálculo para 'SALIDA', asignamos  un valor por defecto.
        zval_prom := 0;  -- No se realiza el cálculo para 'SALIDA', asignamos un valor por defecto.
    END IF;

    INSERT INTO tab_kardex( fec_mov, tipo_mov, ean_art, nom_art, cant_art, val_compra, val_total, val_prom, observacion, consec_prov)
    VALUES (zfec_mov, ztipo_mov, zean_art, znom_art, zcant_art, zval_compra, zval_total, zval_prom, zobservacion, zconsec_prov);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$;
 �   DROP FUNCTION public.insert_kardex(ztipo_mov character varying, zean_art character varying, znom_art character varying, zcant_art integer, zval_compra numeric, zobservacion text, zconsec_prov bigint);
       public          postgres    false            �            1255    58191    insert_marca(character varying)    FUNCTION     �   CREATE FUNCTION public.insert_marca(znom_marca character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    
BEGIN

    INSERT INTO tab_marca(nom_marca)
    VALUES (znom_marca);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$;
 A   DROP FUNCTION public.insert_marca(znom_marca character varying);
       public          postgres    false            �            1255    58190 o   insert_proveedor(character varying, character varying, character varying, character varying, character varying)    FUNCTION     6  CREATE FUNCTION public.insert_proveedor(znit_prov character varying, znom_prov character varying, ztel_prov character varying, zemail_prov character varying, zdir_prov character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    
    zfec_reg timestamp := current_timestamp;--now(); puede ser current_timestamp o now();
	
BEGIN

    INSERT INTO tab_proveedor(fec_reg, nit_prov, nom_prov, tel_prov, email_prov, dir_prov)
    VALUES (zfec_reg, znit_prov, znom_prov, ztel_prov, zemail_prov, zdir_prov);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$;
 �   DROP FUNCTION public.insert_proveedor(znit_prov character varying, znom_prov character varying, ztel_prov character varying, zemail_prov character varying, zdir_prov character varying);
       public          postgres    false                       1255    58196    insert_tab_artxprov()    FUNCTION     5  CREATE FUNCTION public.insert_tab_artxprov() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  -- Verificar si ya existe una fila con los mismos valores de consec_prov y ean_art en tab_artxprov
  IF EXISTS (SELECT 1 FROM tab_artxprov WHERE consec_prov = NEW.consec_prov AND ean_art = NEW.ean_art) THEN
    -- Si existe, realizar una actualización en lugar de una inserción
    UPDATE tab_artxprov 
    SET nom_prov = (SELECT nom_prov FROM tab_proveedor WHERE consec_prov = NEW.consec_prov), 
        nom_art = (SELECT nom_art FROM tab_articulo WHERE ean_art = NEW.ean_art), 
        val_compra = NEW.val_compra
    WHERE consec_prov = NEW.consec_prov AND ean_art = NEW.ean_art;
  ELSE
    -- Si no existe, insertar una nueva fila
    INSERT INTO tab_artxprov (consec_prov, nom_prov, ean_art, nom_art, val_compra)
    VALUES (NEW.consec_prov, (SELECT nom_prov FROM tab_proveedor WHERE consec_prov = NEW.consec_prov), 
            NEW.ean_art, (SELECT nom_art FROM tab_articulo WHERE ean_art = NEW.ean_art), 
            NEW.val_compra);
  END IF;

  RETURN NEW;
END;
$$;
 ,   DROP FUNCTION public.insert_tab_artxprov();
       public          postgres    false            �            1255    58189 �   insert_usuario(integer, character varying, character varying, character varying, character varying, character varying, character varying)    FUNCTION     c  CREATE FUNCTION public.insert_usuario(zid_usu integer, znom_usu character varying, zape_usu character varying, ztel_usu character varying, zemail_usu character varying, zusuario character varying, zpassword character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    Zfec_reg timestamp := now(); /*tambien puedo usar current_timestamp*/
	
BEGIN

    INSERT INTO tab_usuario(id_usu, fec_reg, nom_usu, ape_usu, tel_usu, email_usu, usuario, password)
    VALUES ( zid_usu, zfec_reg, znom_usu, zape_usu, ztel_usu, zemail_usu, zusuario, zpassword);
    
    RAISE NOTICE 'Registro exitoso ';
END;
$$;
 �   DROP FUNCTION public.insert_usuario(zid_usu integer, znom_usu character varying, zape_usu character varying, ztel_usu character varying, zemail_usu character varying, zusuario character varying, zpassword character varying);
       public          postgres    false            �            1255    58166    movimientos_user()    FUNCTION     �  CREATE FUNCTION public.movimientos_user() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP='INSERT' THEN
    	NEW.fec_insert := now();
    	NEW.user_insert := current_user;
		RETURN NEW;
	END IF;
	
	IF TG_OP='UPDATE' THEN
		NEW.fec_update := now();
		NEW.user_update := current_user;
		RETURN NEW;
	END IF;
	
	IF TG_OP= 'DELETE' THEN
	  INSERT INTO reg_borrados (fec_delete,user_delete,nom_tabla)
	  VALUES(current_timestamp,current_user,TG_RELNAME);
	
	  RETURN OLD;
	END IF ;

END;

$$;
 )   DROP FUNCTION public.movimientos_user();
       public          postgres    false                       1255    58199 #   update_encabezado_venta_val_pagar()    FUNCTION     H  CREATE FUNCTION public.update_encabezado_venta_val_pagar() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    Ztotal_pagar numeric(10);
BEGIN
    -- Obtener el "Total_Pagar" de "tab_detalle_venta" para el consec_venta correspondiente
    SELECT SUM(total_pagar) INTO Ztotal_pagar FROM tab_detalle_venta WHERE consec_venta = NEW.consec_venta;

    -- Actualizar el campo "val_pagar" en "tab_encabezado_venta" con el valor calculado
    UPDATE tab_encabezado_venta AS enc
    SET val_pagar = Ztotal_pagar
    WHERE enc.consec_venta = NEW.consec_venta;

    RETURN NEW;
END;
$$;
 :   DROP FUNCTION public.update_encabezado_venta_val_pagar();
       public          postgres    false            �            1259    57981 
   consec_art    SEQUENCE     s   CREATE SEQUENCE public.consec_art
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.consec_art;
       public          postgres    false            �            1259    57982    consec_artxprov    SEQUENCE     x   CREATE SEQUENCE public.consec_artxprov
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.consec_artxprov;
       public          postgres    false            �            1259    57979    consec_categ    SEQUENCE     u   CREATE SEQUENCE public.consec_categ
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.consec_categ;
       public          postgres    false            �            1259    57977 
   consec_cli    SEQUENCE     s   CREATE SEQUENCE public.consec_cli
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.consec_cli;
       public          postgres    false            �            1259    57985    consec_det_venta    SEQUENCE     y   CREATE SEQUENCE public.consec_det_venta
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.consec_det_venta;
       public          postgres    false            �            1259    57983    consec_kardex    SEQUENCE     v   CREATE SEQUENCE public.consec_kardex
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.consec_kardex;
       public          postgres    false            �            1259    57980    consec_marca    SEQUENCE     u   CREATE SEQUENCE public.consec_marca
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.consec_marca;
       public          postgres    false            �            1259    57978    consec_prov    SEQUENCE     t   CREATE SEQUENCE public.consec_prov
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.consec_prov;
       public          postgres    false            �            1259    57986 
   consec_reg    SEQUENCE     s   CREATE SEQUENCE public.consec_reg
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.consec_reg;
       public          postgres    false            �            1259    57976 
   consec_usu    SEQUENCE     s   CREATE SEQUENCE public.consec_usu
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.consec_usu;
       public          postgres    false            �            1259    57984    consec_venta    SEQUENCE     u   CREATE SEQUENCE public.consec_venta
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.consec_venta;
       public          postgres    false            �            1259    58122    reg_borrados    TABLE     �   CREATE TABLE public.reg_borrados (
    consec_reg bigint DEFAULT nextval('public.consec_reg'::regclass) NOT NULL,
    fec_delete timestamp without time zone,
    user_delete character varying NOT NULL,
    nom_tabla character varying NOT NULL
);
     DROP TABLE public.reg_borrados;
       public         heap    postgres    false    224            �            1259    58031    tab_articulo    TABLE     -  CREATE TABLE public.tab_articulo (
    consec_art bigint DEFAULT nextval('public.consec_art'::regclass) NOT NULL,
    ean_art character varying NOT NULL,
    fec_reg timestamp without time zone NOT NULL,
    nom_art character varying NOT NULL,
    consec_marca bigint NOT NULL,
    consec_categ bigint NOT NULL,
    descrip_art text,
    unid_med character varying NOT NULL,
    val_unit numeric(10,0),
    iva integer NOT NULL,
    val_stock integer,
    stock_min integer DEFAULT 10 NOT NULL,
    stock_max integer DEFAULT 500 NOT NULL,
    val_reorden integer DEFAULT 50 NOT NULL,
    fec_vence date,
    estado text DEFAULT 'ACTIVO'::text NOT NULL,
    fec_insert timestamp without time zone,
    user_insert character varying,
    fec_update timestamp without time zone,
    user_update character varying
);
     DROP TABLE public.tab_articulo;
       public         heap    postgres    false    219            �            1259    58071    tab_artxprov    TABLE     �  CREATE TABLE public.tab_artxprov (
    consec_artxprov bigint DEFAULT nextval('public.consec_artxprov'::regclass) NOT NULL,
    consec_prov bigint NOT NULL,
    nom_prov character varying NOT NULL,
    ean_art character varying NOT NULL,
    nom_art character varying NOT NULL,
    val_compra numeric(10,0) NOT NULL,
    fec_insert timestamp without time zone,
    user_insert character varying,
    fec_update timestamp without time zone,
    user_update character varying
);
     DROP TABLE public.tab_artxprov;
       public         heap    postgres    false    220            �            1259    58013    tab_categoria    TABLE     r  CREATE TABLE public.tab_categoria (
    consec_categ bigint DEFAULT nextval('public.consec_categ'::regclass) NOT NULL,
    nom_categ character varying NOT NULL,
    estado text DEFAULT 'ACTIVO'::text NOT NULL,
    fec_insert timestamp without time zone,
    user_insert character varying,
    fec_update timestamp without time zone,
    user_update character varying
);
 !   DROP TABLE public.tab_categoria;
       public         heap    postgres    false    217            �            1259    57996    tab_cliente    TABLE     k  CREATE TABLE public.tab_cliente (
    consec_cli bigint DEFAULT nextval('public.consec_cli'::regclass) NOT NULL,
    fec_reg timestamp without time zone NOT NULL,
    tipo_cli character varying NOT NULL,
    id_cli character varying NOT NULL,
    nom_cli character varying,
    ape_cli character varying,
    nom_empr character varying,
    tel_cli character varying NOT NULL,
    email_cli character varying NOT NULL,
    dir_cli character varying NOT NULL,
    fec_insert timestamp without time zone,
    user_insert character varying,
    fec_update timestamp without time zone,
    user_update character varying
);
    DROP TABLE public.tab_cliente;
       public         heap    postgres    false    215            �            1259    58103    tab_detalle_venta    TABLE     �  CREATE TABLE public.tab_detalle_venta (
    consec_det_venta bigint DEFAULT nextval('public.consec_det_venta'::regclass) NOT NULL,
    consec_venta bigint NOT NULL,
    ean_art character varying NOT NULL,
    nom_art character varying NOT NULL,
    cant_art integer NOT NULL,
    val_unit numeric(10,0) NOT NULL,
    subtotal numeric(10,0) NOT NULL,
    descuento numeric(10,0) NOT NULL,
    val_iva numeric(10,0) NOT NULL,
    total_pagar numeric(10,0) NOT NULL,
    estado text DEFAULT 'ACTIVO'::text NOT NULL,
    fec_insert timestamp without time zone,
    user_insert character varying,
    fec_update timestamp without time zone,
    user_update character varying
);
 %   DROP TABLE public.tab_detalle_venta;
       public         heap    postgres    false    223            �            1259    58089    tab_encabezado_venta    TABLE     �  CREATE TABLE public.tab_encabezado_venta (
    consec_venta bigint DEFAULT nextval('public.consec_venta'::regclass) NOT NULL,
    fec_venta timestamp without time zone NOT NULL,
    id_cli character varying NOT NULL,
    val_pagar numeric(10,0),
    estado text DEFAULT 'ACTIVO'::text NOT NULL,
    fec_insert timestamp without time zone,
    user_insert character varying,
    fec_update timestamp without time zone,
    user_update character varying
);
 (   DROP TABLE public.tab_encabezado_venta;
       public         heap    postgres    false    222            �            1259    58053 
   tab_kardex    TABLE     �  CREATE TABLE public.tab_kardex (
    consec_kardex bigint DEFAULT nextval('public.consec_kardex'::regclass) NOT NULL,
    fec_mov timestamp without time zone NOT NULL,
    tipo_mov character varying NOT NULL,
    ean_art character varying NOT NULL,
    nom_art character varying NOT NULL,
    cant_art integer NOT NULL,
    val_compra numeric(10,0) NOT NULL,
    val_total numeric(10,0) NOT NULL,
    val_prom numeric(10,0) NOT NULL,
    observacion text,
    consec_prov bigint NOT NULL,
    fec_insert timestamp without time zone,
    user_insert character varying,
    fec_update timestamp without time zone,
    user_update character varying
);
    DROP TABLE public.tab_kardex;
       public         heap    postgres    false    221            �            1259    58022 	   tab_marca    TABLE     n  CREATE TABLE public.tab_marca (
    consec_marca bigint DEFAULT nextval('public.consec_marca'::regclass) NOT NULL,
    nom_marca character varying NOT NULL,
    estado text DEFAULT 'ACTIVO'::text NOT NULL,
    fec_insert timestamp without time zone,
    user_insert character varying,
    fec_update timestamp without time zone,
    user_update character varying
);
    DROP TABLE public.tab_marca;
       public         heap    postgres    false    218            �            1259    58004    tab_proveedor    TABLE     G  CREATE TABLE public.tab_proveedor (
    consec_prov bigint DEFAULT nextval('public.consec_prov'::regclass) NOT NULL,
    nit_prov character varying NOT NULL,
    fec_reg timestamp without time zone NOT NULL,
    nom_prov character varying NOT NULL,
    tel_prov character varying NOT NULL,
    email_prov character varying NOT NULL,
    dir_prov character varying NOT NULL,
    estado text DEFAULT 'ACTIVO'::text NOT NULL,
    fec_insert timestamp without time zone,
    user_insert character varying,
    fec_update timestamp without time zone,
    user_update character varying
);
 !   DROP TABLE public.tab_proveedor;
       public         heap    postgres    false    216            �            1259    57987    tab_usuario    TABLE     �  CREATE TABLE public.tab_usuario (
    consec_usu bigint DEFAULT nextval('public.consec_usu'::regclass) NOT NULL,
    id_usu integer NOT NULL,
    fec_reg timestamp without time zone NOT NULL,
    nom_usu character varying NOT NULL,
    ape_usu character varying NOT NULL,
    tel_usu character varying NOT NULL,
    email_usu character varying NOT NULL,
    usuario character varying NOT NULL,
    password character varying NOT NULL,
    estado text DEFAULT 'ACTIVO'::text NOT NULL,
    fec_insert timestamp without time zone,
    user_insert character varying,
    fec_update timestamp without time zone,
    user_update character varying
);
    DROP TABLE public.tab_usuario;
       public         heap    postgres    false    214            �          0    58122    reg_borrados 
   TABLE DATA           V   COPY public.reg_borrados (consec_reg, fec_delete, user_delete, nom_tabla) FROM stdin;
    public          postgres    false    235    �       �          0    58031    tab_articulo 
   TABLE DATA             COPY public.tab_articulo (consec_art, ean_art, fec_reg, nom_art, consec_marca, consec_categ, descrip_art, unid_med, val_unit, iva, val_stock, stock_min, stock_max, val_reorden, fec_vence, estado, fec_insert, user_insert, fec_update, user_update) FROM stdin;
    public          postgres    false    230   �       �          0    58071    tab_artxprov 
   TABLE DATA           �   COPY public.tab_artxprov (consec_artxprov, consec_prov, nom_prov, ean_art, nom_art, val_compra, fec_insert, user_insert, fec_update, user_update) FROM stdin;
    public          postgres    false    232   ��       �          0    58013    tab_categoria 
   TABLE DATA           z   COPY public.tab_categoria (consec_categ, nom_categ, estado, fec_insert, user_insert, fec_update, user_update) FROM stdin;
    public          postgres    false    228   �       �          0    57996    tab_cliente 
   TABLE DATA           �   COPY public.tab_cliente (consec_cli, fec_reg, tipo_cli, id_cli, nom_cli, ape_cli, nom_empr, tel_cli, email_cli, dir_cli, fec_insert, user_insert, fec_update, user_update) FROM stdin;
    public          postgres    false    226   o�       �          0    58103    tab_detalle_venta 
   TABLE DATA           �   COPY public.tab_detalle_venta (consec_det_venta, consec_venta, ean_art, nom_art, cant_art, val_unit, subtotal, descuento, val_iva, total_pagar, estado, fec_insert, user_insert, fec_update, user_update) FROM stdin;
    public          postgres    false    234    �       �          0    58089    tab_encabezado_venta 
   TABLE DATA           �   COPY public.tab_encabezado_venta (consec_venta, fec_venta, id_cli, val_pagar, estado, fec_insert, user_insert, fec_update, user_update) FROM stdin;
    public          postgres    false    233   p�       �          0    58053 
   tab_kardex 
   TABLE DATA           �   COPY public.tab_kardex (consec_kardex, fec_mov, tipo_mov, ean_art, nom_art, cant_art, val_compra, val_total, val_prom, observacion, consec_prov, fec_insert, user_insert, fec_update, user_update) FROM stdin;
    public          postgres    false    231   ��       �          0    58022 	   tab_marca 
   TABLE DATA           v   COPY public.tab_marca (consec_marca, nom_marca, estado, fec_insert, user_insert, fec_update, user_update) FROM stdin;
    public          postgres    false    229   |�       �          0    58004    tab_proveedor 
   TABLE DATA           �   COPY public.tab_proveedor (consec_prov, nit_prov, fec_reg, nom_prov, tel_prov, email_prov, dir_prov, estado, fec_insert, user_insert, fec_update, user_update) FROM stdin;
    public          postgres    false    227   ��       �          0    57987    tab_usuario 
   TABLE DATA           �   COPY public.tab_usuario (consec_usu, id_usu, fec_reg, nom_usu, ape_usu, tel_usu, email_usu, usuario, password, estado, fec_insert, user_insert, fec_update, user_update) FROM stdin;
    public          postgres    false    225   _�       �           0    0 
   consec_art    SEQUENCE SET     8   SELECT pg_catalog.setval('public.consec_art', 3, true);
          public          postgres    false    219            �           0    0    consec_artxprov    SEQUENCE SET     =   SELECT pg_catalog.setval('public.consec_artxprov', 1, true);
          public          postgres    false    220            �           0    0    consec_categ    SEQUENCE SET     :   SELECT pg_catalog.setval('public.consec_categ', 1, true);
          public          postgres    false    217            �           0    0 
   consec_cli    SEQUENCE SET     8   SELECT pg_catalog.setval('public.consec_cli', 1, true);
          public          postgres    false    215            �           0    0    consec_det_venta    SEQUENCE SET     >   SELECT pg_catalog.setval('public.consec_det_venta', 1, true);
          public          postgres    false    223            �           0    0    consec_kardex    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.consec_kardex', 5, true);
          public          postgres    false    221            �           0    0    consec_marca    SEQUENCE SET     :   SELECT pg_catalog.setval('public.consec_marca', 1, true);
          public          postgres    false    218            �           0    0    consec_prov    SEQUENCE SET     9   SELECT pg_catalog.setval('public.consec_prov', 1, true);
          public          postgres    false    216            �           0    0 
   consec_reg    SEQUENCE SET     9   SELECT pg_catalog.setval('public.consec_reg', 1, false);
          public          postgres    false    224            �           0    0 
   consec_usu    SEQUENCE SET     8   SELECT pg_catalog.setval('public.consec_usu', 1, true);
          public          postgres    false    214            �           0    0    consec_venta    SEQUENCE SET     :   SELECT pg_catalog.setval('public.consec_venta', 1, true);
          public          postgres    false    222            �           2606    58129    reg_borrados reg_borrados_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.reg_borrados
    ADD CONSTRAINT reg_borrados_pkey PRIMARY KEY (consec_reg);
 H   ALTER TABLE ONLY public.reg_borrados DROP CONSTRAINT reg_borrados_pkey;
       public            postgres    false    235            �           2606    58042    tab_articulo tab_articulo_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.tab_articulo
    ADD CONSTRAINT tab_articulo_pkey PRIMARY KEY (ean_art);
 H   ALTER TABLE ONLY public.tab_articulo DROP CONSTRAINT tab_articulo_pkey;
       public            postgres    false    230            �           2606    58078    tab_artxprov tab_artxprov_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.tab_artxprov
    ADD CONSTRAINT tab_artxprov_pkey PRIMARY KEY (consec_artxprov);
 H   ALTER TABLE ONLY public.tab_artxprov DROP CONSTRAINT tab_artxprov_pkey;
       public            postgres    false    232            �           2606    58021     tab_categoria tab_categoria_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.tab_categoria
    ADD CONSTRAINT tab_categoria_pkey PRIMARY KEY (consec_categ);
 J   ALTER TABLE ONLY public.tab_categoria DROP CONSTRAINT tab_categoria_pkey;
       public            postgres    false    228            �           2606    58003    tab_cliente tab_cliente_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.tab_cliente
    ADD CONSTRAINT tab_cliente_pkey PRIMARY KEY (id_cli);
 F   ALTER TABLE ONLY public.tab_cliente DROP CONSTRAINT tab_cliente_pkey;
       public            postgres    false    226            �           2606    58111 (   tab_detalle_venta tab_detalle_venta_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.tab_detalle_venta
    ADD CONSTRAINT tab_detalle_venta_pkey PRIMARY KEY (consec_det_venta);
 R   ALTER TABLE ONLY public.tab_detalle_venta DROP CONSTRAINT tab_detalle_venta_pkey;
       public            postgres    false    234            �           2606    58097 .   tab_encabezado_venta tab_encabezado_venta_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.tab_encabezado_venta
    ADD CONSTRAINT tab_encabezado_venta_pkey PRIMARY KEY (consec_venta);
 X   ALTER TABLE ONLY public.tab_encabezado_venta DROP CONSTRAINT tab_encabezado_venta_pkey;
       public            postgres    false    233            �           2606    58060    tab_kardex tab_kardex_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.tab_kardex
    ADD CONSTRAINT tab_kardex_pkey PRIMARY KEY (consec_kardex);
 D   ALTER TABLE ONLY public.tab_kardex DROP CONSTRAINT tab_kardex_pkey;
       public            postgres    false    231            �           2606    58030    tab_marca tab_marca_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.tab_marca
    ADD CONSTRAINT tab_marca_pkey PRIMARY KEY (consec_marca);
 B   ALTER TABLE ONLY public.tab_marca DROP CONSTRAINT tab_marca_pkey;
       public            postgres    false    229            �           2606    58012     tab_proveedor tab_proveedor_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.tab_proveedor
    ADD CONSTRAINT tab_proveedor_pkey PRIMARY KEY (consec_prov);
 J   ALTER TABLE ONLY public.tab_proveedor DROP CONSTRAINT tab_proveedor_pkey;
       public            postgres    false    227            �           2606    57995    tab_usuario tab_usuario_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.tab_usuario
    ADD CONSTRAINT tab_usuario_pkey PRIMARY KEY (consec_usu);
 F   ALTER TABLE ONLY public.tab_usuario DROP CONSTRAINT tab_usuario_pkey;
       public            postgres    false    225            �           1259    58187 	   index_ean    INDEX     E   CREATE INDEX index_ean ON public.tab_articulo USING btree (ean_art);
    DROP INDEX public.index_ean;
       public            postgres    false    230            �           1259    58188    index_fecha    INDEX     G   CREATE INDEX index_fecha ON public.tab_articulo USING btree (fec_reg);
    DROP INDEX public.index_fecha;
       public            postgres    false    230            �           2620    58135 3   tab_articulo trigger_actualizar_estado_tab_articulo    TRIGGER     �   CREATE TRIGGER trigger_actualizar_estado_tab_articulo BEFORE UPDATE ON public.tab_articulo FOR EACH ROW EXECUTE FUNCTION public.actualizar_estado();
 L   DROP TRIGGER trigger_actualizar_estado_tab_articulo ON public.tab_articulo;
       public          postgres    false    236    230            �           2620    58133 5   tab_categoria trigger_actualizar_estado_tab_categoria    TRIGGER     �   CREATE TRIGGER trigger_actualizar_estado_tab_categoria BEFORE UPDATE ON public.tab_categoria FOR EACH ROW EXECUTE FUNCTION public.actualizar_estado();
 N   DROP TRIGGER trigger_actualizar_estado_tab_categoria ON public.tab_categoria;
       public          postgres    false    236    228            �           2620    58137 =   tab_detalle_venta trigger_actualizar_estado_tab_detalle_venta    TRIGGER     �   CREATE TRIGGER trigger_actualizar_estado_tab_detalle_venta BEFORE UPDATE ON public.tab_detalle_venta FOR EACH ROW EXECUTE FUNCTION public.actualizar_estado();
 V   DROP TRIGGER trigger_actualizar_estado_tab_detalle_venta ON public.tab_detalle_venta;
       public          postgres    false    236    234            �           2620    58136 C   tab_encabezado_venta trigger_actualizar_estado_tab_encabezado_venta    TRIGGER     �   CREATE TRIGGER trigger_actualizar_estado_tab_encabezado_venta BEFORE UPDATE ON public.tab_encabezado_venta FOR EACH ROW EXECUTE FUNCTION public.actualizar_estado();
 \   DROP TRIGGER trigger_actualizar_estado_tab_encabezado_venta ON public.tab_encabezado_venta;
       public          postgres    false    233    236            �           2620    58134 -   tab_marca trigger_actualizar_estado_tab_marca    TRIGGER     �   CREATE TRIGGER trigger_actualizar_estado_tab_marca BEFORE UPDATE ON public.tab_marca FOR EACH ROW EXECUTE FUNCTION public.actualizar_estado();
 F   DROP TRIGGER trigger_actualizar_estado_tab_marca ON public.tab_marca;
       public          postgres    false    236    229            �           2620    58132 5   tab_proveedor trigger_actualizar_estado_tab_proveedor    TRIGGER     �   CREATE TRIGGER trigger_actualizar_estado_tab_proveedor BEFORE UPDATE ON public.tab_proveedor FOR EACH ROW EXECUTE FUNCTION public.actualizar_estado();
 N   DROP TRIGGER trigger_actualizar_estado_tab_proveedor ON public.tab_proveedor;
       public          postgres    false    227    236            �           2620    58131 1   tab_usuario trigger_actualizar_estado_tab_usuario    TRIGGER     �   CREATE TRIGGER trigger_actualizar_estado_tab_usuario BEFORE UPDATE ON public.tab_usuario FOR EACH ROW EXECUTE FUNCTION public.actualizar_estado();
 J   DROP TRIGGER trigger_actualizar_estado_tab_usuario ON public.tab_usuario;
       public          postgres    false    236    225            �           2620    58139 ,   tab_kardex trigger_actualizar_stock_val_unit    TRIGGER     �   CREATE TRIGGER trigger_actualizar_stock_val_unit AFTER INSERT ON public.tab_kardex FOR EACH ROW EXECUTE FUNCTION public.actualizar_stock_val_unit();
 E   DROP TRIGGER trigger_actualizar_stock_val_unit ON public.tab_kardex;
       public          postgres    false    237    231            �           2620    58197 &   tab_kardex trigger_insert_tab_artxprov    TRIGGER     �   CREATE TRIGGER trigger_insert_tab_artxprov AFTER INSERT ON public.tab_kardex FOR EACH ROW EXECUTE FUNCTION public.insert_tab_artxprov();
 ?   DROP TRIGGER trigger_insert_tab_artxprov ON public.tab_kardex;
       public          postgres    false    231    257            �           2620    58178 !   tab_articulo trigger_reg_borrados    TRIGGER     �   CREATE TRIGGER trigger_reg_borrados AFTER DELETE ON public.tab_articulo FOR EACH ROW EXECUTE FUNCTION public.movimientos_user();
 :   DROP TRIGGER trigger_reg_borrados ON public.tab_articulo;
       public          postgres    false    238    230            �           2620    58182 !   tab_artxprov trigger_reg_borrados    TRIGGER     �   CREATE TRIGGER trigger_reg_borrados AFTER DELETE ON public.tab_artxprov FOR EACH ROW EXECUTE FUNCTION public.movimientos_user();
 :   DROP TRIGGER trigger_reg_borrados ON public.tab_artxprov;
       public          postgres    false    238    232            �           2620    58174 "   tab_categoria trigger_reg_borrados    TRIGGER     �   CREATE TRIGGER trigger_reg_borrados AFTER DELETE ON public.tab_categoria FOR EACH ROW EXECUTE FUNCTION public.movimientos_user();
 ;   DROP TRIGGER trigger_reg_borrados ON public.tab_categoria;
       public          postgres    false    238    228            �           2620    58170     tab_cliente trigger_reg_borrados    TRIGGER     �   CREATE TRIGGER trigger_reg_borrados AFTER DELETE ON public.tab_cliente FOR EACH ROW EXECUTE FUNCTION public.movimientos_user();
 9   DROP TRIGGER trigger_reg_borrados ON public.tab_cliente;
       public          postgres    false    238    226            �           2620    58186 &   tab_detalle_venta trigger_reg_borrados    TRIGGER     �   CREATE TRIGGER trigger_reg_borrados AFTER DELETE ON public.tab_detalle_venta FOR EACH ROW EXECUTE FUNCTION public.movimientos_user();
 ?   DROP TRIGGER trigger_reg_borrados ON public.tab_detalle_venta;
       public          postgres    false    234    238            �           2620    58184 )   tab_encabezado_venta trigger_reg_borrados    TRIGGER     �   CREATE TRIGGER trigger_reg_borrados AFTER DELETE ON public.tab_encabezado_venta FOR EACH ROW EXECUTE FUNCTION public.movimientos_user();
 B   DROP TRIGGER trigger_reg_borrados ON public.tab_encabezado_venta;
       public          postgres    false    233    238            �           2620    58180    tab_kardex trigger_reg_borrados    TRIGGER        CREATE TRIGGER trigger_reg_borrados AFTER DELETE ON public.tab_kardex FOR EACH ROW EXECUTE FUNCTION public.movimientos_user();
 8   DROP TRIGGER trigger_reg_borrados ON public.tab_kardex;
       public          postgres    false    238    231            �           2620    58176    tab_marca trigger_reg_borrados    TRIGGER     ~   CREATE TRIGGER trigger_reg_borrados AFTER DELETE ON public.tab_marca FOR EACH ROW EXECUTE FUNCTION public.movimientos_user();
 7   DROP TRIGGER trigger_reg_borrados ON public.tab_marca;
       public          postgres    false    238    229            �           2620    58172 "   tab_proveedor trigger_reg_borrados    TRIGGER     �   CREATE TRIGGER trigger_reg_borrados AFTER DELETE ON public.tab_proveedor FOR EACH ROW EXECUTE FUNCTION public.movimientos_user();
 ;   DROP TRIGGER trigger_reg_borrados ON public.tab_proveedor;
       public          postgres    false    227    238            �           2620    58168     tab_usuario trigger_reg_borrados    TRIGGER     �   CREATE TRIGGER trigger_reg_borrados AFTER DELETE ON public.tab_usuario FOR EACH ROW EXECUTE FUNCTION public.movimientos_user();
 9   DROP TRIGGER trigger_reg_borrados ON public.tab_usuario;
       public          postgres    false    238    225            �           2620    58177 !   tab_articulo trigger_tab_articulo    TRIGGER     �   CREATE TRIGGER trigger_tab_articulo BEFORE INSERT OR UPDATE ON public.tab_articulo FOR EACH ROW EXECUTE FUNCTION public.movimientos_user();
 :   DROP TRIGGER trigger_tab_articulo ON public.tab_articulo;
       public          postgres    false    238    230            �           2620    58181 !   tab_artxprov trigger_tab_artxprov    TRIGGER     �   CREATE TRIGGER trigger_tab_artxprov BEFORE INSERT OR UPDATE ON public.tab_artxprov FOR EACH ROW EXECUTE FUNCTION public.movimientos_user();
 :   DROP TRIGGER trigger_tab_artxprov ON public.tab_artxprov;
       public          postgres    false    238    232            �           2620    58173 #   tab_categoria trigger_tab_categoria    TRIGGER     �   CREATE TRIGGER trigger_tab_categoria BEFORE INSERT OR UPDATE ON public.tab_categoria FOR EACH ROW EXECUTE FUNCTION public.movimientos_user();
 <   DROP TRIGGER trigger_tab_categoria ON public.tab_categoria;
       public          postgres    false    238    228            �           2620    58169    tab_cliente trigger_tab_cliente    TRIGGER     �   CREATE TRIGGER trigger_tab_cliente BEFORE INSERT OR UPDATE ON public.tab_cliente FOR EACH ROW EXECUTE FUNCTION public.movimientos_user();
 8   DROP TRIGGER trigger_tab_cliente ON public.tab_cliente;
       public          postgres    false    238    226            �           2620    58185 +   tab_detalle_venta trigger_tab_detalle_venta    TRIGGER     �   CREATE TRIGGER trigger_tab_detalle_venta BEFORE INSERT OR UPDATE ON public.tab_detalle_venta FOR EACH ROW EXECUTE FUNCTION public.movimientos_user();
 D   DROP TRIGGER trigger_tab_detalle_venta ON public.tab_detalle_venta;
       public          postgres    false    238    234            �           2620    58183 1   tab_encabezado_venta trigger_tab_encabezado_venta    TRIGGER     �   CREATE TRIGGER trigger_tab_encabezado_venta BEFORE INSERT OR UPDATE ON public.tab_encabezado_venta FOR EACH ROW EXECUTE FUNCTION public.movimientos_user();
 J   DROP TRIGGER trigger_tab_encabezado_venta ON public.tab_encabezado_venta;
       public          postgres    false    233    238            �           2620    58179    tab_kardex trigger_tab_kardex    TRIGGER     �   CREATE TRIGGER trigger_tab_kardex BEFORE INSERT OR UPDATE ON public.tab_kardex FOR EACH ROW EXECUTE FUNCTION public.movimientos_user();
 6   DROP TRIGGER trigger_tab_kardex ON public.tab_kardex;
       public          postgres    false    238    231            �           2620    58175    tab_marca trigger_tab_marca    TRIGGER     �   CREATE TRIGGER trigger_tab_marca BEFORE INSERT OR UPDATE ON public.tab_marca FOR EACH ROW EXECUTE FUNCTION public.movimientos_user();
 4   DROP TRIGGER trigger_tab_marca ON public.tab_marca;
       public          postgres    false    238    229            �           2620    58171 #   tab_proveedor trigger_tab_proveedor    TRIGGER     �   CREATE TRIGGER trigger_tab_proveedor BEFORE INSERT OR UPDATE ON public.tab_proveedor FOR EACH ROW EXECUTE FUNCTION public.movimientos_user();
 <   DROP TRIGGER trigger_tab_proveedor ON public.tab_proveedor;
       public          postgres    false    238    227            �           2620    58167    tab_usuario trigger_tab_usuario    TRIGGER     �   CREATE TRIGGER trigger_tab_usuario BEFORE INSERT OR UPDATE ON public.tab_usuario FOR EACH ROW EXECUTE FUNCTION public.movimientos_user();
 8   DROP TRIGGER trigger_tab_usuario ON public.tab_usuario;
       public          postgres    false    238    225            �           2620    58200 1   tab_detalle_venta trigger_update_encabezado_venta    TRIGGER     �   CREATE TRIGGER trigger_update_encabezado_venta AFTER INSERT ON public.tab_detalle_venta FOR EACH ROW EXECUTE FUNCTION public.update_encabezado_venta_val_pagar();
 J   DROP TRIGGER trigger_update_encabezado_venta ON public.tab_detalle_venta;
       public          postgres    false    259    234            �           2606    58061    tab_kardex fk_articulo    FK CONSTRAINT     �   ALTER TABLE ONLY public.tab_kardex
    ADD CONSTRAINT fk_articulo FOREIGN KEY (ean_art) REFERENCES public.tab_articulo(ean_art);
 @   ALTER TABLE ONLY public.tab_kardex DROP CONSTRAINT fk_articulo;
       public          postgres    false    3271    231    230            �           2606    58084    tab_artxprov fk_articulo    FK CONSTRAINT     �   ALTER TABLE ONLY public.tab_artxprov
    ADD CONSTRAINT fk_articulo FOREIGN KEY (ean_art) REFERENCES public.tab_articulo(ean_art);
 B   ALTER TABLE ONLY public.tab_artxprov DROP CONSTRAINT fk_articulo;
       public          postgres    false    3271    230    232            �           2606    58117    tab_detalle_venta fk_articulo    FK CONSTRAINT     �   ALTER TABLE ONLY public.tab_detalle_venta
    ADD CONSTRAINT fk_articulo FOREIGN KEY (ean_art) REFERENCES public.tab_articulo(ean_art);
 G   ALTER TABLE ONLY public.tab_detalle_venta DROP CONSTRAINT fk_articulo;
       public          postgres    false    230    234    3271            �           2606    58048    tab_articulo fk_categoria    FK CONSTRAINT     �   ALTER TABLE ONLY public.tab_articulo
    ADD CONSTRAINT fk_categoria FOREIGN KEY (consec_categ) REFERENCES public.tab_categoria(consec_categ);
 C   ALTER TABLE ONLY public.tab_articulo DROP CONSTRAINT fk_categoria;
       public          postgres    false    228    3265    230            �           2606    58098    tab_encabezado_venta fk_cliente    FK CONSTRAINT     �   ALTER TABLE ONLY public.tab_encabezado_venta
    ADD CONSTRAINT fk_cliente FOREIGN KEY (id_cli) REFERENCES public.tab_cliente(id_cli);
 I   ALTER TABLE ONLY public.tab_encabezado_venta DROP CONSTRAINT fk_cliente;
       public          postgres    false    226    3261    233            �           2606    58043    tab_articulo fk_marca    FK CONSTRAINT     �   ALTER TABLE ONLY public.tab_articulo
    ADD CONSTRAINT fk_marca FOREIGN KEY (consec_marca) REFERENCES public.tab_marca(consec_marca);
 ?   ALTER TABLE ONLY public.tab_articulo DROP CONSTRAINT fk_marca;
       public          postgres    false    229    3267    230            �           2606    58066    tab_kardex fk_proveedor    FK CONSTRAINT     �   ALTER TABLE ONLY public.tab_kardex
    ADD CONSTRAINT fk_proveedor FOREIGN KEY (consec_prov) REFERENCES public.tab_proveedor(consec_prov);
 A   ALTER TABLE ONLY public.tab_kardex DROP CONSTRAINT fk_proveedor;
       public          postgres    false    3263    227    231            �           2606    58079    tab_artxprov fk_proveedor    FK CONSTRAINT     �   ALTER TABLE ONLY public.tab_artxprov
    ADD CONSTRAINT fk_proveedor FOREIGN KEY (consec_prov) REFERENCES public.tab_proveedor(consec_prov);
 C   ALTER TABLE ONLY public.tab_artxprov DROP CONSTRAINT fk_proveedor;
       public          postgres    false    3263    227    232            �           2606    58112    tab_detalle_venta fk_venta    FK CONSTRAINT     �   ALTER TABLE ONLY public.tab_detalle_venta
    ADD CONSTRAINT fk_venta FOREIGN KEY (consec_venta) REFERENCES public.tab_encabezado_venta(consec_venta);
 D   ALTER TABLE ONLY public.tab_detalle_venta DROP CONSTRAINT fk_venta;
       public          postgres    false    3277    234    233            �      x������ � �      �   ~   x�3�4� CN##c]s]CC#+C+C=sCCcSΒĜĔ�|NC ��s�2sr�9��9̀&pZr�I 	�u�9�C<���YQ�_\�^�Z������@�������+F��� �*      �   Y   x�3�4�tqw�	�4� CΒĜĔ�|NS �����X��\��B��������T����В� ��$�(�]����������	\	W� 6�      �   K   x�3��H-*J��L�+I,�tt���4202�50�5�P04�25�2��303��4�,�/.I/J-��"�=... ��      �   �   x�}�K
�0 �/��N�{&1�j�.�v� �|Ę�Wz���aHS/� �w��u�&EH�!����z�H荅'�"�ˇ+<bK[f��:s� ��}M�E���:4�I����K=�#T�_bVB�/��(�      �   `   x�3�4�4� CΒĜĔ�|NCN3� �0�4�4��4742�C<��9���u�u-��-�LL�LM�L8�KҋR�9c���+F��� �Z      �   [   x�3�4202�50�5�P04�24�25�32�41��44��042�01�47410�tt��ǧ� ��$�(�]�����������	\W� �aD      �   �   x�3�4202�50�5�P04�20�22�3��4��t�	rtq�4� CΒĜĔ�|NS 20�4�P��7�!�
�KҋR�9c����]���������!n[�6�a����*-�L�L��L8�}<��	��,C2Ͷ=... �2K      �   E   x�3�LI-O�)�tt���4202�50�5�P04�21�21�362����,�/.I/J-��"�=... ��R      �   ~   x�3�4�54��026531�4202�50�5�P04�21�25�30712��tqw�	�46*4��45�LI-O�)qH�M���K���LN��IU02RP6�54�tt���gfA~qIzQj1g�q��qqq pn"      �   |   x�3�44�4�02�02�4202�50�5�P04�21�2��30�42���O.N-�L�H,K��46022�4205��N�Jd�8��&f��%����p::�x���3� ��$�(��3���b���� ��%�     