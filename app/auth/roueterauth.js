import express from 'express';
import pool from '../config/config-database.js';
import { addUser } from '../auth/controller.js';
import { sendConfirmationEmail } from './mailerauth.js';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import { confirmUser } from '../auth/controller.js';

const router = express.Router();

router.use(express.json()); // Para poder parsear el cuerpo de las solicitudes POST

router.post('/register', async (req, res) => {
  try {
    const user = req.body;
    const confirmationCode = await addUser(user);
    await sendConfirmationEmail(user, confirmationCode);
    res.json({ success: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false });
  }
});

// confirmacion via correo 

router.get('/confirm/:confirmationCode', async (req, res) => {
  try {
    const user = await pool.query('SELECT * FROM usuarios WHERE confirmationCode = $1', [req.params.confirmationCode]);
    if (user.rows.length > 0) {
      await pool.query('UPDATE usuarios SET confirmed = TRUE WHERE id = $1', [user.rows[0].id]);
      res.send('Tu cuenta ha sido confirmada');
    } else {
      res.send('Código de confirmación inválido');
    }
  } catch (err) {
    console.error(err);
    res.status(500).send(`Error al confirmar la cuenta: ${err.message}`);
  }
});




// ruta para autenticarse

router.post('/login', async (req, res) => {
  const { correo, contrasena } = req.body;
  // busca al usuario en la base de datos
  const user = await pool.query('SELECT * FROM usuarios WHERE correo = $1', [correo]);
  if (user.rows.length > 0) {
    // verifica la contraseña
    const validPassword = await bcrypt.compare(contrasena, user.rows[0].contrasena);
    if (validPassword) {
      // verifica si el correo electrónico está confirmado
      if (user.rows[0].confirmed) {
        // la contraseña es correcta y el correo electrónico está confirmado, inicia la sesión del usuario
        req.session.userId = user.rows[0].id;
        res.json({ success: true });
      } else {
        // el correo electrónico no está confirmado
        res.status(400).json({ error: 'Email not confirmed' });
      }
    } else {
      // la contraseña es incorrecta
      res.status(401).json({ success: false });
    }
  } else {
    // el usuario no existe
    res.status(404).json({ success: false });
  }
});

// Ruta para cerrar la sesión del usuario
router.get('/logout', (req, res) => {
  req.session.destroy(err => {
    if (err) {
      // Hubo un error al destruir la sesión
      res.status(500).send({ success: false, message: 'Error al cerrar la sesión.' });
    } else {
      // La sesión se destruyó con éxito, redirigir al usuario a la página de inicio de sesión
      res.redirect('/');
    }
  });
});


export default router;
