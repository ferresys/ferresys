import pool from '../config/connectionDB';
import { ErrorDeBaseDeDatos } from './classError';

const validateEmail = (email) => {
  // Regex para validar el formato del correo
  const emailRegex = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

  if (!emailRegex.test(email)) {
    throw new ErrorDeBaseDeDatos('El formato del correo electrónico está mal mi negro');
  }
};

export { validateEmail };
export default pool;

// crear una funcion para utilizarla en proveeddor, cliente y usuario ()
// y que valide el email antes de insertar el dato en la base de datos
// Path: BackendFerreSys/middleware/validateEmail.js