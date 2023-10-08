
import { Router } from 'express';
const router = Router();

import { getClientesWithManejoErrores, getProveedoresWithManejoErrores,getMarcasWithManejoErrores,
getCategoriasWithManejoErrores,getArticulosWithManejoErrores, getReciboMercanciasWithManejoErrores,
getKardexWithManejoErrores,getUsuariosWithManejoErrores,getPermisosWithManejoErrores, 
getUsuarioPermisosWithManejoErrores,
getClienteById, getProveedorById, getMarcaById, getCategoriaById,getArticuloById, getReciboMercanciaById, getKardexById, getUsuarioById, getPermisoById, getUsuarioPermisoById, 
insertCliente, insertProveedor, insertMarca, insertCategoria, insertArticulo, insertReciboMercancia, insertEncabezadoVenta, insertDetalleVenta, insertUsuario, insertPermiso, insertUsuarioPermiso,
updateCliente,updateProveedor,updateMarca, updateCategoria, updateArticulo, updateUsuario, updatePermiso, updateUsuarioPermiso,
deleteCliente, deleteProveedor, deleteCategoria, deleteArticulo, deleteUsuario, deletePermiso, deleteUsuarioPermiso} from '../controllers/crudController';

// Consultas generales
router.get('/clientes', getClientesWithManejoErrores);
router.get('/proveedores', getProveedoresWithManejoErrores);
router.get('/marcas', getMarcasWithManejoErrores);
router.get('/categorias', getCategoriasWithManejoErrores);
router.get('/articulos', getArticulosWithManejoErrores);
router.get('/reciboMercancias', getReciboMercanciasWithManejoErrores);
router.get('/kardex', getKardexWithManejoErrores);
router.get('/usuarios', getUsuariosWithManejoErrores);
router.get('/permisos', getPermisosWithManejoErrores);
router.get('/usuarioPermisos', getUsuarioPermisosWithManejoErrores);

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
router.put('/clientes/:id', updateCliente);
router.put('/proveedores/:id', updateProveedor);
router.put('/marcas/:id', updateMarca);
router.put('/categorias/:id', updateCategoria);
router.put('/articulos/:id', updateArticulo);
router.put('/usuarios/:id', updateUsuario);
router.put('/permisos/:id', updatePermiso);
router.put('/usuarioPermisos/:id', updateUsuarioPermiso);



//eliminar registros.

router.delete('/clientes/:id', deleteCliente);
router.delete('/proveedores/:id', deleteProveedor);
router.delete('/categorias/:id', deleteCategoria);
router.delete('/articulos/:id', deleteArticulo);
router.delete('/usuarios/:id', deleteUsuario);
router.delete('/permisos/:id', deletePermiso);
router.delete('/usuarioPermisos/:id', deleteUsuarioPermiso);




export default router;

