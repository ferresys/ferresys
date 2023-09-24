--SELECT insertDetalleVenta ('00000002', 10, 0);
--select * FROM tabKardex;
--select * from tabArticulo;
--select * from tabDetalleVenta;
--delete from tabDetalleVenta;
--delete from tabKardex;
--delete from tabEncabezadoVenta;


CREATE OR REPLACE FUNCTION insertDetalleVenta(
    zEanArt tabArticulo.eanArt%type,
    zCantArt tabDetalleVenta.cantArt%type,
    zDescuento tabDetalleVenta.descuento%type
) RETURNS VOID AS

$$
DECLARE
    zValUnit tabArticulo.valUnit%type;
    zSubTotal tabDetalleVenta.subTotal%type;
    zIva tabArticulo.iva%type;
    zTotalPagar tabDetalleVenta.totalPagar%type;
    --zConsecFactura tabDetalleVenta.consecFactura%type;
    --zConsecCotizacion tabDetalleVenta.consecCotizacion%type;
	zConsecFactura BIGINT;
	zConsecCotizacion BIGINT;
BEGIN
    -- Obtener el valor unitario (valUnit) del artículo desde la tabla "tabArticulo"
    SELECT valUnit INTO zValUnit FROM tabArticulo WHERE eanArt = zEanArt;
    SELECT iva INTO zIva FROM tabArticulo WHERE eanArt = zEanArt;
    
	-- Calcular el subtotal y el total a pagar
    zSubtotal := zCantArt * zValUnit;
    zTotalPagar := (zSubtotal * zIva)-zdescuento;
   
    -- Obtener el consecutivo de venta (consecFactura) desde la tabla "tabEncabezadoVenta"
    SELECT consecFactura INTO zConsecFactura FROM tabEncabezadoVenta ORDER BY consecFactura DESC LIMIT 1;
	SELECT consecCotizacion INTO zConsecCotizacion FROM tabEncabezadoVenta ORDER BY consecCotizacion DESC LIMIT 1;
	
    
    -- Insertar los datos en la tabla "tabDetalleVenta"
	
    INSERT INTO tabDetalleVenta (eanArt, cantArt, valUnit, subTotal, iva, descuento, totalPagar, consecFactura, consecCotizacion )
    VALUES (zEanArt, zCantArt, zValUnit, zSubTotal, zIva, zDescuento, zTotalPagar, zConsecFactura, zConsecCotizacion);
   
	RETURN;
	
END;
$$ 
LANGUAGE plpgsql;


