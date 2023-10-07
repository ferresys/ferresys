
//conexion a la base de datos
const { Pool } = require('pg');



const pool = new Pool({
	host: 'localhost',
  	user: 'postgres',
  	password: 'Escorpio11',
  	database: 'Ferreteria',
  	port: '5432'
});



//función consultas generales a la base de datos.
const getClientes = async (req, res) =>{
	
	const response = await pool.query('SELECT *FROM tabCliente LIMIT 100');
	/*console.log(response.rows);
	res.send('clientes');*/// para ver por consola
	res.status(200).json(response.rows);
};

const getProveedores = async (req, res) =>{
	
	const response = await pool.query('SELECT *FROM tabProveedor LIMIT 100');
	/*console.log(response.rows);
	res.send('proveedores');*/// para ver por consola
	res.status(200).json(response.rows);
};

const getMarcas= async (req, res) =>{
	
	const response = await pool.query('SELECT * FROM tabMarca LIMIT 100');
	/*console.log(response.rows);
	res.send('Marcas');*/// para ver por consola
	res.status(200).json(response.rows);
};

const getCategorias = async (req, res) =>{
	
	const response = await pool.query('SELECT *FROM tabCategoria LIMIT 100');
	/*console.log(response.rows);
	res.send('categorias');*/// para ver por consola
	res.status(200).json(response.rows);
};

const getArticulos = async (req, res) =>{
	
	const response = await pool.query('SELECT *FROM tabArticulo LIMIT 100');
	/*console.log(response.rows);
	res.send('articulos');*/// para ver por consola
	res.status(200).json(response.rows);
};

const getReciboMercancias = async (req, res) =>{
	
	const response = await pool.query('SELECT *FROM tabReciboMercancia LIMIT 100');
	/*console.log(response.rows);
	res.send('recibo Mercancia');*/// para ver por consola
	res.status(200).json(response.rows);
};

const getKardex = async (req, res) =>{
	
	const response = await pool.query('SELECT *FROM tabKardex LIMIT 100');
	/*console.log(response.rows);
	res.send('kardex');*/// para ver por consola
	res.status(200).json(response.rows);
};

const getUsuarios = async (req, res) =>{
	
	const response = await pool.query('SELECT *FROM tabUsuario LIMIT 100');
	/*console.log(response.rows);
	res.send('usuarios');*/// para ver por consola
	res.status(200).json(response.rows);
};

const getPermisos= async (req, res) =>{
	
	const response = await pool.query('SELECT *FROM tabPermiso LIMIT 100');
	/*console.log(response.rows);
	res.send('permisos');*/// para ver por consola
	res.status(200).json(response.rows);
};

const getUsuarioPermisos = async (req, res) =>{
	
	const response = await pool.query('SELECT *FROM tabUsuarioPermiso LIMIT 100');
	/*console.log(response.rows);
	res.send('usuario permisos');*/// para ver por consola
	res.status(200).json(response.rows);
};



//función consultas por ID a la base de datos.
const getClienteById = async (req,res) => {
	//res.send('ID Cliente' + req.params.id)
	const id = req.params.id;
	const response = await pool.query('SELECT * FROM tabCliente WHERE idCli = $1', [id]);
	res.json(response.rows);
};

const getProveedorById = async (req,res) => {
	//res.send('ID proveedor' + req.params.id)
	const id = req.params.id;
	const response = await pool.query('SELECT * FROM tabProveedor WHERE idProv = $1', [id]);
	res.json(response.rows);
};

const getMarcaById = async (req,res) => {
	//res.send('Consec Marca' + req.params.id)
	const id = req.params.id;
	const response = await pool.query('SELECT * FROM tabMarca WHERE consecMarca = $1', [id]);
	res.json(response.rows);
};

const getCategoriaById = async (req,res) => {
	//res.send('Consec categoria' + req.params.id)
	const id = req.params.id;
	const response = await pool.query('SELECT * FROM tabCategoria WHERE consecCategoria = $1', [id]);
	res.json(response.rows);
};

const getArticuloById = async (req,res) => {
	//res.send('EAN articulo' + req.params.id)
	const id = req.params.id;
	const response = await pool.query('SELECT * FROM tabArticulo WHERE eanArticulo= $1', [id]);
	res.json(response.rows);
};

const getReciboMercanciaById = async (req,res) => {
	//res.send('Consec Recibo Mercancia' + req.params.id)
	const id = req.params.id;
	const response = await pool.query('SELECT * FROM tabReciboMercancia WHERE consecReciboMcia = $1', [id]);
	res.json(response.rows);
};

const getKardexById = async (req,res) => {
	//res.send('Consec Kardex' + req.params.id)
	const id = req.params.id;
	const response = await pool.query('SELECT * FROM tabKardex WHERE consecKardex = $1', [id]);
	res.json(response.rows);
};

const getUsuarioById = async (req,res) => {
	//res.send('ID Usuario' + req.params.id)
	const id = req.params.id;
	const response = await pool.query('SELECT * FROM tabUsuario WHERE idUsuario = $1', [id]);
	res.json(response.rows);
};

const getPermisoById = async (req,res) => {
	//res.send('ID Permiso' + req.params.id)
	const id = req.params.id;
	const response = await pool.query('SELECT * FROM tabPermiso WHERE idPermiso = $1', [id]);
	res.json(response.rows);
};

const getUsuarioPermisoById = async (req,res) => {
	//res.send('consec Usuario Permiso' + req.params.id)
	const id = req.params.id;
	const response = await pool.query('SELECT * FROM tabUsuarioPermiso WHERE consecUsuarioPermiso = $1', [id]);
	res.json(response.rows);
};

/*
//función insertar datos a la base de datos.
const insertMarca = async (req, res) => {
	/*console.log(req.body);
	res.send('Marca registrada con éxito');
	const {nomMarca} = req.body;

	const response = await pool.query('INSERT INTO tabMarca (nomMarca) VALUES ($1)', [nomMarca]);
		console.log(response);
		//res.send('Marca registrada con éxito');
		res.json({
			message: 'Marca Registrada con éxito',
			body: {
				Marca:{nomMarca}
			}
		})
};*/

//función insertar datos a la base de datos.

const insertCliente = async (req, res) => {
  const { idCli, tipoCli, nomCli, apeCli, nomRepLegal, nomEmpresa, telCli, emailCli, dirCli  } = req.body;

  try {
    const response = await pool.query('SELECT insertCliente($1, $2, $3, $4, $5, $6, $7, $8, $9)', 
    	[idCli, tipoCli, nomCli, apeCli, nomRepLegal, nomEmpresa, telCli, emailCli, dirCli ]);
    console.log(response);
    res.json({
      message: 'Cliente RegistradO con éxito',
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


const insertProveedor = async (req, res) => {
  const { idProv, nomProv, telProv, emailProv, dirProv } = req.body;

  try {
    const response = await pool.query('SELECT insertProveedor($1, $2, $3, $4, $5)', 
    	[idProv, nomProv, telProv, emailProv, dirProv ]);
    console.log(response);
    res.json({
      message: 'Proveedor RegistradO con éxito',
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


const insertMarca = async (req, res) => {
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


const insertCategoria = async (req, res) => {
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


const insertArticulo = async (req, res) => {
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


const insertReciboMercancia = async (req, res) => {
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



const insertEncabezadoVenta = async (req, res) => {
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


const insertDetalleVenta = async (req, res) => {
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


const insertUsuario = async (req, res) => {
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



const insertPermiso = async (req, res) => {
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


const insertUsuarioPermiso = async (req, res) => {
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



//función actualizar datos a la base de datos.
/*const updateMarca = async (req, res) => {

	const id= req.params.id;
	const {nomMarca} = req.body;
	//console.log(id,nomMarca); para que me muestre los datos actualizados, es solo prueba ya que aun no inserta nada
	//res.send('Marca Actualizada con éxito');lo que se muestra al usuario, en este caso en postman
	const response = await pool.query('UPDATE tabMarca SET nomMarca = $1 WHERE consecMarca= $2',[nomMarca, id]); 
	console.log(response);
	res.send('Marca Actualizada con éxito');
};*/

const updateCliente = async (req, res) => {
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


const updateProveedor = async (req, res) => {
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


const updateMarca = async (req, res) => {
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


const updateCategoria = async (req, res) => {
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


const updateArticulo = async (req, res) => {
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

const updateUsuario = async (req, res) => {
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


const updatePermiso = async (req, res) => {
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


const updateUsuarioPermiso = async (req, res) => {
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


//función eliminar datos a la base de datos.
const deleteCliente = async (req, res) => {
  try {
    const id = req.params.id;
    const response = await pool.query('DELETE FROM tabCliente WHERE idCli = $1', [id]);
    console.log(response);
    res.json(`Cliente ${id} Eliminado con éxito`);
  } catch (error) {
    console.error('Error al eliminar cliente:', error);
    res.status(500).send('Error al eliminar cliente');
  }
};

const deleteProveedor = async (req, res) => {
  try {
    const id = req.params.id;
    const response = await pool.query('DELETE FROM tabProveedor WHERE idProv = $1', [id]);
    console.log(response);
    res.json(`Proveedor ${id} Eliminado con éxito`);
  } catch (error) {
    console.error('Error al eliminar proveedor:', error);
    res.status(500).send('Error al eliminar proveedor');
  }
};


const deleteCategoria = async (req, res) => {
  try {
    const id = req.params.id;
    const response = await pool.query('DELETE FROM tabCategoria WHERE consecCateg = $1', [id]);
    console.log(response);
    res.json(`Categoria ${id} Eliminada con éxito`);
  } catch (error) {
    console.error('Error al eliminar categoria:', error);
    res.status(500).send('Error al eliminar categoria');
  }
};

const deleteArticulo = async (req, res) => {
  try {
    const id = req.params.id;
    const response = await pool.query('DELETE FROM tabArticulo WHERE eanArt = $1', [id]);
    console.log(response);
    res.json(`Articulo ${id} Eliminado con éxito`);
  } catch (error) {
    console.error('Error al eliminar articulo:', error);
    res.status(500).send('Error al eliminar articulo');
  }
};

const deleteUsuario = async (req, res) => {
  try {
    const id = req.params.id;
    const response = await pool.query('DELETE FROM tabUsuario WHERE idUsuario = $1', [id]);
    console.log(response);
    res.json(`Usuario ${id} Eliminado con éxito`);
  } catch (error) {
    console.error('Error al eliminar usuario:', error);
    res.status(500).send('Error al eliminar usuario');
  }
};

const deletePermiso = async (req, res) => {
  try {
    const id = req.params.id;
    const response = await pool.query('DELETE FROM tabPermiso WHERE idPermiso = $1', [id]);
    console.log(response);
    res.json(`Permiso ${id} Eliminado con éxito`);
  } catch (error) {
    console.error('Error al eliminar permiso:', error);
    res.status(500).send('Error al eliminar permiso');
  }
};

const deleteUsuarioPermiso = async (req, res) => {
  try {
    const id = req.params.id;
    const response = await pool.query('DELETE FROM tabUsuarioPermiso WHERE consecUsuarioPermiso = $1', [id]);
    console.log(response);
    res.json(`Registro ${id} Eliminado con éxito`);
  } catch (error) {
    console.error('Error al eliminar registro:', error);
    res.status(500).send('Error al eliminar registro');
  }
};


//exportacion de funciones.
module.exports = {
	getClientes,
	getProveedores,
	getMarcas,
	getCategorias,
	getArticulos,
	getReciboMercancias,
	getKardex,
	getUsuarios,
	getPermisos,
	getUsuarioPermisos,

	getClienteById,
	getProveedorById,
	getMarcaById,
	getCategoriaById,
	getArticuloById,
	getReciboMercanciaById,
	getKardexById,
	getUsuarioById,
	getPermisoById,
	getUsuarioPermisoById,

	
	insertCliente,
	insertProveedor,
	insertMarca,
	insertCategoria,
	insertArticulo,
	insertReciboMercancia,
	insertEncabezadoVenta,
	insertDetalleVenta,
	insertUsuario,
	insertPermiso,
	insertUsuarioPermiso,


	
	updateCliente,
	updateProveedor,
	updateMarca,
	updateCategoria,
	updateArticulo,
	updateUsuario,
	updatePermiso,
	updateUsuarioPermiso,

	deleteCliente,
	deleteProveedor,
	deleteCategoria,
	deleteArticulo,
	deleteUsuario,
	deletePermiso,
	deleteUsuarioPermiso,

}


