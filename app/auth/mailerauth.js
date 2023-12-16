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
