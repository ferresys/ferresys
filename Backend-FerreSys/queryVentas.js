/*Comentarios
Concatenar las tablas y crear un condicional/Query para por el tipo de consulta
*/

import dbPool from './conectionDB';

export const consultarVentas = async () => {
  try {
    const ventas = await dbPool.connect();
    const result = await ventas.query(`
    SELECT
        ev.idEncVenta,
        ev.consecFactura,
        ev.consecCotizacion,
        ev.tipoFactura,
        ev.estadoFactura,
        ev.idCli,
        tc.codCli,
        tc.tipoCli,
        CONCAT(tc.nomCli, ' ', tc.apeCli) AS nombreCompleto,
        tc.telCli,
        tc.emailCli,
        tc.dirCli,
        tc.nomRepLegal,
        tc.nomEmpresa,
        tdv.consecDetVenta,
        tdv.eanArt,
        tdv.cantArt,
        tdv.valUnit,
        tdv.subTotal,
        tdv.iva,
        tdv.descuento,
        tdv.totalPagar
    FROM
        tabEncabezadoVenta
    INNER JOIN
        tabCliente AS tc
    ON
        ev.idCli = tc.idCli
    LEFT JOIN
        tabDetalleVenta AS tdv
    ON
        ev.idEncVenta = tdv.idEncVenta;`);

    ventas.release();
    return result.rows;
  } catch (error) {
    console.error('Error al obtener las ventas:', error);
    throw error;
  }
};
