//IMPORTAMOS LAS FUNCIONES E INSTANCIAS NECESARIAS.
import pool from '../../config/connectionDB';
import { manejoErrores } from '../../middleware/error';
import { ErrorDeBaseDeDatos } from '../../middleware/classError';
import { manejoErroresInsert } from '../../middleware/error';


//CONFIGURAMOS LOS CONTROLADORES A TRAVES DE FUNCIONES PARA MANEJAR LAS SOLICITUDES HTTP.

//CONSULTAS GENERALES

const getPermisos = async (req, res) => {
  const response = await pool.query('SELECT * FROM tabPermiso LIMIT 100');
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');
  }
  res.status(200).json(response.rows);
};


//Aplicar el middleware de manejo de errores al controlador
export const getPermisosError = manejoErrores(getPermisos);


// CONSULTAS POR ID 

const getPermisoById = async (req, res) => {
  const id = req.params.id;
  const response = await pool.query('SELECT * FROM tabPermiso WHERE consecPermiso = $1', [id]);
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');//Throw se usa para generar un error intencional en el codigo js.
  }
  res.json(response.rows);
};

export const getPermisoByIdError = manejoErrores(getPermisoById);


//  INSERTAR DATOS 

export const insertPermiso = async (req, res) => {
  const { nomPermiso, descPermiso } = req.body;

  try {
    const response = await pool.query('SELECT insertPermiso($1, $2)', 
      [nomPermiso, descPermiso]);
    console.log(response);
    res.json({
      message: 'Permiso Registrado con éxito',
      body: {
        Permiso: {nomPermiso, descPermiso},
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: 'Error al registrar Permiso',
    });
  }
};


//ACTUALIZAR DATOS

export const updatePermiso = async (req, res) => {
  const id = req.params.id;
  const { nomPermiso, descPermiso } = req.body;

  try {
    
    const response = await pool.query(
      'UPDATE tabPermiso SET nomPermiso = $1, descPermiso = $2 WHERE consecPermiso = $3',
      [nomPermiso, descPermiso, id]
    );

    console.log(response);
    res.send('Permiso Actualizado con éxito');
  } catch (error) {
    console.error('Error al actualizar permiso:', error);
    res.status(500).send('Error al actualizar permiso');
  }
};


//ELIMINAR DATOS

export const deletePermiso = async (req, res) => {
  const id = req.params.id;

  try {
    const response = await pool.query('DELETE FROM tabPermiso WHERE consecPermiso = $1', [id]);
    console.log(response);
    res.send('Permiso Eliminado con éxito');
  } catch (error) {
    console.error('Error al eliminar Permiso:', error);
    res.status(500).send('Error al eliminar Permiso');
  }
};