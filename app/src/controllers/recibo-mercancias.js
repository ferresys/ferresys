//IMPORTAMOS LAS FUNCIONES E INSTANCIAS NECESARIAS.
import pool from '../../config/config-database';
import { manejoErrores } from '../../middleware/error';
import { ErrorDeBaseDeDatos } from '../../middleware/class-error';
import { manejoErroresInsert } from '../../middleware/error';

//CONFIGURAMOS LOS CONTROLADORES A TRAVES DE FUNCIONES PARA MANEJAR LAS SOLICITUDES HTTP.

//CONSULTAS GENERALES

const getReciboMercancias = async (req, res) => {
  const response = await pool.query('SELECT * FROM tabReciboMercancia LIMIT 100');
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');
  }
  res.status(200).json(response.rows);
};

//Aplicar el middleware de manejo de errores al controlador
export const getReciboMercanciasError = manejoErrores(getReciboMercancias);

// CONSULTAS POR ID 

const getReciboMercanciaById = async (req, res) => {
  const id = req.params.id;
  const response = await pool.query('SELECT * FROM tabReciboMercancia WHERE consecReciboMcia = $1', [id]);
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');//Throw se usa para generar un error intencional en el codigo js.
  }
  res.json(response.rows);
};

export const getReciboMercanciaByIdError = manejoErrores(getReciboMercanciaById);

//  INSERTAR DATOS 

export const insertReciboMercancia = async (req, res) => {
  const { eanArt, cantArt, valCompra, idProv, consecMarca, observacion } = req.body;

  try {
    const response = await pool.query('SELECT insertReciboMercancia($1, $2, $3, $4, $5, $6)', 
      [eanArt, cantArt, valCompra, idProv,  consecMarca, observacion]);
    console.log(response);
    res.json({
      message: 'Entrada Registrada con éxito',
      body: {
        ReciboMercancia: {eanArt, cantArt, valCompra, idProv,  consecMarca, observacion},
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: 'Error al registrar Entrada',
    });
  }
};