const express = require('express');
const router = express.Router();
const { consultar_clientes } = require('./consultaclientes');

router.get('/', async (req, res) => {
  try {
    const clientes = await consultar_clientes();
    res.json(clientes);
  } catch (error) {
    console.error(error);
    res.status(500).send('Error interno del servidor');
  }
});

module.exports = router;
