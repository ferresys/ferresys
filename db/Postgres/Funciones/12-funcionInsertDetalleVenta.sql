CREATE OR REPLACE FUNCTION insertDetalleVenta(
    zEanArt tabArticulo.eanArt%type,
    zCantArt tabDetalleVenta.cantArt%type
) RETURNS VOID AS 

$$
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
$$ 
LANGUAGE plpgsql;

/*
select insertDetalleVenta('00000001',5);
select insertDetalleVenta('00000002',10);
select * from tabDetalleVenta;
select * from tabEncabezadoVenta;
select * from tabArticulo
select * from tabKardex;

*/