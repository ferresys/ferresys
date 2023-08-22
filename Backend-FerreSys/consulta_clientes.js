

import dbPool from './conexion_db';


export const consultar_clientes = async () => {
  try {
    const cliente = await dbPool.connect();
    const result = await cliente.query("SELECT tcn.idCli,tc.fecReg,tcn.nomCli, tcn.apeCli,tc.tipoCli,tc.telCli,tc.emailCli,tc.dirCli,tc.consecCli FROM tabCliente tc LEFT JOIN tabClienteNatural tcn ON tc.consecCli = tcn.consecCli WHERE tc.tipoCli = 'Natural'"); //id_cli='1095121846'
    cliente.release();
    return result.rows;
  } catch (error) {
    console.error('Error al obtener los clientes:', error);
    throw error;
  }
};
