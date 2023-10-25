// const { Client } = require('pg');
// require('dotenv').config(); // Carga las variables de entorno desde un archivo .env

// función para validar el inicio de sesión
async function validarInicioSesion(idUsuario, password) {
  try {
    const query = {
      text: 'SELECT * FROM validacionLoginUsuario($1, $2)',
      values: [idUsuario, password],
    };
    const resultado = await client.query(query);
    return resultado.rows[0].validacionloginusuario;
  } catch (error) {
    console.error('Error al validar el inicio de sesión:', error);
    throw error;
  }
}

// Llama a la función para validar el inicio de sesión
const idUsuario = '1005330671';
const password = 'abcd1234';

validarInicioSesion(idUsuario, password)
  .then(resultado => {
    if (resultado) {
      console.log('Inicio de sesión exitoso');
    } else {
      console.log('Credenciales de inicio de sesión incorrectas');
    }
  })
  .catch(error => {
    console.error('Error:', error);
  });