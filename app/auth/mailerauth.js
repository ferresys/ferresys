import nodemailer from 'nodemailer';
import dotenv from 'dotenv';
dotenv.config();

export async function sendConfirmationEmail(user) {
  const smtpTransport = nodemailer.createTransport({
    host: 'smtp.mailtrap.io',
    port: 2525,
    auth: {
      user: process.env.MAILTRAP_USER,
      pass: process.env.MAILTRAP_PASS,
    },
  });

  const mailOptions = {
    from: process.env.EMAIL,
    to: user.correo,
    subject: 'Confirma tu cuenta',
    text: `Hola ${user.nombre},\n\nPor favor confirma tu cuenta haciendo clic en el siguiente enlace: \nhttp://localhost:4000/api/auth/confirm/${user.confirmationCode}\n\nSi no solicitaste este correo electrónico, por favor ignóralo.\n\nSaludos,\nTu equipo`
  };

  smtpTransport.sendMail(mailOptions, (error, response) => {
    error ? console.log(error) : console.log(response);
    smtpTransport.close();
  });
}


export async function sendResetPasswordEmail(user, token) {
  const smtpTransport = nodemailer.createTransport({
    host: 'smtp.mailtrap.io',
    port: 2525,
    auth: {
      user: process.env.MAILTRAP_USER,
      pass: process.env.MAILTRAP_PASS,
    },
  });

  if (!user.correo) {
    console.log('No email provided for user', user);
    return;
  }

  const mailOptions = {
    from: process.env.EMAIL,
    to: user.correo,
    subject: 'Restablece tu contraseña',
    html: `
      <p>Hola ${user.nombre},</p>
      <p>Recibimos una solicitud para restablecer tu contraseña. Puedes hacerlo haciendo clic en el siguiente botón:</p>
      <a href="http://localhost:4000/public/resetpass.html?token=${token}" style="background-color: #4CAF50; color: white; padding: 15px 32px; text-align: center; text-decoration: none; display: inline-block; font-size: 16px; margin: 4px 2px; cursor: pointer; border: none;">Restablecer contraseña</a>
      <p>Si no solicitaste este correo electrónico, por favor ignóralo.</p>
      <p>Saludos,</p>
      <p>Tu equipo</p>
    `
  };

  console.log('About to send reset password email');

  smtpTransport.sendMail(mailOptions, (error, response) => {
    if (error) {
      console.log('Error sending reset password email', error);
    } else {
      console.log('Reset password email sent', response);
    }
    smtpTransport.close();
  });

  console.log('Done with sendResetPasswordEmail');
}