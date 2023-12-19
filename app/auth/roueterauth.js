import express from 'express';
import pool from '../config/config-database.js';
import { addUser } from '../auth/controller.js';
import { sendConfirmationEmail } from './mailerauth.js';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import { confirmUser } from '../auth/controller.js';
import { v4 as uuidv4 } from 'uuid';
import { forgotPassword, resetPassword } from './controller.js';
import { sendResetPasswordEmail } from './mailerauth.js';

const router = express.Router();

router.use(express.json()); // Para poder parsear el cuerpo de las solicitudes POST

router.post('/register', async (req, res) => {
  try {
    const user = req.body;

    // Verificar si el correo ya está registrado
    const existingUser = await pool.query('SELECT * FROM usuarios WHERE correo = $1', [user.correo]);
    if (existingUser.rows.length > 0) {
      // Si el usuario ya existe, devolver un error
      return res.status(400).json({ error: 'El correo ya está registrado.' });
    }

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
      res.send(`
      <!DOCTYPE html PUBLIC>
      <html>
      
      <head>
          <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
          <meta http-equiv="X-UA-Compatible" content="IE=edge">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title></title>
          <style type="text/css">
              @font-face {
                  font-family: "Gotham";
                  src: url("http://app.mydoctorize.com/fonts/GothamProLight.otf");
                  font-weight: 300;
                  font-style: normal;
              }
              
              @font-face {
                  font-family: "Gotham";
                  src: url("http://app.mydoctorize.com/fonts/GothamProLightItalic.otf");
                  font-weight: 300;
                  font-style: italic;
              }
              
              @font-face {
                  font-family: "Gotham";
                  src: url("http://app.mydoctorize.com/fonts/GothamProRegular.otf");
                  font-weight: normal;
                  font-style: normal;
              }
              
              @font-face {
                  font-family: "Gotham";
                  src: url("http://app.mydoctorize.com/fonts/GothamProRegular.otf");
                  font-weight: normal;
                  font-style: italic;
              }
              
              @font-face {
                  font-family: "Gotham";
                  src: url("http://app.mydoctorize.com/fonts/GothamProMedium.otf");
                  font-weight: 500;
                  font-style: normal;
              }
              
              @font-face {
                  font-family: "Gotham";
                  src: url("http://app.mydoctorize.com/fonts/GothamProMediumItalic.otf");
                  font-weight: 500;
                  font-style: italic;
              }
              
              @font-face {
                  font-family: "Gotham";
                  src: url("http://app.mydoctorize.com/fonts/GothamProBold.otf");
                  font-weight: 600;
                  font-style: normal;
              }
              
              @font-face {
                  font-family: "Gotham";
                  src: url("http://app.mydoctorize.com/fonts/GothamProBoldItalic.otf");
                  font-weight: 600;
                  font-style: italic;
              }
          </style>
          <!--[if (gte mso 9)|(IE)]> <style type="text/css"> table{border-collapse: collapse;}</style><![endif]-->
      </head>
      
      <body style="Margin: 0; background-color: #ffffff !important; color: #2D444E; font-family: Arial,sans-serif; font-size: 14px; font-weight: normal; line-height: 1.3; margin: 0 !important; padding: 0;">
          <center class="wrapper" style="-ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; table-layout: fixed; width: 100%;">
              <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                  <tr>
                      <td height="40" style="font-size: 40px; line-height: 40px; padding: 0;">&nbsp;</td>
                  </tr>
              </table>
              <div class="webkit" style="margin: 0 auto; max-width: 600px;">
                  <!--[if (gte mso 9)|(IE)]> <table width="600" align="center"> <tr> <td><![endif]-->
                  <table class="outer" align="center" style="Margin: 0 auto; border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif; max-width: 600px; width: 100%;">
                      <tr>
                          <td class="inner" style="padding: 0px 10px;">
                              <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                                  <tr>
                                      <td align="center" valign="top" style="padding: 0;">
                                          
                                      </td>
                                  </tr>
                              </table>
                              <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                                  <tr>
                                      <td height="45" style="font-size: 45px; line-height: 45px; padding: 0;">&nbsp;</td>
                                  </tr>
                              </table>
                          </td>
                      </tr>
                      <tr>
                          <td class="inner" style="padding: 0px 10px;">
                              <table class="content" width="100%" cellpadding="0" cellspacing="0" border="0" bgcolor="#f9f9f9" style="-moz-box-shadow: 0px 7px 35px 0px rgba(16,43,200,0.2); -webkit-box-shadow: 0px 7px 35px 0px rgba(16,43,200,0.2); background-color: #f9f9f9; border-collapse: separate !important; border-color: #e4e2e2; border-radius: 4px; border-spacing: 0; border-style: solid; border-width: 1px; box-shadow: 0px 7px 35px 0px rgba(16,43,200,0.2); color: #2D444E; font-family: Arial,sans-serif;">
                                  <tr>
                                      <td align="center" valign="top" style="padding: 0;">
                                          <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0;
      color: #2D444E; font-family: Arial,sans-serif;">
                                              <tr>
                                                  <td height="45" style="font-size: 45px; line-height: 45px; padding: 0;">&nbsp;</td>
                                              </tr>
                                          </table>
                                          <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                                              <tr>
                                                  <td height="35" style="font-size: 35px; line-height: 35px; padding: 0;">&nbsp;</td>
                                              </tr>
                                          </table>
                                          <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                                              <tr>
                                                  <td class="inner" align="center" valign="top" style="padding: 0px 10px;">
                                                      <p class="h1" style="Margin:
      0; color: #2D444E; font-family: 'Gotham',Helvetica,Arial,sans-serif; font-size: 25px; font-weight: normal; line-height: 1.3; margin: 0 !important; padding: 0;">CUENTA CONFIRMADA</p><br/><br/>
                                                    <p style="margin-left: auto; margin-right: auto; width: 80%; color: #2D444E; font-family: 'Gotham',Helvetica,Arial,sans-serif; font-size: 16px; font-weight: normal; line-height: 1.3; margin: 0 !important; padding: 0;">
                                                      Ya Puedes Regresar al Inicio
      
                                                    </p>
                                                    <br/><br/>
                                                  </td>
                                              </tr>
                                          </table>
                                          <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0;
      color: #2D444E; font-family: Arial,sans-serif;">
                                              <tr>
                                                  <td height="15" style="font-size: 15px; line-height: 15px; padding: 0;">&nbsp;</td>
                                              </tr>
                                          </table>
                                          <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                                              <tr>
                                                  <td class="padding-0-30" align="center" valign="top" style="padding: 0 30px;">
                                                      
                                                  </td>
                                              </tr>
                                          </table>
                                          <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                                              <tr>
                                                  <td height="10" style="font-size: 10px;
      line-height: 10px; padding: 0;">&nbsp;</td>
                                              </tr>
                                          </table>
                                          <table class="content__button" width="190" height="48" cellpadding="0" cellspacing="0" border="0" bgcolor="#022232" style="background-color: #022232; border-radius: 3px; border-spacing: 0; color: #ffcc29 !important; font-family: Arial,sans-serif; height: 48px; padding: 0 15px;">
                                              <tr>
                                                <!-- LINK DE 
      END -->
                                                  <td align="center" valign="middle" height="48" style="color: #ffcc29 !important; padding: 0;"> <a class="content__button-link" href="http://localhost:4000/" target="_blank" style="Margin: 0; color: #ffcc29 !important; display: inline-block; font-family: 'Gotham',Helvetica,Arial,sans-serif; font-size: 20px; font-weight: 600; line-height: 48px; margin: 0 !important; padding: 0; text-decoration: none;">REGRESAR AL INICIO</a> </td>
                                                  <!-- FIN LINK DE BACKEND -->
                                              </tr>
                                          </table>
                                          <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                                              <tr>
                                                  <td height="30" style="font-size: 30px; line-height: 30px; padding: 0;">&nbsp;</td>
                                              </tr>
                                          </table>
                                          <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                                              <tr>
                                                  <td height="30" style="font-size: 30px; line-height: 30px; padding: 0;">&nbsp;</td>
                                              </tr>
                                          </table>
                                      </td>
                                  </tr>
                              </table>
                          </td>
                      </tr>
                      <tr>
                          <td style="padding: 0;">
                              <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                                  <tr>
                                      <td height="40" style="font-size: 40px; line-height: 40px; padding: 0;">&nbsp;</td>
                                  </tr>
                              </table>
                          </td>
                      </tr>
                      <tr>
                          <td class="inner" style="padding: 0px 10px;">
                              <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                                  <tr>
                                      <td class="inner header__text" align="center" valign="top" style="color: #cccccc; font-family: 'Gotham',Helvetica,Arial,sans-serif; font-size: 13px; font-weight: 300; padding: 0px 10px; text-decoration: none;">
                                          <a class="header__link"  target="_blank" style="Margin: 0; color: #cccccc; font-family: 'Gotham',Helvetica,Arial,sans-serif; font-size: 13px; font-weight: 300; line-height: 1.3; margin: 0 !important; padding: 0; text-decoration: none;">&copy;&nbsp;2024&nbsp;FerreSys&nbsp;</a>                                    </td>
                                  </tr>
                              </table>
                          </td>
                      </tr>
                      <tr>
                          <td style="padding: 0;">
                              <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-spacing: 0; color: #2D444E; font-family: Arial,sans-serif;">
                                  <tr>
                                      <td height="40" style="font-size: 40px; line-height: 40px; padding: 0;">&nbsp;</td>
                                  </tr>
                              </table>
                          </td>
                      </tr>
                  </table>
                  <!--[if (gte mso 9)|(IE)]> </td></tr></table><![endif]-->
              </div>
          </center>
      </body>
      
      </html>
      `);
    } else {
      res.send(`
        <h1>Código de confirmación inválido</h1>
        <p>El código de confirmación que proporcionaste no es válido. Por favor, comprueba el enlace que recibiste en tu correo electrónico e inténtalo de nuevo.</p>
      `);
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
// cambia el no nombre en la aplicacion
router.get('/me', async (req, res) => {
  
  if (!req.session.userId) {
    return res.status(401).json({ error: 'No estás autenticado.' });
  }

  // Busca al usuario en la base de datos
  const user = await pool.query('SELECT nombre FROM usuarios WHERE id = $1', [req.session.userId]);
  if (user.rows.length > 0) {
    // Devuelve los detalles del usuario
    res.json(user.rows[0]);
  } else {
    res.status(404).json({ error: 'Usuario no encontrado.' });
  }
});

// Ruta para solicitar el cambio de contraseña
router.post('/forgot-password', async (req, res) => {
  const { correo } = req.body;

  try {
    const result = await pool.query('SELECT * FROM usuarios WHERE correo = $1', [correo]);
    const user = result.rows[0];

    if (!user) {
      return res.status(400).json({ error: 'No user with that email' });
    }

    const token = uuidv4();
    await pool.query('UPDATE usuarios SET resetPasswordToken = $1 WHERE id = $2', [token, user.id]);

    sendResetPasswordEmail(user, token);
    res.json({ success: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false });
  }
});
// Ruta para cambiar la contraseña
router.post('/reset/:token', async (req, res) => {
  const { token } = req.params;
  const { password } = req.body;

  try {
    const result = await pool.query('SELECT * FROM usuarios WHERE resetPasswordToken = $1', [token]);
    const user = result.rows[0];

    if (!user) {
      return res.status(400).json({ error: 'Invalid or expired password reset token' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    await pool.query('UPDATE usuarios SET contrasena = $1, resetPasswordToken = NULL WHERE id = $2', [hashedPassword, user.id]);

    res.json({ success: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false });
  }
});

export default router;
