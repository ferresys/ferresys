const express = require('express');
const app = express();


//middlewares (funciones que se ejecutan antes de que lleguen a las rutas en este caso  atraves de json)

app.use(express.json()); //para recibir formatos tipo json
app.use(express.urlencoded({extended: false})); //para entender datos que vengan de un formulario y para que no acepte imagenes, solo texto


//routes
app.use(require('./routes/index'));

app.listen(4000);
console.log('server on port 4000');