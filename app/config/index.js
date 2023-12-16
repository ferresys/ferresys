import express from 'express';
import cors from 'cors';
import path from 'path';
import session from 'express-session';
const app = express();

// Middlewares
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cors());

app.use(session({
  name: 'my.session.cookie',
  secret: process.env.JWT_SECRET,
  resave: false,
  saveUninitialized: false,
  cookie: { secure: false }
}));

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, '..', '..', 'public', 'signin.html'), function (err) {
    if (err) {
      console.log(err);
      res.status(err.status).end();
    }
  });
});

// Ruta para servir index.html cuando se solicita /home
app.get('/home', (req, res) => {
  if (req.session && req.session.userId) {
    // El usuario ha iniciado sesión, servir index.html
    res.sendFile(path.join(__dirname, '..', '..', 'public', 'index.html'));
  } else {
    // El usuario no ha iniciado sesión, redirigir a la página de inicio de sesión
    res.redirect('/');
  }
});

// Ruta para servir archivos de la carpeta 'lib'
app.use('/lib', express.static(path.join(__dirname, '..', '..', 'public', 'lib')));

// Ruta para servir archivos de la carpeta 'img'
app.use('/img', express.static(path.join(__dirname, '..', '..', 'public', 'img')));

// Ruta para servir archivos CSS
app.use('/css', express.static(path.join(__dirname, '..', '..', 'public', 'css')));

// Ruta para servir archivos JavaScript
app.use('/js', express.static(path.join(__dirname, '..', '..', 'public', 'js')));
// Rutas
import router from '../src/routes/indexRoutes';
app.use(router);



import authRouter from '../auth/roueterauth';
app.use('/api/auth', authRouter);

// Ruta de captura
// Ruta de captura
app.use('*', (req, res) => {
  console.log(`Solicitud no manejada: ${req.method} ${req.originalUrl}`);
  res.status(404).send('La ruta solicitada no existe.');
});


const port = process.env.PORT || 4000;

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
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

