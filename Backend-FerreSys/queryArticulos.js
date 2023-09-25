import dbPool from './conectionDB';

export const consultaArticulos = async () => {
  try {
    const articulo = await dbPool.connect();
    const result = await articulo.query(`
      SELECT 
        eanArt,
        nomArt,
        consecMarca,
        consecCateg,
        descArt,
        valUnit,
        porcentaje,
        iva,
        valStock,
        stockMin,
        stockMax,
        valReorden,
        fecVence,
        estado
      FROM
        tabArticulo
      WHERE eanArt='00000001'`);

    articulo.release();
    return result.rows;
  } catch (error) {
    console.error('Error al obtener los artículos:', error);
    throw error;
  }
};