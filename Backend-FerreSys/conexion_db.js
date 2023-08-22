
//CONEXION BASE DE DATOS

import dotenv from 'dotenv'; //Estamos trabajando con ES6 
import pg from 'pg';

dotenv.config();

const { Pool } = pg; //const lo usamos para declarar variables que no cambiaran su valor. y  pool es el nombre que viene por defecto de la libreria para la conexion DB.
const dbPool = new Pool({   //incluye los datos privados como contraseña usuario host de nuestra base de datos y estan incluidas en el archivo .env
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME,
});


export default dbPool; // de esta manera exportamos la constante o funcion para que pueda ser importada desde otro archivo











