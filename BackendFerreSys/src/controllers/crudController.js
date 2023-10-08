
//CONFIGURAMOS LOS CONTROLADORES PARA MANERJAR LAS SOLICITUDES HTTP.

import pool from '../../config/connectionDB';

import { manejoErrores } from '../../middleware/error';
import {ErrorDeBaseDeDatos} from '../../middleware/classError';

export const getClientes = async (req, res) => {
  //throw new Error('Este es un error de prueba'); //con esta linea podemos probar que el (error 500) funciona.
  const response = await pool.query('SELECT * FROM tabCliente LIMIT 100');
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');
  }
  res.status(200).json(response.rows);
};


const getProveedores = async (req, res) => {
  const response = await pool.query('SELECT * FROM tabProveedor LIMIT 100');
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');
  }
  res.status(200).json(response.rows);
};

const getMarcas = async (req, res) => {
  const response = await pool.query('SELECT * FROM tabMarca LIMIT 100');
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');
  }
  res.status(200).json(response.rows);
};

const getCategorias = async (req, res) => {
  const response = await pool.query('SELECT * FROM tabCategoria LIMIT 100');
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');
  }
  res.status(200).json(response.rows);
};

const getArticulos = async (req, res) => {
  const response = await pool.query('SELECT * FROM tabArticulo LIMIT 100');
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');
  }
  res.status(200).json(response.rows);
};

const getReciboMercancias = async (req, res) => {
  const response = await pool.query('SELECT * FROM tabReciboMercancia LIMIT 100');
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');
  }
  res.status(200).json(response.rows);
};

const getKardex = async (req, res) => {
  const response = await pool.query('SELECT * FROM tabKardex LIMIT 100');
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');
  }
  res.status(200).json(response.rows);
};

const getUsuarios = async (req, res) => {
  const response = await pool.query('SELECT * FROM tabUsuario LIMIT 100');
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');
  }
  res.status(200).json(response.rows);
};

const getPermisos = async (req, res) => {
  const response = await pool.query('SELECT * FROM tabPermiso LIMIT 100');
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');
  }
  res.status(200).json(response.rows);
};

const getUsuarioPermisos = async (req, res) => {
  const response = await pool.query('SELECT * FROM tabUsuarioPermiso LIMIT 100');
  if (!response.rows.length) {
    console.log('No se encontraron registros en la base de datos');
    throw new ErrorDeBaseDeDatos('Los datos no se encontraron en la base de datos');
  }
  res.status(200).json(response.rows);
};

//Aplicar el middleware de manejo de errores al controlador
export const getClientesWithManejoErrores = manejoErrores(getClientes);
export const getProveedoresWithManejoErrores = manejoErrores(getProveedores);
export const getMarcasWithManejoErrores = manejoErrores(getMarcas);
export const getCategoriasWithManejoErrores = manejoErrores(getCategorias);
export const getArticulosWithManejoErrores = manejoErrores(getArticulos);
export const getReciboMercanciasWithManejoErrores = manejoErrores(getReciboMercancias);
export const getKardexWithManejoErrores = manejoErrores(getKardex);
export const getUsuariosWithManejoErrores = manejoErrores(getUsuarios);
export const getPermisosWithManejoErrores = manejoErrores(getPermisos);
export const getUsuarioPermisosWithManejoErrores = manejoErrores(getUsuarioPermisos);


export const getClienteById = async (req, res) => {
  const id = req.params.id;
  const response = await pool.query('SELECT * FROM tabCliente WHERE idCli = $1', [id]);
  res.json(response.rows);
};

export const getProveedorById = async (req, res) => {
  const id = req.params.id;
  const response = await pool.query('SELECT * FROM tabProveedor WHERE idProv = $1', [id]);
  res.json(response.rows);
};

export const getMarcaById = async (req, res) => {
  const id = req.params.id;
  const response = await pool.query('SELECT * FROM tabMarca WHERE consecMarca = $1', [id]);
  res.json(response.rows);
};

export const getCategoriaById = async (req, res) => {
  const id = req.params.id;
  const response = await pool.query('SELECT * FROM tabCategoria WHERE consecCategoria = $1', [id]);
  res.json(response.rows);
};

export const getArticuloById = async (req, res) => {
  const id = req.params.id;
  const response = await pool.query('SELECT * FROM tabArticulo WHERE eanArticulo= $1', [id]);
  res.json(response.rows);
};

export const getReciboMercanciaById = async (req, res) => {
  const id = req.params.id;
  const response = await pool.query('SELECT * FROM tabReciboMercancia WHERE consecReciboMcia = $1', [id]);
  res.json(response.rows);
};

export const getKardexById = async (req, res) => {
  const id = req.params.id;
  const response = await pool.query('SELECT * FROM tabKardex WHERE consecKardex = $1', [id]);
  res.json(response.rows);
};

export const getUsuarioById = async (req, res) => {
  const id = req.params.id;
  const response = await pool.query('SELECT * FROM tabUsuario WHERE idUsuario = $1', [id]);
  res.json(response.rows);
};

export const getPermisoById = async (req, res) => {
  const id = req.params.id;
  const response = await pool.query('SELECT * FROM tabPermiso WHERE idPermiso = $1', [id]);
  res.json(response.rows);
};

export const getUsuarioPermisoById = async (req, res) => {
  const id = req.params.id;
  const response = await pool.query('SELECT * FROM tabUsuarioPermiso WHERE consecUsuarioPermiso = $1', [id]);
  res.json(response.rows);
};

export const insertCliente = async (req, res) => {
  const { idCli, tipoCli, nomCli, apeCli, nomRepLegal, nomEmpresa, telCli, emailCli, dirCli  } = req.body;

  try {
    const response = await pool.query('SELECT insertCliente($1, $2, $3, $4, $5, $6, $7, $8, $9)', 
      [idCli, tipoCli, nomCli, apeCli, nomRepLegal, nomEmpresa, telCli, emailCli, dirCli ]);
    console.log(response);
    res.json({
      message: 'Cliente Registrado con éxito',
      body: {
        Cliente: {idCli, tipoCli, nomCli, apeCli, nomRepLegal, nomEmpresa, telCli, emailCli, dirCli},
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: 'Error al registrar cliente',
    });
  }
};

export const insertProveedor = async (req, res) => {
  const { idProv, nomProv, telProv, emailProv, dirProv } = req.body;

  try {
    const response = await pool.query('SELECT insertProveedor($1, $2, $3, $4, $5)', 
      [idProv, nomProv, telProv, emailProv, dirProv ]);
    console.log(response);
    res.json({
      message: 'Proveedor Registrado con éxito',
      body: {
        Proveedor: {idProv, nomProv, telProv, emailProv, dirProv},
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: 'Error al registrar Proveedor',
    });
  }
};

export const insertMarca = async (req, res) => {
  const { nomMarca } = req.body;

  try {
    const response = await pool.query('SELECT insertMarca($1)', [nomMarca]);
    console.log(response);
    res.json({
      message: 'Marca Registrada con éxito',
      body: {
        Marca: { nomMarca },
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: 'Error al registrar la marca',
    });
  }
};

export const insertCategoria = async (req, res) => {
  const { nomCateg } = req.body;

  try {
    const response = await pool.query('SELECT insertCategoria($1)', [nomCateg]);
    console.log(response);
    res.json({
      message: 'Categoria Registrada con éxito',
      body: {
        Categoria: {nomCateg},
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: 'Error al registrar Categoria',
    });
  }
};

export const insertArticulo = async (req, res) => {
  const { eanArt, nomArt, consecMarca, consecCateg, descArt, porcentaje, iva, stockMin, stockMax, valReorden, fecVence } = req.body;

  try {
    const response = await pool.query('SELECT insertArticulo($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)', 
      [eanArt, nomArt, consecMarca, consecCateg, descArt, porcentaje, iva, stockMin, stockMax, valReorden, fecVence]);
    console.log(response);
    res.json({
      message: 'Artículo Registrado con éxito',
      body: {
        Articulo: {eanArt, nomArt, consecMarca, consecCateg, descArt, porcentaje, iva, stockMin, stockMax, valReorden, fecVence},
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: 'Error al registrar Categoria',
    });
  }
};

export const insertReciboMercancia = async (req, res) => {
  const { eanArt, cantArt, valCompra, idProv, consecMarca, observacion } = req.body;

  try {
    const response = await pool.query('SELECT insertReciboMercancia($1, $2, $3, $4, $5, $6)', 
      [eanArt, cantArt, valCompra, idProv,  consecMarca, observacion]);
    console.log(response);
    res.json({
      message: 'Entrada Registrada con éxito',
      body: {
        ReciboMercancia: {eanArt, cantArt, valCompra, idProv,  consecMarca, observacion},
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: 'Error al registrar Entrada',
    });
  }
};

export const insertEncabezadoVenta = async (req, res) => {
  const { tipoFactura, idCli, ciudad } = req.body;

  try {
    const response = await pool.query('SELECT insertEncVenta($1, $2, $3)', 
      [tipoFactura, idCli, ciudad]);
    console.log(response);
    res.json({
      message: 'Encabezado de Venta Registrado con éxito',
      body: {
        EncabezadoVenta: {tipoFactura, idCli, ciudad},
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: 'Error al registrar Encabezado de Venta',
    });
  }
};

export const insertDetalleVenta = async (req, res) => {
  const { eanArt, cantArt, descuento } = req.body;

  try {
    const response = await pool.query('SELECT insertDetalleVenta($1, $2, $3)', 
      [eanArt, cantArt, descuento]);
    console.log(response);
    res.json({
      message: 'Detalle venta Registrado con éxito',
      body: {
        DetalleVenta: {eanArt, cantArt, descuento },
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: 'Error al registrar Detalle de Venta',
    });
  }
};

export const insertUsuario = async (req, res) => {
  const { idUsuario, nomUsuario, apeUsuario, emailUsuario, usuario, password } = req.body;

  try {
    const response = await pool.query('SELECT insertUsuario($1, $2, $3, $4, $5, $6)', 
      [idUsuario, nomUsuario, apeUsuario, emailUsuario, usuario, password]);
    console.log(response);
    res.json({
      message: 'Usuario Registrado con éxito',
      body: {
        Usuario: {idUsuario, nomUsuario, apeUsuario, emailUsuario, usuario, password},
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: 'Error al registrar Usuario',
    });
  }
};

export const insertPermiso = async (req, res) => {
  const { nomPermiso, descPermiso } = req.body;

  try {
    const response = await pool.query('SELECT insertPermiso($1, $2)', 
      [nomPermiso, descPermiso]);
    console.log(response);
    res.json({
      message: 'Permiso Registrado con éxito',
      body: {
        Permiso: {nomPermiso, descPermiso},
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: 'Error al registrar Permiso',
    });
  }
};

export const insertUsuarioPermiso = async (req, res) => {
  const { idUsuario, consecPermiso } = req.body;

  try {
    const response = await pool.query('SELECT asignarPermisoUsuario($1, $2)', 
      [idUsuario, consecPermiso]);
    console.log(response);
    res.json({
      message: 'Permisos por usuario Registrado con éxito',
      body: {
        usuarioPermiso: {idUsuario, consecPermiso},
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: 'Error al registrar Permisos por Usuario',
    });
  }
};

export const updateCliente = async (req, res) => {
  const id = req.params.id;
  const { idCli, tipoCli, nomCli, apeCli, nomRepLegal, nomEmpresa, telCli, emailCli, dirCli } = req.body;

  try {
    const response = await pool.query(
      'UPDATE tabCliente SET idCli = $1, tipoCli = $2, nomCli = $3, apeCli = $4, nomRepLegal = $5, nomEmpresa = $6, telCli = $7, emailCli = $8, dirCli = $9 WHERE idCli = $10',
      [idCli, tipoCli, nomCli, apeCli, nomRepLegal, nomEmpresa, telCli, emailCli, dirCli, id]
    );

    console.log(response);
    res.send('Cliente Actualizado con éxito');
  } catch (error) {
    console.error('Error al actualizar datos del Cliente:', error);
    res.status(500).send('Error al actualizar datos del Cliente');
  }
};

export const updateProveedor = async (req, res) => {
  const id = req.params.id;
  const { idProv, nomProv, telProv, emailProv, dirProv } = req.body;

  try {
    const response = await pool.query(
      'UPDATE tabProveedor SET idProv = $1, nomProv = $2, telProv = $3, emailProv = $4, dirProv = $5 WHERE idProv = $6',
      [idProv, nomProv, telProv, emailProv, dirProv, id]
    );

    console.log(response);
    res.send('Proveedor Actualizado con éxito');
  } catch (error) {
    console.error('Error al actualizar datos del Proveedor:', error);
    res.status(500).send('Error al actualizar datos del Proveedor');
  }
};

export const updateMarca = async (req, res) => {
  const id = req.params.id;
  const { nomMarca } = req.body;

  try {
    const response = await pool.query(
      'UPDATE tabMarca SET nomMarca = $1 WHERE consecMarca = $2',
      [nomMarca, id]
    );

    console.log(response);
    res.send('Marca Actualizada con éxito');
  } catch (error) {
    console.error('Error al actualizar marca:', error);
    res.status(500).send('Error al actualizar marca');
  }
};

export const updateCategoria = async (req, res) => {
  const id = req.params.id;
  const { nomCateg } = req.body;

  try {
   
    const response = await pool.query(
      'UPDATE tabCategoria SET nomCateg = $1 WHERE consecCateg = $2',
      [nomCateg, id]
    );

    console.log(response);
    res.send('Categoría Actualizada con éxito');
  } catch (error) {
    console.error('Error al actualizar categoría:', error);
    res.status(500).send('Error al actualizar categoría');
  }
};

export const updateArticulo = async (req, res) => {
  const id = req.params.id;
  const { eanArt, nomArt, consecMarca, consecCateg, descArt, porcentaje, iva, stockMin, stockMax, valReorden, fecVence } = req.body;

  try {
    
    const response = await pool.query(
      'UPDATE tabArticulo SET eanArt = $1, nomArt = $2, consecMarca = $3, consecCateg = $4, descArt = $5, porcentaje = $6, iva = $7, stockMin = $8, stockMax = $9, valReorden = $10, fecVence = $11 WHERE eanArt = $12',
      [eanArt, nomArt, consecMarca, consecCateg, descArt, porcentaje, iva, stockMin, stockMax, valReorden, fecVence, id]
    );

    console.log(response);
    res.send('Artículo Actualizado con éxito');
  } catch (error) {
    console.error('Error al actualizar artículo:', error);
    res.status(500).send('Error al actualizar artículo');
  }
};

export const updateUsuario = async (req, res) => {
  const id = req.params.id;
  const { idUsuario, nomUsuario, apeUsuario, emailUsuario, usuario, password } = req.body;

  try {
    
    const response = await pool.query(
      'UPDATE tabUsuario SET idUsuario = $1, nomUsuario = $2, apeUsuario = $3, emailUsuario = $4, usuario = $5, password = $6 WHERE idUsuario = $7',
      [idUsuario, nomUsuario, apeUsuario, emailUsuario, usuario, password, id]
    );

    console.log(response);
    res.send('Usuario Actualizado con éxito');
  } catch (error) {
    console.error('Error al actualizar usuario:', error);
    res.status(500).send('Error al actualizar usuario');
  }
};

export const updatePermiso = async (req, res) => {
  const id = req.params.id;
  const { nomPermiso, descPermiso } = req.body;

  try {
    
    const response = await pool.query(
      'UPDATE tabPermiso SET nomPermiso = $1, descPermiso = $2 WHERE consecPermiso = $3',
      [nomPermiso, descPermiso, id]
    );

    console.log(response);
    res.send('Permiso Actualizado con éxito');
  } catch (error) {
    console.error('Error al actualizar permiso:', error);
    res.status(500).send('Error al actualizar permiso');
  }
};

export const updateUsuarioPermiso = async (req, res) => {
  const id = req.params.id;
  const { idUsuario, consecPermiso } = req.body;

  try {
    
    const response = await pool.query(
      'UPDATE tabUsuarioPermiso SET idUsuario = $1, consecPermiso = $2 WHERE consecUsuarioPermiso = $3',
      [idUsuario, consecPermiso, id]
    );

    console.log(response);
    res.send('Permisos por Usuario Actualizado con éxito');
  } catch (error) {
    console.error('Error al actualizar permisos por usuario:', error);
    res.status(500).send('Error al actualizar permisos por usuario');
  }
};

export const deleteCliente = async (req, res) => {
  const id = req.params.id;

  try {
    const response = await pool.query('DELETE FROM tabCliente WHERE idCli = $1', [id]);
    console.log(response);
    res.send('Cliente Eliminado con éxito');
  } catch (error) {
    console.error('Error al eliminar Cliente:', error);
    res.status(500).send('Error al eliminar Cliente');
  }
};

export const deleteProveedor = async (req, res) => {
  const id = req.params.id;

  try {
    const response = await pool.query('DELETE FROM tabProveedor WHERE idProv = $1', [id]);
    console.log(response);
    res.send('Proveedor Eliminado con éxito');
  } catch (error) {
    console.error('Error al eliminar Proveedor:', error);
    res.status(500).send('Error al eliminar Proveedor');
  }
};

export const deleteMarca = async (req, res) => {
  const id = req.params.id;

  try {
    const response = await pool.query('DELETE FROM tabMarca WHERE consecMarca = $1', [id]);
    console.log(response);
    res.send('Marca Eliminada con éxito');
  } catch (error) {
    console.error('Error al eliminar Marca:', error);
    res.status(500).send('Error al eliminar Marca');
  }
};

export const deleteCategoria = async (req, res) => {
  const id = req.params.id;

  try {
    const response = await pool.query('DELETE FROM tabCategoria WHERE consecCateg = $1', [id]);
    console.log(response);
    res.send('Categoría Eliminada con éxito');
  } catch (error) {
    console.error('Error al eliminar Categoría:', error);
    res.status(500).send('Error al eliminar Categoría');
  }
};

export const deleteArticulo = async (req, res) => {
  const id = req.params.id;

  try {
    const response = await pool.query('DELETE FROM tabArticulo WHERE eanArt = $1', [id]);
    console.log(response);
    res.send('Artículo Eliminado con éxito');
  } catch (error) {
    console.error('Error al eliminar Artículo:', error);
    res.status(500).send('Error al eliminar Artículo');
  }
};

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

export const deletePermiso = async (req, res) => {
  const id = req.params.id;

  try {
    const response = await pool.query('DELETE FROM tabPermiso WHERE consecPermiso = $1', [id]);
    console.log(response);
    res.send('Permiso Eliminado con éxito');
  } catch (error) {
    console.error('Error al eliminar Permiso:', error);
    res.status(500).send('Error al eliminar Permiso');
  }
};

export const deleteUsuarioPermiso = async (req, res) => {
  const id = req.params.id;

  try {
    const response = await pool.query('DELETE FROM tabUsuarioPermiso WHERE consecUsuarioPermiso = $1', [id]);
    console.log(response);
    res.send('Permisos por Usuario Eliminado con éxito');
  } catch (error) {
    console.error('Error al eliminar Permisos por Usuario:', error);
    res.status(500).send('Error al eliminar Permisos por Usuario');
  }
};



