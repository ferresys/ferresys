//IMPORTAMOS LAS FUNCIONES E INSTANCIAS NECESARIAS.
import pool from '../../config/connectionDB';
import { manejoErrores } from '../../middleware/error';
import { ErrorDeBaseDeDatos } from '../../middleware/classError';
import { manejoErroresInsert } from '../../middleware/error';


//CONFIGURAMOS LOS CONTROLADORES A TRAVES DE FUNCIONES PARA MANEJAR LAS SOLICITUDES HTTP.

//CONSULTAS GENERALES


//  INSERTAR DATOS 

export const insertEncabezadoVenta = async (req, res) => {
  const { tipoFactura, idCli, ciudad } = req.body;

  try {
    const response = await pool.query('SELECT insertEncVenta($1, $2, $3)', 
      [tipoFactura, idCli, ciudad]);
    console.log(response);
    res.json({
      message: 'Encabezado de Venta Registrado con éxito',
      body: {
        EncabezadoVenta: {tipoFactura, idCli, ciudad},
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: 'Error al registrar Encabezado de Venta',
    });
  }
};
