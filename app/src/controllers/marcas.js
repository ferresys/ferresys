//IMPORTAMOS LAS FUNCIONES E INSTANCIAS NECESARIAS.
import pool from '../../config/config-database';
import { manejoErrores } from '../../middleware/error';
import { ErrorDeBaseDeDatos } from '../../middleware/class-error';
import { manejoErroresInsert } from '../../middleware/error';


//CONFIGURAMOS LOS CONTROLADORES A TRAVES DE FUNCIONES PARA MANEJAR LAS SOLICITUDES HTTP.

//CONSULTAS GENERALES

const getMarcas = async (req, res) => {
  const response = await pool.query('SELECT * FROM tabMarca LIMIT 100');
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');
  }
  res.status(200).json(response.rows);
};

//Aplicar el middleware de manejo de errores al controlador
export const getMarcasError = manejoErrores(getMarcas);

// CONSULTAS POR ID 

const getMarcaById = async (req, res) => {
  const id = req.params.id;
  const response = await pool.query('SELECT consecMarca, nomMarca, estado FROM tabMarca WHERE consecMarca = $1', [id]);
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');//Throw se usa para generar un error intencional en el codigo js.
  }
  res.json(response.rows);
};

export const getMarcaByIdError = manejoErrores(getMarcaById);

//  INSERTAR DATOS 

export const insertMarca = async (req, res) => {
  const { nomMarca } = req.body;

  try {
    const response = await pool.query('SELECT insertMarca($1)', [nomMarca]);
    console.log(response);
    res.json({
      message: 'Marca Registrada con éxito',
      body: {
        Marca: { nomMarca },
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: 'Error al registrar la marca',
    });
  }
};

//ACTUALIZAR DATOS

export const updateMarca = async (req, res) => {
  const id = req.params.id;
  const { nomMarca, estado } = req.body;

  try {
    await pool.query(
      'UPDATE tabMarca SET nomMarca = $1, estado = $2 WHERE consecMarca = $3',
      [nomMarca, estado, id]
    );

    res.send('Marca Actualizada con éxito');
  } catch (error) {
    console.error('Error al actualizar marca:', error);
    res.status(500).send('Error al actualizar marca');
  }
};

//ELIMINAR DATOS

export const deleteMarca = async (req, res) => {
  const id = req.params.id;

  try {
    const response = await pool.query('DELETE FROM tabMarca WHERE consecMarca = $1', [id]);
    console.log(response);
    res.send('Marca Eliminada con éxito');
  } catch (error) {
    console.error('Error al eliminar Marca:', error);
    res.status(500).send('Error al eliminar Marca');
  }
};

