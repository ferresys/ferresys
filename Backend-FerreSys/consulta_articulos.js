
//FUNCIONES DE CONSULTAS


import dbPool from './conexion_db';


export const consultar_articulos = async () => {
  try {
    const articulo = await dbPool.connect();
    const result = await articulo.query("SELECT consec_art, ean_art, fec_reg, nom_art, consec_marca,consec_categ, descrip_art, unid_med, val_unit, iva, val_stock, stock_min, stock_max, val_reorden, fec_vence, estado FROM tab_articulo WHERE ean_art='00000001'");
    articulo.release();
    return result.rows;
  } catch (error) {
    console.error('Error al obtener los artículos:', error);
    throw error;
  }
};

//export default consultar_articulos;
//export function consultar_articulos;








  