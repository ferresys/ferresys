
//CONFIGURAMOS un Middleware para el manejo de errores en las solicitudes HTTP.
import pool from '../config/connectionDB';

import {ErrorDeBaseDeDatos} from './classError';

export const manejoErrores = (manejarSolicitud) => {
  return async (req, res, next) => { 
    try {
      await manejarSolicitud(req, res, next);//req(la solicitud HTTP) - res(la respuesta HTTP) - next(una función que permite pasar el control al siguiente middleware o ruta)

    } catch (error) {
      console.error('Error en la solicitud:', error);

      if (error instanceof ErrorDeBaseDeDatos) {
        res.status(error.statusCode).json({ error: error.message });
      } else {
      res.status(500).json({ error: 'Error interno del servidor, si el problema persiste contacte a soporte' });
        } 
      };
  };
};



// Función para manejar errores de inserción con funciones plpgsql


export const manejoErroresInsert = async (res, errorNumero = null) => {
  try {
    const response = await pool.query('SELECT validacion($1)', [errorNumero]);

    if (response.rows.length > 0 && response.rows[0].validacion === false) {
      // La función PL/pgSQL validacion.sql ha devuelto un error personalizado
      res.status(400).json({
        message: 'Error de datos incorrectos en la inserción',
        errorNumero,
      });
    } else {
      // La función PL/pgSQL validacion.sql no ha devuelto un error personalizado, se asume un error interno del servidor
      res.status(500).json({
        message: 'Error interno del servidor',
      });
    }
  } catch (error) {
    // Error al llamar a la función PL/pgSQL validacion.sql, se asume un error interno del servidor
    res.status(500).json({
      message: 'Error interno del servidor',
    });
  }
};

/*funcion PLPGSQL
CREATE OR REPLACE FUNCTION validacion(error_numero INT) RETURNS BOOLEAN AS $$
BEGIN
  -- Realiza validaciones aquí
  -- Si se detecta un error, devuelve true
  -- De lo contrario, devuelve false
  IF error_numero = 1 THEN
    -- Error detectado
    RETURN true;
  ELSE
    -- Sin error
    RETURN false;
  END IF;
END;
$$ LANGUAGE plpgsql;*/




 /********************************************************************************************
 *(=>)Las funciones de flecha son una forma más concisa de escribir funciones en comparación * 
 *con las funciones tradicionales(function) de JavaScript.                                             *
 *                                                                                           *                                         *
 ********************************************************************************************/

/*********************************************************************************************
* Un Middleware es un intermediario que se encarga de interceptar y procesar solicitudes HTTP*
* antes de que lleguen a su destino final (como un controlador o una ruta)                   *
* y antes de que se envíen respuestas al cliente.                                            *
*                                                                                            *
* *******************************************************************************************/

/************************************************************************************************
* async y await son características de JavaScript que se utilizan en funciones para trabajar con*
* código asincrónico de manera más legible y manejable. Estas características se introdujeron en*
* ECMAScript 2017 (ES8)                                                                         *
*                                                                                               *
* ***********************************************************************************************/


/*******************************************************************************************************
* async se usa para declarar una función como asincrónica. await se usa dentro de una función declarada*
* como async para esperar la resolución de una promesa.                                                *                                               *
*                                                                                                      *
* ******************************************************************************************************/
 
/************************************************************************
* Ejemplo: Descargar un archivo de Internet es una operación asíncrona. *
* El programa puede seguir funcionando mientras se descarga el archivo, *
* y una vez que se completa, puede manejar el archivo descargado.********
*                                                                       *
*************************************************************************/