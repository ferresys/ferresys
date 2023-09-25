import dbPool from './conectionDB';

export const consultarClientes = async () => {
  try {
    const cliente = await dbPool.connect();
    const result = await cliente.query(`
      SELECT  
        codCli,
        idCli,
        tipoCli,
        CONCAT (nomCli, '', apeCli) as nombreCompleto,
        telCli,
        emailCli,
        dirCli,
        nomRepLegal,
        nomEmpresa
      FROM
        tabCliente
      WHERE idCli= '1095847854'
      `);

    cliente.release();
    return result.rows;
  } catch (error) {
    console.error('Error al obtener los clientes:', error);
    throw error;
  }
};