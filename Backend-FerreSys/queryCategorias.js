import dbPool from './conectionDB';

export const consultarCategorias = async () => {
  try {
    const categoria = await dbPool.connect();
    const result = await categoria.query(`
      SELECT  
        consecCateg,
        nomCateg
      FROM
        tabCategoria
      WHERE consecCateg= '1'
      `);

            
    categoria.release();
    return result.rows;
  } catch (error) {
    console.error('Error al obtener las categorias:', error);
    throw error;
  }
};