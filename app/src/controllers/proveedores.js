//IMPORTAMOS LAS FUNCIONES E INSTANCIAS NECESARIAS.
import pool from '../../config/connectionDB';
import { manejoErrores } from '../../middleware/error';
import { ErrorDeBaseDeDatos } from '../../middleware/classError';
import { manejoErroresInsert } from '../../middleware/error';
import { validateEmail } from '../../middleware/email';


//CONFIGURAMOS LOS CONTROLADORES A TRAVES DE FUNCIONES PARA MANEJAR LAS SOLICITUDES HTTP.

//CONSULTAS GENERALES

const getProveedores = async (req, res) => {
  const response = await pool.query('SELECT * FROM tabProveedor LIMIT 100');
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');
  }
  res.status(200).json(response.rows);
};


//Aplicar el middleware de manejo de errores al controlador

export const getProveedoresError = manejoErrores(getProveedores);


// CONSULTAS POR ID 

const getProveedorById = async (req, res) => {
  const id = req.params.id;
  const response = await pool.query('SELECT * FROM tabProveedor WHERE idProv = $1', [id]);
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');//Throw se usa para generar un error intencional en el codigo js.
  }
  res.json(response.rows);
};

export const getProveedorByIdError = manejoErrores(getProveedorById);


//  INSERTAR DATOS 

export const insertProveedor = async (req, res) => {
  const { idProv, nomProv, telProv, emailProv, dirProv } = req.body;

  try {
    if (!validateEmail(emailProv)) {
      throw new Error('Invalid email format');
    }
  } catch (error) {
    res.status(400).json({ message: error.message });
    return;
  }

  const response = await pool.query('SELECT insertProveedor($1, $2, $3, $4, $5)', 
    [idProv, nomProv, telProv, emailProv, dirProv ]);

  console.log(response);

  if (response.error) {

    // Manejo de errores 500 (Error interno del servidor)
    manejoErroresInsert(res);
  } else {
    res.json({
      message: 'Proveedor Registrado con éxito',
      body: {
        Proveedor: { idProv, nomProv, telProv, emailProv, dirProv },
      },
    });
  }
};


//ACTUALIZAR DATOS

export const updateProveedor = async (req, res) => {
  const id = req.params.id;
  const { idProv, nomProv, telProv, emailProv, dirProv } = req.body;

  try {
    const response = await pool.query(
      'UPDATE tabProveedor SET idProv = $1, nomProv = $2, telProv = $3, emailProv = $4, dirProv = $5 WHERE idProv = $6',
      [idProv, nomProv, telProv, emailProv, dirProv, id]
    );

    console.log(response);
    res.send('Proveedor Actualizado con éxito');
  } catch (error) {
    console.error('Error al actualizar datos del Proveedor:', error);
    res.status(500).send('Error al actualizar datos del Proveedor');
  }
};


//ELIMINAR DATOS

export const deleteProveedor = async (req, res) => {
  const id = req.params.id;

  try {
    const response = await pool.query('DELETE FROM tabProveedor WHERE idProv = $1', [id]);
    console.log(response);
    res.send('Proveedor Eliminado con éxito');
  } catch (error) {
    console.error('Error al eliminar Proveedor:', error);
    res.status(500).send('Error al eliminar Proveedor');
  }
};
