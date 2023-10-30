//IMPORTAMOS LAS FUNCIONES E INSTANCIAS NECESARIAS.
import pool from '../../config/connectionDB';
import { manejoErrores } from '../../middleware/error';
import { ErrorDeBaseDeDatos } from '../../middleware/classError';
import { manejoErroresInsert } from '../../middleware/error';


//CONFIGURAMOS LOS CONTROLADORES A TRAVES DE FUNCIONES PARA MANEJAR LAS SOLICITUDES HTTP.

//CONSULTAS GENERALES

const getKardex = async (req, res) => {
  const response = await pool.query('SELECT * FROM tabKardex LIMIT 100');
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');
  }
  res.status(200).json(response.rows);
};


//Aplicar el middleware de manejo de errores al controlador
export const getKardexError = manejoErrores(getKardex);


// CONSULTAS POR ID 

const getKardexById = async (req, res) => {
  const id = req.params.id;
  const response = await pool.query('SELECT * FROM tabKardex WHERE consecKardex = $1', [id]);
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');//Throw se usa para generar un error intencional en el codigo js.
  }
  res.json(response.rows);
};


export const getKardexByIdError = manejoErrores(getKardexById);
