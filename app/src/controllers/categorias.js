//IMPORTAMOS LAS FUNCIONES E INSTANCIAS NECESARIAS.
import pool from '../../config/config-database';
import { manejoErrores } from '../../middleware/error';
import { ErrorDeBaseDeDatos } from '../../middleware/class-error';
import { manejoErroresInsert } from '../../middleware/error';

//CONFIGURAMOS LOS CONTROLADORES A TRAVES DE FUNCIONES PARA MANEJAR LAS SOLICITUDES HTTP.

//CONSULTAS GENERALES

const getCategorias = async (req, res) => {
  const response = await pool.query('SELECT * FROM tabCategoria LIMIT 100');
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');
  }
  res.status(200).json(response.rows);
};

//Aplicar el middleware de manejo de errores al controlador
export const getCategoriasError = manejoErrores(getCategorias);

// CONSULTAS POR ID 

const getCategoriaById = async (req, res) => {
  const id = req.params.id;
  const response = await pool.query('SELECT * FROM tabCategoria WHERE consecCategoria = $1', [id]);
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');//Throw se usa para generar un error intencional en el codigo js.
  }
  res.json(response.rows);
};

export const getCategoriaByIdError = manejoErrores(getCategoriaById);

//  INSERTAR DATOS 

export const insertCategoria = async (req, res) => {
  const { nomCateg } = req.body;

  try {
    const response = await pool.query('SELECT insertCategoria($1)', [nomCateg]);
    console.log(response);
    res.json({
      message: 'Categoria Registrada con éxito',
      body: {
        Categoria: {nomCateg},
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: 'Error al registrar Categoria',
    });
  }
};

//ACTUALIZAR DATOS

export const updateCategoria = async (req, res) => {
  const id = req.params.id;
  const { nomCateg } = req.body;

  try {
   
    const response = await pool.query(
      'UPDATE tabCategoria SET nomCateg = $1 WHERE consecCateg = $2',
      [nomCateg, id]
    );

    console.log(response);
    res.send('Categoría Actualizada con éxito');
  } catch (error) {
    console.error('Error al actualizar categoría:', error);
    res.status(500).send('Error al actualizar categoría');
  }
};

//ELIMINAR DATOS

export const deleteCategoria = async (req, res) => {
  const id = req.params.id;

  try {
    const response = await pool.query('DELETE FROM tabCategoria WHERE consecCateg = $1', [id]);
    console.log(response);
    res.send('Categoría Eliminada con éxito');
  } catch (error) {
    console.error('Error al eliminar Categoría:', error);
    res.status(500).send('Error al eliminar Categoría');
  }
};