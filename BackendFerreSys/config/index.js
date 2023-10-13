
import express from 'express';

//creamos la instancia para express.
const app = express();

// Middlewares (funciones que se ejecutan antes de llegar a las rutas, en este caso, para procesar JSON y formularios)
app.use(express.json()); // para procesar formatos tipo JSON
app.use(express.urlencoded({ extended: false })); // para entender datos de formularios y rechazar imágenes, solo texto

// Rutas
import router from '../src/routes/indexRoutes';
app.use(router);//es un método de Express que se utiliza para montar middleware o enrutadores en la aplicación.

app.listen(4000, () => {
  console.log('Server is listening on port 4000');
});


/***************************************************************************************
* Express en Node.js es un framework  web que simplifica y acelera el desarrollo       *
* de aplicaciones web y APIs al proporcionar una estructura y un conjunto de funciones *
* para gestionar solicitudes y respuestas HTTP de manera eficiente y organizada.       *
*                                                                                      *
***************************************************************************************/

/**********************************************************************************
* Esta instancia de app es la que se utiliza para configurar y manejar las rutas,** 
* middleware y otras configuraciones de tu aplicación.                            *
*                                                                                 *
* Esta instancia (app) será el servidor web que manejará las solicitudes entrantes y las*
* rutas definidas.                                                                *
*                                                                                 *
**********************************************************************************/

