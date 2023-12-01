//IMPORTAMOS LAS FUNCIONES E INSTANCIAS NECESARIAS.
import pool from '../../config/config-database';
import { manejoErrores } from '../../middleware/error';
import { ErrorDeBaseDeDatos } from '../../middleware/class-error';
import { manejoErroresInsert } from '../../middleware/error';
import { validateEmail } from '../../middleware/email';

//CONFIGURAMOS LOS CONTROLADORES A TRAVES DE FUNCIONES PARA MANEJAR LAS SOLICITUDES HTTP.

//CONSULTAS GENERALES

const getClientes = async (req, res) => { //la funcion se llama getClientes.y contiene parametros (req, res).
  //throw new Error('Este es un error de prueba'); //con esta linea podemos probar que el (error 500) funciona.
  const response = await pool.query('SELECT * FROM tabCliente LIMIT 100');
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');//Throw se usa para generar un error intencional en el codigo js.
  }
  res.status(200).json(response.rows);
};

//Aplicar el middleware de manejo de errores al controlador
export const getClientesError = manejoErrores(getClientes);

// CONSULTAS POR ID 

const getClienteById = async (req, res) => {
  const id = req.params.id;
  const response = await pool.query('SELECT * FROM tabCliente WHERE idCli = $1', [id]);
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');//Throw se usa para generar un error intencional en el codigo js.
  }
  res.json(response.rows);
};

export const getClienteByIdError = manejoErrores(getClienteById);

//  INSERTAR DATOS 

export const insertCliente = async (req, res) => {
  const { idCli, tipoCli, nomCli, apeCli, nomRepLegal, nomEmpresa, telCli, emailCli, dirCli } = req.body;

  try {
    if (!validateEmail(emailCli)) {
      throw new Error('Invalid email format');
    }
  } catch (error) {
    res.status(400).json({ message: error.message });
    return;
  }
  
  const response = await pool.query('SELECT insertCliente($1, $2, $3, $4, $5, $6, $7, $8, $9)', 
    [idCli, tipoCli, nomCli, apeCli, nomRepLegal, nomEmpresa, telCli, emailCli, dirCli ]);

  console.log(response);
    res.json({
      message: 'Cliente Registrado con éxito',
      body: {
        Cliente: { idCli, tipoCli, nomCli, apeCli, nomRepLegal, nomEmpresa, telCli, emailCli, dirCli },
      },
    });
};

//ACTUALIZAR DATOS

export const updateCliente = async (req, res) => {
  const id = req.params.id;
  const { idCli, tipoCli, nomCli, apeCli, nomRepLegal, nomEmpresa, telCli, emailCli, dirCli } = req.body;

  try {
    const response = await pool.query(
      'UPDATE tabCliente SET idCli = $1, tipoCli = $2, nomCli = $3, apeCli = $4, nomRepLegal = $5, nomEmpresa = $6, telCli = $7, emailCli = $8, dirCli = $9 WHERE idCli = $10',
      [idCli, tipoCli, nomCli, apeCli, nomRepLegal, nomEmpresa, telCli, emailCli, dirCli, id]
    );

    console.log(response);
    res.send('Cliente Actualizado con éxito');
  } catch (error) {
    console.error('Error al actualizar datos del Cliente:', error);
    res.status(500).send('Error al actualizar datos del Cliente');
  }
};

//ELIMINAR DATOS

export const deleteCliente = async (req, res) => {
  const id = req.params.id;

  try {
    const response = await pool.query('DELETE FROM tabCliente WHERE idCli = $1', [id]);
    console.log(response);
    res.send('Cliente Eliminado con éxito');
  } catch (error) {
    console.error('Error al eliminar Cliente:', error);
    res.status(500).send('Error al eliminar Cliente');
  }
};
