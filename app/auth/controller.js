import pool from '../config/config-database';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import passport from 'passport';
import { Strategy as JwtStrategy, ExtractJwt } from 'passport-jwt';
import { v4 as uuidv4 } from 'uuid';
import dotenv from 'dotenv';
import { sendConfirmationEmail } from './mailerauth';
dotenv.config();

// Función para encriptar contraseñas
async function encryptPassword(password) {
  const salt = await bcrypt.genSalt(10);
  return await bcrypt.hash(password, salt);
}

export async function getUsers(req, res) {
  try {
    const result = await pool.query('SELECT * FROM users');
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'An error occurred while fetching users' });
  }
}

// Función para agregar usuarios
async function addUser(user) {
  try {
    user.contrasena = await encryptPassword(user.contrasena);
    user.confirmationCode = uuidv4();
    const createUserQuery = `
      INSERT INTO usuarios (nombre, correo, contrasena, confirmationCode, confirmed)
      VALUES ($1, $2, $3, $4, $5)
      RETURNING *;
    `;
    const result = await pool.query(createUserQuery, [user.nombre, user.correo, user.contrasena, user.confirmationCode, false]);

    return result.rows[0];
  } catch (err) {
    console.error(err);
    throw err;
  }
}

function generateToken(user) {
  const payload = {
    id: user.id,
    usuario: user.usuario
  };
  return jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: '1h' });
}

export async function login(req, res) {
  const { correo, contrasena } = req.body;

  try {
    const result = await pool.query('SELECT * FROM usuarios WHERE correo = $1', [correo]);
    const user = result.rows[0];

    if (!user) {
      return res.status(400).json({ error: 'Invalid credentials' });
    }

    const isMatch = await bcrypt.compare(contrasena, user.contrasena);

    if (!isMatch) {
      return res.status(400).json({ error: 'Invalid credentials' });
    }
    console.log(user.confirmed)
    if (!user.confirmed) {
      return res.status(400).json({ error: 'Email not confirmed' });
    }

    const payload = { id: user.id };
    const token = jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: '1h' });

    res.json({ token });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'An error occurred during login' });
  }
}

// Configuración de Passport JWT
const opts = {
  jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
  secretOrKey: process.env.JWT_SECRET
};

passport.use(new JwtStrategy(opts, async (jwt_payload, done) => {
  try {
    const user = await pool.query('SELECT * FROM usuarios WHERE id = $1', [jwt_payload.id]);
    if (user.rows.length > 0) {
      return done(null, user.rows[0]);
    } else {
      return done(null, false);
    }
  } catch (err) {
    return done(err, false);
  }
}));

export async function confirmUser(req, res) {
  try {
    const user = await pool.query('SELECT * FROM usuarios WHERE confirmationCode = $1', [req.params.confirmationCode]);

    if (user.rows.length === 0) {
      return res.status(404).send({ message: 'Usuario no encontrado.' });
    }

    await pool.query('UPDATE usuarios SET confirmed = TRUE WHERE id = $1', [user.rows[0].id]);

    res.send({ message: 'Usuario confirmado correctamente.' });
  } catch (err) {
    console.error(err);
    res.status(500).send('Error al confirmar la cuenta');
  }
}

// Ruta para solicitar el cambio de contraseña
export async function forgotPassword(req, res) {
  const { correo } = req.body;

  try {
    const result = await pool.query('SELECT * FROM usuarios WHERE correo = $1', [correo]);
    const user = result.rows[0];

    if (!user) {
      return res.status(400).json({ error: 'No user with that email' });
    }

    const token = uuidv4();
    await pool.query('UPDATE usuarios SET resetPasswordToken = $1 WHERE id = $2', [token, user.id]);

    const mailOptions = {
      from: process.env.EMAIL,
      to: correo,
      subject: 'Link To Reset Password',
      text: `You are receiving this because you (or someone else) have requested the reset of the password for your account.\n\nPlease click on the following link, or paste this into your browser to complete the process within one hour of receiving it:\n\nhttp://localhost:4000/reset/${token}\n\nIf you did not request this, please ignore this email and your password will remain unchanged.\n`
    };

    sendConfirmationEmail(mailOptions);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'An error occurred during password reset' });
  }
}

// Ruta para cambiar la contraseña
export async function resetPassword(req, res) {
  const { token } = req.params;
  const { password } = req.body;

  try {
    const result = await pool.query('SELECT * FROM usuarios WHERE resetPasswordToken = $1', [token]);
    const user = result.rows[0];

    if (!user) {
      return res.status(400).json({ error: 'Invalid or expired password reset token' });
    }

    const hashedPassword = await encryptPassword(password);
    await pool.query('UPDATE usuarios SET contrasena = $1, resetPasswordToken = NULL WHERE id = $2', [hashedPassword, user.id]);

    res.json({ message: 'Password reset successfully' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'An error occurred during password reset' });
  }
}

export { addUser, generateToken };
export default passport;