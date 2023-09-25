import dbPool from './conectionDB';

export const consultarReciboMercancia = async () => {
  try {
    const reciboMercancia = await dbPool.connect();
    const result = await reciboMercancia.query(`
        SELECT
            consecReciboMcia,
            eanArt,
            cantArt,
            valCompra,
            valTotal,
            idProv,
            consecMarca,
            observacion
        FROM 
            tabReciboMercancia
        WHERE consecReciboMcia ='1'`);

    reciboMercancia.release();
    return result.rows;
  } catch (error) {
    console.error('Error al obtener las entradas:', error);
    throw error;
  }
};