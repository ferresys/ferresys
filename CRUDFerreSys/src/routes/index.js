const { Router } = require('express');
const router = Router();

const {getClientes, getProveedores, getMarcas, getCategorias, getArticulos, getReciboMercancias, getKardex, getUsuarios, getPermisos, getUsuarioPermisos,  
getClienteById, getProveedorById, getMarcaById, getCategoriaById, insertMarca, updateMarca, deleteMarca}= require('../controllers/index.controller')
 
//consultas generales
router.get('/clientes', getClientes);
router.get('/proveedores', getProveedores);
router.get('/marcas', getMarcas);
router.get('/categorias', getCategorias);
router.get('/articulos', getArticulos);
router.get('/reciboMercancias', getReciboMercancias);
router.get('/kardex', getKardex);
router.get('/usuarios', getUsuarios);
router.get('/permisos', getPermisos);
router.get('/usuarioPermisos', getUsuarioPermisos);


//consultas por id .

router.get('/clientes/:id', getClienteById);
router.get('/proveedores/:id', getProveedorById);
router.get('/marcas/:id', getMarcaById);
router.get('/categorias/:id', getCategoriaById);


// insertar datos
router.post('/marcas', insertMarca);




//actualizar datos
router.put('/marcas/:id', updateMarca);




//eliminar registros.

router.delete('/marcas/:id', deleteMarca);


module.exports = router;