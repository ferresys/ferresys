import dbPool from './conectionDB';

export const consultarProveedores = async () => {
  try {
    const proveedor = await dbPool.connect();
    const result = await proveedor.query(`
      SELECT
        codProv,
        idProv,
        nomProv,
        telProv,
        emailProv,
        dirProv,
        estado
      FROM 
        tabProveedor
      WHERE idProv ='0-1098235641'`);

    proveedor.release();
    return result.rows;
  } catch (error) {
    console.error('Error al obtener los proveedores:', error);
    throw error;
  }
};