CREATE OR REPLACE FUNCTION insertDetalleVenta(
    zEanArt tabArticulo.eanArt%type,
    zCantArt tabDetalleVenta.cantArt%type,
    zDescuento tabDetalleVenta.descuento%type
) RETURNS VOID AS

$$
DECLARE
    zValUnit NUMERIC(10);
    zSubTotal NUMERIC(10);
    zIva NUMERIC(10);
    zTotalPagar NUMERIC(10);
    zConsecEncVenta BIGINT;

BEGIN
    -- Obtener el valor unitario (valUnit) del artículo desde la tabla "tabArticulo"
    SELECT valUnit INTO zValUnit FROM tabArticulo WHERE eanArt = zEanArt;

    -- Calcular el subtotal, el valor del IVA y el total a pagar
    zSubtotal := zCantArt * zValUnit;
    SELECT iva INTO zIva FROM tabArticulo WHERE eanArt = zEanArt;
    -- zTotalPagar :=  (zSubtotal * zIva)/100+(zsubtotal)-zdescuento; --REVISAR @Yocser
    zTotalPagar :=  (zSubtotal * zIva)-zdescuento;
    -- zTotalPagar := zSubtotal;
    -- Obtener el consecutivo de venta (consec_venta) desde la tabla "tab_encabezado_venta"
    SELECT consecVenta INTO zConsecVenta FROM tabEncabezadoVenta ORDER BY consecVenta DESC LIMIT 1;

    -- Insertar los datos en la tabla "tabDetalleVenta"
    INSERT INTO tabDetalleVenta (eanArt, cantArt, valUnit, subTotal, iva, descuento, totalPagar, consecEncVenta )
    VALUES (zEanArt, zCantArt, zValUnit, zSubTotal, zIva, zDescuento, zTotalPagar, zConsecEncVenta);
    RETURN;
END;
$$ 
LANGUAGE plpgsql;


