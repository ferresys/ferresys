const express = require('express');
const cors = require('cors');
const clienteRoutes = require('./clienteRoutes');

const app = express();

app.use(cors());
app.use('/clientes', clienteRoutes);

app.listen(3000, () => {
  console.log('Servidor escuchando en http://localhost:3000');
});


