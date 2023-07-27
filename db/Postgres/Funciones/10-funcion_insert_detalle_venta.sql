CREATE OR REPLACE FUNCTION insert_detalle_venta(
    zean_art tab_articulo.ean_art%type,
    zcant_art INTEGER,
    zdescuento NUMERIC(10)
) RETURNS VOID AS 

$$
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
$$ 
LANGUAGE plpgsql;

/*
select insert_detalle_venta('00000001',10,0);
select * from tab_detalle_venta;
select * from tab_encabezado_venta;
select * from tab_articulo

*/