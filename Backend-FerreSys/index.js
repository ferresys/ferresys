
//CREACION DEL SERVIDOR

//importamos

import express from 'express'; //(crear el servidor)
import dotenv from 'dotenv'; //(.env)
import { dbPool } from './conexion_db';
import { insertar_articulo } from './insert_articulos';
import { consultar_articulos } from './consulta_articulos'; //(funcion)
import { consultar_clientes } from './consulta_clientes';
import { consultar_proveedores } from './consulta_proveedores';
import cors from 'cors';  // <-- Asegúrate de importar cors


//cargar variables de entorno .env

dotenv.config();


//crear instancia app y variable PORT
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
    const resultado = await insertar_articulo([
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
app.get('/articulos', async (req, res) => {

//mostrar errores en consola si se presentan.

try {
    const articulos = await consultar_articulos();
    res.json(articulos);
  } catch (error) {
    console.error('Error al obtener los artículos:', error);
    res.status(500).json({ error: 'Error al obtener los artículos1' });
  }
});


app.get('/clientes', async (req, res) => {
try {
    const clientes = await consultar_clientes();
    res.json(clientes);
  } catch (error) {
    console.error('Error al obtener los clientes:', error);
    res.status(500).json({ error: 'Error al obtener los clientes1' });
  }
});


app.get('/proveedores', async (req, res) => {
try {
    const proveedores = await consultar_proveedores();
    res.json(proveedores);
  } catch (error) {
    console.error('Error al obtener los proveedores:', error);
    res.status(500).json({ error: 'Error al obtener los proveedores1' });
  }
});






/*
dotenv.config();:Cargar las variables de entorno desde .env*/


/*const app = express(); "app"a traves de esta instancia definiremos las rutas y manejadores para nuestra aplicación web.
const PORT = process.env.PORT || 3000; /*"PORT" variable,puerto en el que se ejecutará nuestro servidor.*/

/*IMPORTANTE: las instancias son objetos creados a partir de una clase en la programación orientada a objetos (POO).
en este caso las clases son express y port y creamos las instancias para darle un nombre a esas clases.*/
 

/*app.get('/articulos', async (req, res) => { : Ruta para obtener los artículos desde la base de datos 
get:es un metodo de la instancia "app", Este método se utiliza para definir
una ruta que maneja solicitudes HTTP GET.

/articulos: Es la URL de la ruta que estamos definiendo. 
En este caso, la ruta es `/articulos`, lo que significa que esta ruta responderá a las solicitudes GET 
que se hagan a `http://localhost:3000/articulos`.

async (req, res) => { ... }: Es la función de controlador que se ejecutará cuando llegue una solicitud GET a la ruta `/articulos`.
Es una función asíncrona (`async`) porque podemos usar el `await` para esperar la respuesta de operaciones
asíncronas, como consultas a la base de datos, sin bloquear el hilo principal del servidor.

req: Es un objeto que representa la solicitud HTTP entrante.
Contiene información sobre la solicitud, como los datos enviados en el cuerpo, parámetros, encabezados, etc.

res: Es un objeto que representa la respuesta HTTP que enviaremos al cliente. 
Utilizamos este objeto para enviar una respuesta al cliente con datos, como un archivo, una página HTML o, en este caso, un objeto JSON.*/
  
/*try {
const articulos = await obtener_articulos();Obtener los artículos desde la base de datos a traves de la funcion obtener_articulos
articulos: es una constante que guardara la respuesta segun lo que hayamos solicitado atraves de la funcion obtener_articulos.
await: utilizada para esperar a que una promesa se resuelva significa esperar o aguardar.
Solo puede usarse dentro de una función declarada con `async`.
Cuando se utiliza `await`, el programa se detiene temporalmente en esa línea hasta que la promesa 
se resuelva o se cumpla.
promesa:Una promesa es un objeto en JavaScript que representa el resultado pendiente de una operación asíncrona.

    res.json(articulos); Express automáticamente establece el encabezado adecuado para la respuesta HTTP y convierte el objeto JSON en formato de respuesta.
  } catch (error) {
    console.error('Error al obtener los artículos:', error);
    res.status(500).json({ error: 'Error al obtener los artículos' });
  }
});

try {}catch(error){}: Esto evita que los errores no controlados detengan la ejecución del programa 
y permite que el código continúe ejecutándose en otras partes que no estén afectadas por el error.
Es basicamente para que nos muestre errores que se puedan presentar durante
la ejecucion del codigo en las consultas.lo programamos para que nos muestre error en la consola*/

/* Iniciar el servidor
app.listen(PORT, () => {
  console.log(`Servidor escuchando en http://localhost:${PORT}`);
});
app.listen(PORT, () => { ... })`: Aquí estamos llamando al método `listen()`
 de la instancia de la aplicación Express (`app`). 
 Este método se utiliza para iniciar el servidor y hacer que comience a escuchar las solicitudes
 entrantes en un puerto específico.

 PORT: Es una variable que contiene el número de puerto en el que queremos que el servidor escuche
  las solicitudes entrantes.

() => { ... }: Es una función de flecha (arrow function) que se pasa como argumento al método `listen()`. 
Esta función se ejecuta cuando el servidor se inicia correctamente y comienza a escuchar las solicitudes 
entrantes en el puerto especificado.
console.log(`Servidor escuchando en http://localhost:${PORT}`): Dentro de la función de flecha, utilizamos 
console.log() para mostrar un mensaje en la consola indicando que el servidor está escuchando 
en una URL específica. 

${PORT}: en una plantilla de cadena se evalúa como el valor de la variable PORT 
y es una forma más legible de construir cadenas de texto que incluyen valores de variables en JavaScript.*/
