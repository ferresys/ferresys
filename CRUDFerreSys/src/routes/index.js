const { Router } = require('express');
const router = Router();

const {getClientes, getProveedores, getMarcas, getCategorias, getArticulos, getReciboMercancias, getKardex, getUsuarios, getPermisos, getUsuarioPermisos,  
getClienteById, getProveedorById, getMarcaById, getCategoriaById,getArticuloById, getReciboMercanciaById, getKardexById, getUsuarioById, getPermisoById, getUsuarioPermisoById, 
insertCliente, insertProveedor, insertMarca, insertCategoria, insertArticulo, insertReciboMercancia, insertEncabezadoVenta, insertDetalleVenta, insertUsuario, insertPermiso, insertUsuarioPermiso,
updateMarca, 
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
router.post('/clientes', insertCliente);
router.post('/proveedores', insertProveedor);
router.post('/marcas', insertMarca);
router.post('/categorias', insertCategoria);
router.post('/articulos', insertArticulo);
router.post('/reciboMercancias', insertReciboMercancia);
router.post('/encabezadoVenta', insertEncabezadoVenta);
router.post('/detalleVenta', insertDetalleVenta);
router.post('/usuarios', insertUsuario);
router.post('/permisos', insertPermiso);
router.post('/usuarioPermisos', insertUsuarioPermiso);


//actualizar datos
router.put('/marcas/:id', updateMarca);




//eliminar registros.

router.delete('/clientes/:id', deleteCliente);
router.delete('/proveedores/:id', deleteProveedor);
router.delete('/marcas/:id', deleteMarca);
router.delete('/categorias/:id', deleteCategoria);
router.delete('/articulos/:id', deleteArticulo);
router.delete('/usuarios/:id', deleteUsuario);
router.delete('/permisos/:id', deletePermiso);
router.delete('/usuarioPermisos/:id', deleteUsuarioPermiso);


module.exports = router;