import pool from '../config/connectionDB';
import { ErrorDeBaseDeDatos } from './classError';

const validateEmail = (email) => {
  // Regex para validar el formato del correo
  const emailRegex = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

  if (!emailRegex.test(email)) {
    throw new ErrorDeBaseDeDatos('El formato del correo electrónico no es válido.');
  }
};

export { validateEmail };

try {
  validateEmail('abadacabra123@example.com');
  validateEmail('chanfle@example');
} catch (error) {
  console.error('Error:', error.message);
}


// como hago para llamar esta validacion de email en distintas 
// funciones antes de realizar su funcion 