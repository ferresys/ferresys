
const { Pool } = require('pg');



const pool = new Pool({
	host: 'localhost',
  	user: 'postgres',
  	password: '',
  	database: 'dbFerreSys',
  	port: '5432'
});


const getClientes = async (req, res) =>{
	
	const response = await pool.query('SELECT *FROM tabCliente LIMIT 100');
	/*console.log(response.rows);
	res.send('clientes');*/// para ver por consola
	res.status(200).json(response.rows);
};

const getProveedores = async (req, res) =>{
	
	const response = await pool.query('SELECT *FROM tabProveedor LIMIT 100');
	/*console.log(response.rows);
	res.send('clientes');*/// para ver por consola
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
	res.send('clientes');*/// para ver por consola
	res.status(200).json(response.rows);
};

const getArticulos = async (req, res) =>{
	
	const response = await pool.query('SELECT *FROM tabArticulo LIMIT 100');
	/*console.log(response.rows);
	res.send('clientes');*/// para ver por consola
	res.status(200).json(response.rows);
};

const getReciboMercancias = async (req, res) =>{
	
	const response = await pool.query('SELECT *FROM tabReciboMercancia LIMIT 100');
	/*console.log(response.rows);
	res.send('clientes');*/// para ver por consola
	res.status(200).json(response.rows);
};

const getKardex = async (req, res) =>{
	
	const response = await pool.query('SELECT *FROM tabKardex LIMIT 100');
	/*console.log(response.rows);
	res.send('clientes');*/// para ver por consola
	res.status(200).json(response.rows);
};

const getUsuarios = async (req, res) =>{
	
	const response = await pool.query('SELECT *FROM tabUsuario LIMIT 100');
	/*console.log(response.rows);
	res.send('clientes');*/// para ver por consola
	res.status(200).json(response.rows);
};

const getPermisos= async (req, res) =>{
	
	const response = await pool.query('SELECT *FROM tabPermiso LIMIT 100');
	/*console.log(response.rows);
	res.send('clientes');*/// para ver por consola
	res.status(200).json(response.rows);
};

const getUsuarioPermisos = async (req, res) =>{
	
	const response = await pool.query('SELECT *FROM tabUsuarioPermiso LIMIT 100');
	/*console.log(response.rows);
	res.send('clientes');*/// para ver por consola
	res.status(200).json(response.rows);
};

const getMarcaById = async (req,res) => {
	//res.send('Consec Marca' + req.params.id)
	const id = req.params.id;
	const response = await pool.query('SELECT * FROM tabMarca WHERE consecMarca = $1', [id]);
	res.json(response.rows);
};

const getCategoriaById = async (req,res) => {
	//res.send('Consec Marca' + req.params.id)
	const id = req.params.id;
	const response = await pool.query('SELECT * FROM tabCategoria WHERE consecCategoria = $1', [id]);
	res.json(response.rows);
};

const getClienteById = async (req,res) => {
	//res.send('Consec Marca' + req.params.id)
	const id = req.params.id;
	const response = await pool.query('SELECT * FROM tabCliente WHERE idCli = $1', [id]);
	res.json(response.rows);
};

const getProveedorById = async (req,res) => {
	//res.send('Consec Marca' + req.params.id)
	const id = req.params.id;
	const response = await pool.query('SELECT * FROM tabProveedor WHERE idProv = $1', [id]);
	res.json(response.rows);
};

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

const updateMarca = async (req, res) => {

	const id= req.params.id;
	const {nomMarca} = req.body;
	//console.log(id,nomMarca); para que me muestre los datos actualizados, es solo prueba ya que aun no inserta nada
	//res.send('Marca Actualizada con éxito');lo que se muestra al usuario, en este caso en postman
	const response = await pool.query('UPDATE tabMarca SET nomMarca = $1 WHERE consecMarca= $2',[nomMarca, id]); 
	console.log(response);
	res.send('Marca Actualizada con éxito');
};

const deleteMarca = async (req, res) => {
	//res.send('Marca Eliminada con éxito' + req.params.id); para probar si nos funciona " solo mostrara mensaje pero no hara nada en la db"
	const id= req.params.id;
	const response = await pool.query('DELETE FROM tabMarca WHERE consecMarca = $1', [id]);
	console.log(response);
	res.json(`Marca' ${id} Eliminada con éxito`);
};

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
	getMarcaById,
	getCategoriaById,
	getClienteById,
	getProveedorById,
	insertMarca,
	updateMarca,
	deleteMarca,

}


