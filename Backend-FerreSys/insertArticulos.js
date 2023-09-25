import { dbPool } from './conectionDB';

export const insertArticulo = async (data) => {
  try {
    const articulo = await dbPool.connect();

    // Desestructuramos el array-lista
    const [eanArt, nomArt, consecMarca, consecCateg, descArt, valUnit, iva, valStock, stockMin, stockMax, valReorden, fecVence, estado] = data;

    // Llamar a la función insertArticulo con los parámetros correspondientes
  await articulo.query('SELECT insertArticulo($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13)', [
      eanArt,
      nomArt,
      consecMarca,
      consecCateg,
      descArt,
      valUnit,
      iva,
      valStock,
      stockMin,
      stockMax,
      valReorden,
      fecVence,
      estado
  ]);

    articulo.release();
    console.log('Registro exitoso');
  } catch (error) {
    console.error('Error al insertar el artículo:', error);
    throw error;
  }
};