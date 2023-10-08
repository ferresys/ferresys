
// CONFIGURAMOS LA CONEXION A LA BASE DE DATOS A TRAVES DE POOL.

import { Pool } from 'pg';
import dotenv from 'dotenv';


dotenv.config();

const pool = new Pool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME,
  port: process.env.DB_PORT,
});

export default pool;

/***************************************************************************************
*                                                                                      *
* Pool es un grupo de conexiones que se utiliza para administrar conexiones eficientes *
* a la base de datos PostgreSQL en Node.js.                                            *
*                                                                                      *                                                 
* *************************************************************************************/


/***************************************************************************************
*                                                                                      *
* La función principal de dotenv es permitir que configures variables de entorno como  *
* contraseñas,claves de API u otros valores sensibles fuera de tu código fuente y los  *
* cargues en tu aplicación de manera segura a traves de UN archivo .dotenv             *
*                                                                                      *                                            
* *************************************************************************************/