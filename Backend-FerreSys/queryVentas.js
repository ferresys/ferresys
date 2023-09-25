import dbPool from './conectionDB';

export const consultarVentas = async () => {
  try {
    const ventas = await dbPool.connect();
    const result = await ventas.query(`
    SELECT
        idEncVenta,
        consecFactura,
        consecCotizacion,
        tipoFactura,
        estadoFactura,
        idCli,
        codCli,
        tipoCli,
        CONCAT  nomCli, ' ',  apeCli) AS nombreCompleto,
        telCli,
        emailCli,
        dirCli,
        nomRepLegal,
        nomEmpresa,
        consecDetVenta,
        eanArt,
        cantArt,
        valUnit,
        subTotal,
        iva,
        descuento,
        totalPagar
    FROM
        tabEncabezadoVenta
    INNER JOIN
        tabDetalleVenta`);
 
    // Concatenar las tablas y crear un condicional/Query para por el tipo de consulta

    ventas.release();
    return result.rows;
  } catch (error) {
    console.error('Error al obtener las ventas:', error);
    throw error;
  }
};
