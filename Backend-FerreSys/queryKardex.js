import dbPool from './conectionDB';

export const consultaKardex = async () => {
  try {
    const kardex = await dbPool.connect();
    const result = await kardex.query(`
      SELECT 
        consecKardex,
        consecReciboMcia,
        consecDetVenta,
        tipoMov,
        eanArt,
        cantArt,
        valProm,
      FROM
        tabKardex
      WHERE consecKardex='1'`);

    kardex.release();
    return result.rows;
  } catch (error) {
    console.error('Error al obtener el kardex:', error);
    throw error;
  }
}; 