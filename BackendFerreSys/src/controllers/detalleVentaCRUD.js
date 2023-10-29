//IMPORTAMOS LAS FUNCIONES E INSTANCIAS NECESARIAS.
import pool from '../../config/connectionDB';
import { manejoErrores } from '../../middleware/error';
import { ErrorDeBaseDeDatos } from '../../middleware/classError';
import { manejoErroresInsert } from '../../middleware/error';


//CONFIGURAMOS LOS CONTROLADORES A TRAVES DE FUNCIONES PARA MANEJAR LAS SOLICITUDES HTTP.



//  INSERTAR DATOS 

export const insertDetalleVenta = async (req, res) => {
  const { eanArt, cantArt, descuento } = req.body;

  try {
    const response = await pool.query('SELECT insertDetalleVenta($1, $2, $3)', 
      [eanArt, cantArt, descuento]);
    console.log(response);
    res.json({
      message: 'Detalle venta Registrado con éxito',
      body: {
        DetalleVenta: {eanArt, cantArt, descuento },
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: 'Error al registrar Detalle de Venta',
    });
  }
};
