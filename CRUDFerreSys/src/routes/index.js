const { Router } = require('express');
const router = Router();

const {getClientes, getProveedores, getMarcas, getCategorias, getArticulos, getReciboMercancias, getKardex, getUsuarios, getPermisos, getUsuarioPermisos,  
getClienteById, getProveedorById, getMarcaById, getCategoriaById,getArticuloById, getReciboMercanciaById, getKardexById, getUsuarioById, getPermisoById, getUsuarioPermisoById, 
insertMarca, updateMarca, 
deleteCliente, deleteProveedor, deleteMarca, deleteCategoria, deleteArticulo, deleteUsuario, deletePermiso, deleteUsuarioPermiso}= require('../controllers/index.controller')

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
router.get('/articulos/:id', getArticuloById);
router.get('/reciboMercancias/:id', getReciboMercanciaById);
router.get('/kardex/:id', getKardexById);
router.get('/Usuarios/:id', getUsuarioById);
router.get('/permisos/:id', getPermisoById);
router.get('/usuarioPermisos/:id', getUsuarioPermisoById);

// insertar datos
router.post('/marcas', insertMarca);




//actualizar datos
router.put('/marcas/:id', updateMarca);




//eliminar registros.

router.delete('/marcas/:id', deleteCliente);
router.delete('/marcas/:id', deleteProveedor);
router.delete('/marcas/:id', deleteMarca);
router.delete('/marcas/:id', deleteCategoria);
router.delete('/marcas/:id', deleteArticulo);
router.delete('/marcas/:id', deleteUsuario);
router.delete('/marcas/:id', deletePermiso);
router.delete('/marcas/:id', deleteUsuarioPermiso);


module.exports = router;