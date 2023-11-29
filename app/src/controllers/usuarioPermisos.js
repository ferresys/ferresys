//IMPORTAMOS LAS FUNCIONES E INSTANCIAS NECESARIAS.
import pool from '../../config/connectionDB';
import { manejoErrores } from '../../middleware/error';
import { ErrorDeBaseDeDatos } from '../../middleware/classError';
import { manejoErroresInsert } from '../../middleware/error';


//CONFIGURAMOS LOS CONTROLADORES A TRAVES DE FUNCIONES PARA MANEJAR LAS SOLICITUDES HTTP.

//CONSULTAS GENERALES

const getUsuarioPermisos = async (req, res) => {
  const response = await pool.query('SELECT * FROM tabUsuarioPermiso LIMIT 100');
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');
  }
  res.status(200).json(response.rows);
};

//Aplicar el middleware de manejo de errores al controlador
export const getUsuarioPermisosError = manejoErrores(getUsuarioPermisos);


// CONSULTAS POR ID 

const getUsuarioPermisoById = async (req, res) => {
  const id = req.params.id;
  const response = await pool.query('SELECT * FROM tabUsuarioPermiso WHERE consecUsuarioPermiso = $1', [id]);
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');//Throw se usa para generar un error intencional en el codigo js.
  }
  res.json(response.rows);
};

export const getUsuarioPermisoByIdError = manejoErrores(getUsuarioPermisoById);


//  INSERTAR DATOS 

export const insertUsuarioPermiso = async (req, res) => {
  const { idUsuario, consecPermiso } = req.body;

  try {
    const response = await pool.query('SELECT asignarPermisoUsuario($1, $2)', 
      [idUsuario, consecPermiso]);
    console.log(response);
    res.json({
      message: 'Permisos por usuario Registrado con éxito',
      body: {
        usuarioPermiso: {idUsuario, consecPermiso},
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: 'Error al registrar Permisos por Usuario',
    });
  }
};


//ACTUALIZAR DATOS

export const updateUsuarioPermiso = async (req, res) => {
  const id = req.params.id;
  const { idUsuario, consecPermiso } = req.body;

  try {
    
    const response = await pool.query(
      'UPDATE tabUsuarioPermiso SET idUsuario = $1, consecPermiso = $2 WHERE consecUsuarioPermiso = $3',
      [idUsuario, consecPermiso, id]
    );

    console.log(response);
    res.send('Permisos por Usuario Actualizado con éxito');
  } catch (error) {
    console.error('Error al actualizar permisos por usuario:', error);
    res.status(500).send('Error al actualizar permisos por usuario');
  }
};


//ELIMINAR DATOS

export const deleteUsuarioPermiso = async (req, res) => {
  const id = req.params.id;

  try {
    const response = await pool.query('DELETE FROM tabUsuarioPermiso WHERE consecUsuarioPermiso = $1', [id]);
    console.log(response);
    res.send('Permisos por Usuario Eliminado con éxito');
  } catch (error) {
    console.error('Error al eliminar Permisos por Usuario:', error);
    res.status(500).send('Error al eliminar Permisos por Usuario');
  }
};