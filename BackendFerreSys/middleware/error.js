
//CONFIGURAMOS un Middleware para el manejo de errores en las solicitudes HTTP.

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
      res.status(500).json({ error: 'Error interno del servidor' });
    }
  };
};
};





/*********************************************************************************************
* Un Middleware es un intermediario que se encarga de interceptar y procesar solicitudes HTTP*
* antes de que lleguen a su destino final (como un controlador o una ruta)                   *
* y antes de que se envíen respuestas al cliente.                                            *
*                                                                                            *
* *******************************************************************************************/

