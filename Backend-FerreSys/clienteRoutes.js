const express = require('express');
const router = express.Router();
const { consultarClientes } = require('./queryClientes');

router.get('/', async (req, res) => {
  try {
    const clientes = await consultarClientes();
    res.json(clientes);
  } catch (error) {
    console.error(error);
    res.status(500).send('Error interno del servidor');
  }
});

module.exports = router;