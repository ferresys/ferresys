import dbPool from './conectionDB';

export const consultarMarcas = async () => {
  try {
    const marca = await dbPool.connect();
    const result = await marca.query(`
      SELECT  
        consecMarca,
        nomMarca
      FROM
        tabMarca
      WHERE consecMarca= '1'
      `);

    marca.release();
    return result.rows;
  } catch (error) {
    console.error('Error al obtener las marcas:', error);
    throw error;
  }
};