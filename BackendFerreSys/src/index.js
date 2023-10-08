
import express from 'express';
const app = express();

// Middlewares (funciones que se ejecutan antes de llegar a las rutas, en este caso, para procesar JSON y formularios)
app.use(express.json()); // para procesar formatos tipo JSON
app.use(express.urlencoded({ extended: false })); // para entender datos de formularios y rechazar imágenes, solo texto

// Rutas
import indexRoutes from './routes/indexRoutes';
app.use(indexRoutes);

app.listen(4000, () => {
  console.log('Server is listening on port 4000');
});
