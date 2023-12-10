import pool from '../../config/config-database';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';

export const login = async (req, res) => {
    const { usuario, password } = req.body;
  
    const user = await pool.query('SELECT * FROM tabUsuario WHERE usuario = $1', [usuario]);
  
    if (user.rows.length > 0) {
      const match = await bcrypt.compare(password, user.rows[0].password);
  
      if (match) {
        const token = jwt.sign({ id: user.rows[0].idUsuario }, process.env.SECRET, { expiresIn: '10m' });
  
        res.json({ message: 'Ingreso exitoso', token });
      } else {
        res.status(401).json({ message: 'Contraseña incorrecta' });
      }
    } else {
      res.status(400).json({ message: 'Usuario no existe' });
    }
  };