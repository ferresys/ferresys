//IMPORTAMOS LAS FUNCIONES E INSTANCIAS NECESARIAS.
import pool from '../../config/config-database';
import { manejoErrores } from '../../middleware/error';
import { ErrorDeBaseDeDatos } from '../../middleware/class-error';
import { manejoErroresInsert } from '../../middleware/error';
import { validateEmail } from '../../middleware/email';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';

//CONFIGURAMOS LOS CONTROLADORES A TRAVES DE FUNCIONES PARA MANEJAR LAS SOLICITUDES HTTP.

//CONSULTAS GENERALES

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

const getUsuarios = async (req, res) => {
  const response = await pool.query('SELECT * FROM tabUsuario LIMIT 100');
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');
  }
  res.status(200).json(response.rows);
};

//Aplicar el middleware de manejo de errores al controlador
export const getUsuariosError = manejoErrores(getUsuarios);

// CONSULTAS POR ID 

const getUsuarioById = async (req, res) => {
  const id = req.params.id;
  const response = await pool.query('SELECT * FROM tabUsuario WHERE idUsuario = $1', [id]);
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');//Throw se usa para generar un error intencional en el codigo js.
  }
  res.json(response.rows);
};

export const getUsuarioByIdError = manejoErrores(getUsuarioById);

//  INSERTAR DATOS 

export const insertUsuario = async (req, res) => {
  const { idUsuario, nomUsuario, apeUsuario, emailUsuario, usuario, password } = req.body;

  try {
    if (!validateEmail(emailUsuario)) {
      throw new Error('Invalid email format');
    }
  } catch (error) {
    res.status(400).json({ message: error.message });
    return;
  }

  try {
    const hashedpassword = await bcrypt.hash(password, 10);

    const response = await pool.query('SELECT insertUsuario($1, $2, $3, $4, $5, $6)', 
      [idUsuario, nomUsuario, apeUsuario, emailUsuario, usuario, hashedpassword]);
    console.log(response);
    res.json({
      message: 'Usuario Registrado con éxito',
      body: {
        Usuario: {idUsuario, nomUsuario, apeUsuario, emailUsuario, usuario, hashedpassword},
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: 'Error al registrar Usuario',
    });
  }
};

//ACTUALIZAR DATOS

export const updateUsuario = async (req, res) => {
  const id = req.params.id;
  const { idUsuario, nomUsuario, apeUsuario, emailUsuario, usuario, password } = req.body;

  try {
    const user = await pool.query('SELECT * FROM tabUsuario WHERE idUsuario = $1', [id]);

    const match = await bcrypt.compare(password, user.rows[0].password);

    if (match) {
      return res.status(400).send('No puedes usar la misma contraseña');
    }

    const hashedpassword = await bcrypt.hash(password, 10);

    const response = await pool.query(
      'UPDATE tabUsuario SET idUsuario = $1, nomUsuario = $2, apeUsuario = $3, emailUsuario = $4, usuario = $5, password = $6 WHERE idUsuario = $7',
      [idUsuario, nomUsuario, apeUsuario, emailUsuario, usuario, hashedpassword, id]
    );

    console.log(response);
    res.send('Usuario Actualizado con éxito');
  } catch (error) {
    console.error('Error al actualizar usuario:', error);
    res.status(500).send('Error al actualizar usuario');
  }
};

//ELIMINAR DATOS

export const deleteUsuario = async (req, res) => {
  const id = req.params.id;

  try {
    const response = await pool.query('DELETE FROM tabUsuario WHERE idUsuario = $1', [id]);
    console.log(response);
    res.send('Usuario Eliminado con éxito');
  } catch (error) {
    console.error('Error al eliminar Usuario:', error);
    res.status(500).send('Error al eliminar Usuario');
  }
};