//CREACION DEL SERVIDOR

//import LIBRARIES
import express from 'express'; //(Crear el servidor)
import dotenv from 'dotenv'; //(.env)
import { dbPool } from './conectionDB';

//import AUTHENTICATE function
import { validarInicioSesion } from './authenticateUser'; // Valor sin leer en el cuerpo del código

//import INSERT
import { insertArticulo } from './insertArticulos';

//import QUERIES
import { consultarClientes } from './queryClientes';
import { consultarProveedores } from './queryProveedores';
import { consultarCategorias } from './queryCategorias'; // Valor sin leer en el cuerpo del código
import { consultarMarcas } from './queryMarcas'; // Valor sin leer en el cuerpo del código
import { consultaArticulos } from './queryArticulos';
import { consultarReciboMercancia } from './queryReciboMercancia'; // Valor sin leer en el cuerpo del código
// ventas
import { consultarVentas } from './queryVentas'; // Valor sin leer en el cuerpo del código
import { consultaKardex } from './queryKardex';
import cors from 'cors';  // <-- Asegúrate de importar cors

//Cargar variables de entorno .env

dotenv.config();

//Crear instancia app y variable PORT
const app = express();
const PORT = process.env.PORT || 3000; // Cambiado de 3000 a 3001

app.use(express.json());

// Habilitar CORS para todos los orígenes
app.use(cors());

// Iniciar el servidor
app.listen(PORT, () => {
  console.log(`Servidor escuchando en http://localhost:${PORT}`);
});

app.post('/yocser', async (req, res) => {
  try {
    const resultado = await insertArticulo([
      '00000003',
      'Brocha',
      1,
      1,
      'buen pintor',
      'N/A',
      19,
      '2023-11-21',
    ]);
    res.json({ mensaje: 'Artículo insertado correctamente', resultado });
  } catch (error) {
    console.error('Error al insertar el artículo:', error);
    res.status(500).json({ error: 'Error al insertar el artículo1' });
  }
});

//Crear ruta "/articulos" y los controladores "funcion de flecha async" (req, res) => {...}
//Mostrar errores en consola si se presentan
app.get('/articulos', async (req, res) => {
  try {
    const articulos = await consultaArticulos(dbPool); // Pasa dbPool como argumento
    res.json(articulos);
  } catch (error) {
    console.error('Error al obtener los artículos:', error);
    res.status(500).json({ error: 'Error al obtener los artículos1' });
  }
});

app.get('/clientes', async (req, res) => {
  try {
    const clientes = await consultarClientes(dbPool); // Pasa dbPool como argumento
    res.json(clientes);
  } catch (error) {
    console.error('Error al obtener los clientes:', error);
    res.status(500).json({ error: 'Error al obtener los clientes1' });
  }
});

app.get('/kardex', async (req, res) => {
  try {
    const kardex = await consultaKardex(dbPool); // Pasa dbPool como argumento
    res.json(kardex);
  } catch (error) {
    console.error('Error al obtener el kardex:', error);
    res.status(500).json({ error: 'Error al obtener los clientes1' });
  }
});

app.get('/proveedores', async (req, res) => {
  try {
    const proveedores = await consultarProveedores(dbPool); // Pasa dbPool como argumento
    res.json(proveedores);
  } catch (error) {
    console.error('Error al obtener los proveedores:', error);
    res.status(500).json({ error: 'Error al obtener los proveedores1' });
  }
});

app.listen(PORT, () => {
  console.log(`Servidor escuchando en http://localhost:${PORT}`);
});