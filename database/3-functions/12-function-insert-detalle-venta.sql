
--SELECT insertDetalleVenta ('1', 10, 0);

--Función para insertar Detalle de Venta

CREATE OR REPLACE FUNCTION insertDetalleVenta(
    zEanArt tabArticulo.eanArt%type,
    zCantArt tabDetalleVenta.cantArt%type,
    zDescuento tabDetalleVenta.descuento%type
) RETURNS BIGINT AS

$$
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
$$ 
LANGUAGE plpgsql;



