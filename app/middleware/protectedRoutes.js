const express = require('express');
const path = require('path');
const router = express.Router();

function requireLogin(req, res, next) {
  if (req.session && req.session.userId) {
    next();
  } else {
    res.redirect('/login');
  }
}

router.get('/articulo', requireLogin, (req, res) => {
  res.sendFile(path.join(__dirname, '..', '..', 'public', 'protected', 'consult', 'articulo.html'));
});

router.get('/marca', requireLogin, (req, res) => {
  res.sendFile(path.join(__dirname, '..', '..', 'public', 'protected', 'consult', 'marca.html'));
});

router.get('/cliente', requireLogin, (req, res) => {
  res.sendFile(path.join(__dirname, '..', '..', 'public', 'protected', 'consult', 'cliente.html'));
});

router.get('/categoria', requireLogin, (req, res) => {
  res.sendFile(path.join(__dirname, '..', '..', 'public', 'protected', 'consult', 'categoria.html'));
});

router.get('/proveedor', requireLogin, (req, res) => {
  res.sendFile(path.join(__dirname, '..', '..', 'public', 'protected', 'consult', 'proveedor.html'));
});

module.exports = router;