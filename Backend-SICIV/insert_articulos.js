

import { dbPool } from './conexion_db';

export const insertar_articulo = async (datos) => {
  try {
    const articulo = await dbPool.connect();

    // Desestructuramos el array-lista
    const [ean_art, nom_art, consec_marca, consec_categ, descrip_art, unid_med, iva, fec_vence] = datos;

    // ejecutamos la funcion del procedimiento almacenado sql
    await articulo.query('SELECT insert_articulo($1, $2, $3, $4, $5, $6, $7, $8)', [
      ean_art,
      nom_art,
      consec_marca,
      consec_categ,
      descrip_art,
      unid_med,
      iva,
      fec_vence,
    ]);

    articulo.release();
    console.log('Registro exitoso');
  } catch (error) {
    console.error('Error al insertar el artículo:', error);
    throw error;
  }
};

