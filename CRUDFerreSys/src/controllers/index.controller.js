
//conexion a la base de datos
const { Pool } = require('pg');



const pool = new Pool({
	host: 'localhost',
  	user: 'postgres',
  	password: '',
  	database: 'dbFerreSys',
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


//función insertar datos a la base de datos.
const insertMarca = async (req, res) => {
	/*console.log(req.body);
	res.send('Marca registrada con éxito');*/
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
};


//función actualizar datos a la base de datos.
const updateMarca = async (req, res) => {

	const id= req.params.id;
	const {nomMarca} = req.body;
	//console.log(id,nomMarca); para que me muestre los datos actualizados, es solo prueba ya que aun no inserta nada
	//res.send('Marca Actualizada con éxito');lo que se muestra al usuario, en este caso en postman
	const response = await pool.query('UPDATE tabMarca SET nomMarca = $1 WHERE consecMarca= $2',[nomMarca, id]); 
	console.log(response);
	res.send('Marca Actualizada con éxito');
};


//función eliminar datos a la base de datos.
const deleteCliente= async (req, res) => {
	//res.send('Cliente Eliminado con éxito' + req.params.id); para probar si nos funciona " solo mostrara mensaje pero no hara nada en la db"
	const id= req.params.id;
	const response = await pool.query('DELETE FROM tabCliente WHERE idCli = $1', [id]);
	console.log(response);
	res.json(`Cliente' ${id} Eliminado con éxito`);
};

const deleteProveedor= async (req, res) => {
	//res.send('Proveedor Eliminado con éxito' + req.params.id); para probar si nos funciona " solo mostrara mensaje pero no hara nada en la db"
	const id= req.params.id;
	const response = await pool.query('DELETE FROM tabProveedor WHERE idProv = $1', [id]);
	console.log(response);
	res.json(`Proveedor' ${id} Eliminado con éxito`);
};

const deleteMarca = async (req, res) => {
	//res.send('Marca Eliminada con éxito' + req.params.id); para probar si nos funciona " solo mostrara mensaje pero no hara nada en la db"
	const id= req.params.id;
	const response = await pool.query('DELETE FROM tabMarca WHERE consecMarca = $1', [id]);
	console.log(response);
	res.json(`Marca' ${id} Eliminada con éxito`);
};

const deleteCategoria= async (req, res) => {
	//res.send('Categoria Eliminado con éxito' + req.params.id); para probar si nos funciona " solo mostrara mensaje pero no hara nada en la db"
	const id= req.params.id;
	const response = await pool.query('DELETE FROM tabCategoria WHERE consecCategoria = $1', [id]);
	console.log(response);
	res.json(`Categoria' ${id} Eliminada con éxito`);
};

const deleteArticulo= async (req, res) => {
	//res.send('Articulo Eliminado con éxito' + req.params.id); para probar si nos funciona " solo mostrara mensaje pero no hara nada en la db"
	const id= req.params.id;
	const response = await pool.query('DELETE FROM tabArticulo WHERE eanArticulo = $1', [id]);
	console.log(response);
	res.json(`Articulo' ${id} Eliminado con éxito`);
};


const deleteUsuario= async (req, res) => {
	//res.send('Usuario Eliminado con éxito' + req.params.id); para probar si nos funciona " solo mostrara mensaje pero no hara nada en la db"
	const id= req.params.id;
	const response = await pool.query('DELETE FROM tabUsuario WHERE idUsuario = $1', [id]);
	console.log(response);
	res.json(`Usuario' ${id} Eliminado con éxito`);
};

const deletePermiso= async (req, res) => {
	//res.send('Permiso Eliminado con éxito' + req.params.id); para probar si nos funciona " solo mostrara mensaje pero no hara nada en la db"
	const id= req.params.id;
	const response = await pool.query('DELETE FROM tabPermiso WHERE idPermiso = $1', [id]);
	console.log(response);
	res.json(`Permiso' ${id} Eliminado con éxito`);
};

const deleteUsuarioPermiso= async (req, res) => {
	//res.send('Registro Eliminado con éxito' + req.params.id); para probar si nos funciona " solo mostrara mensaje pero no hara nada en la db"
	const id= req.params.id;
	const response = await pool.query('DELETE FROM tabUsuarioPermiso WHERE consecUsuarioPermiso = $1', [id]);
	console.log(response);
	res.json(`Registro' ${id} Eliminado con éxito`);
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

	insertMarca,

	updateMarca,

	deleteCliente,
	deleteProveedor,
	deleteMarca,
	deleteCategoria,
	deleteArticulo,
	deleteUsuario,
	deletePermiso,
	deleteUsuarioPermiso,

}


