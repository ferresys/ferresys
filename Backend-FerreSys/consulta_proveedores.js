import dbPool from './conexion_db';


export const consultar_proveedores = async () => {
  try {
    const proveedor = await dbPool.connect();
    const result = await proveedor.query("SELECT consec_prov, nit_prov, fec_reg, nom_prov, tel_prov, email_prov, dir_prov, estado FROM tab_proveedor WHERE nit_prov='0-1098235641'");
    proveedor.release();
    return result.rows;
  } catch (error) {
    console.error('Error al obtener los artículos:', error);
    throw error;
  }
};
