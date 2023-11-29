//IMPORTAMOS LAS FUNCIONES E INSTANCIAS NECESARIAS.
import pool from '../../config/connectionDB';
import { manejoErrores } from '../../middleware/error';
import { ErrorDeBaseDeDatos } from '../../middleware/classError';
import { manejoErroresInsert } from '../../middleware/error';
import QRCode from 'qrcode'; // Importa la biblioteca para generar códigos QR
import { v4 as uuidv4 } from 'uuid';
import { generateQRCode } from './codigoQR'; 

//CONFIGURAMOS LOS CONTROLADORES A TRAVES DE FUNCIONES PARA MANEJAR LAS SOLICITUDES HTTP.

//CONSULTAS GENERALES

const getArticulos = async (req, res) => {
  const response = await pool.query('SELECT * FROM tabArticulo LIMIT 100');
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');
  }
  res.status(200).json(response.rows);
};

//Aplicar el middleware de manejo de errores al controlador
export const getArticulosError = manejoErrores(getArticulos);


// CONSULTAS POR ID 

const getArticuloById = async (req, res) => {
  const id = req.params.id;
  const response = await pool.query('SELECT * FROM tabArticulo WHERE eanArticulo= $1', [id]);
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');//Throw se usa para generar un error intencional en el codigo js.
  }
  res.json(response.rows);
};

export const getArticuloByIdError = manejoErrores(getArticuloById);


//  INSERTAR DATOS 

/*export const insertArticulo = async (req, res) => {
  const { eanArt, nomArt, consecMarca, consecCateg, descArt, porcentaje, iva, stockMin, stockMax, valReorden, fecVence } = req.body;

  try {
     

    const response = await pool.query('SELECT insertArticulo($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)', 
      [eanArt, nomArt, consecMarca, consecCateg, descArt, porcentaje, iva, stockMin, stockMax, valReorden, fecVence]);
    console.log(response);
    res.json({
      message: 'Artículo Registrado con éxito',
      body: {
        Articulo: {eanArt, nomArt, consecMarca, consecCateg, descArt, porcentaje, iva, stockMin, stockMax, valReorden, fecVence},
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: 'Error al registrar Categoria',
    });
  }
};*/


 /*

export const insertArticulo = async (req, res) => {
  const { nomArt, consecMarca, consecCateg, descArt, porcentaje, iva, stockMin, stockMax, valReorden, fecVence } = req.body;

  try {
    // Genera un identificador único para el código QR
    const qrCodeUUID = uuidv4();
    console.log('UUID generado:', qrCodeUUID);
    const qrCodeURL = await generateQRCode(`QR-${qrCodeUUID}`);

    const response = await pool.query('SELECT insertArticulo($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)', 
      [qrCodeURL, nomArt, consecMarca, consecCateg, descArt, porcentaje, iva, stockMin, stockMax, valReorden, fecVence]);

    console.log(response);
    res.json({
      message: 'Artículo Registrado con éxito',
      body: {
        Articulo: { eanArt: qrCodeURL, nomArt, consecMarca, consecCateg, descArt, porcentaje, iva, stockMin, stockMax, valReorden, fecVence },
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: 'Error al registrar Artículo',
    });
  }
};
*/



export const insertArticulo = async (req, res) => {
  const { nomArt, consecMarca, consecCateg, descArt, porcentaje, iva, stockMin, stockMax, valReorden, fecVence } = req.body;

  try {
    // Genera un identificador único para el código QR
    const qrCodeUUID = uuidv4();
    console.log('UUID generado:', qrCodeUUID);

    // Genera la ruta donde se guardará el código QR y devuelve la URL para la base de datos
    const qrCodePath = await generateQRCode(`QR-${qrCodeUUID}`, qrCodeUUID);

    const response = await pool.query('SELECT insertArticulo($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)', 
      [qrCodePath, nomArt, consecMarca, consecCateg, descArt, porcentaje, iva, stockMin, stockMax, valReorden, fecVence]);

    console.log(response);
    res.json({
      message: 'Artículo Registrado con éxito',
      body: {
        Articulo: { eanArt: qrCodePath, nomArt, consecMarca, consecCateg, descArt, porcentaje, iva, stockMin, stockMax, valReorden, fecVence },
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: 'Error al registrar Artículo',
    });
  }
};


//ACTUALIZAR DATOS

export const updateArticulo = async (req, res) => {
  const id = req.params.id;
  const { eanArt, nomArt, consecMarca, consecCateg, descArt, porcentaje, iva, stockMin, stockMax, valReorden, fecVence } = req.body;

  try {
    
    const response = await pool.query(
      'UPDATE tabArticulo SET eanArt = $1, nomArt = $2, consecMarca = $3, consecCateg = $4, descArt = $5, porcentaje = $6, iva = $7, stockMin = $8, stockMax = $9, valReorden = $10, fecVence = $11 WHERE eanArt = $12',
      [eanArt, nomArt, consecMarca, consecCateg, descArt, porcentaje, iva, stockMin, stockMax, valReorden, fecVence, id]
    );

    console.log(response);
    res.send('Artículo Actualizado con éxito');
  } catch (error) {
    console.error('Error al actualizar artículo:', error);
    res.status(500).send('Error al actualizar artículo');
  }
};


//ELIMINAR DATOS

export const deleteArticulo = async (req, res) => {
  const id = req.params.id;

  try {
    const response = await pool.query('DELETE FROM tabArticulo WHERE eanArt = $1', [id]);
    console.log(response);
    res.send('Artículo Eliminado con éxito');
  } catch (error) {
    console.error('Error al eliminar Artículo:', error);
    res.status(500).send('Error al eliminar Artículo');
  }
};



   



