

import dbPool from './conexion_db';


export const consultar_clientes = async () => {
  try {
    const cliente = await dbPool.connect();
    const result = await cliente.query("SELECT consec_cli, fec_reg, tipo_cli, id_cli, nom_cli, ape_cli, nom_empr, tel_cli, email_cli, dir_cli FROM tab_cliente WHERE consec_cli=2"); //id_cli='1095121846'
    cliente.release();
    return result.rows;
  } catch (error) {
    console.error('Error al obtener los clientes:', error);
    throw error;
  }
};
