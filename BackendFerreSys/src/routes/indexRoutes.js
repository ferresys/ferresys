
//IMPORTAMOS LA CLASE ROUTER 
//Los routers se utilizan para organizar y modularizar las rutas y controladores de una aplicación web o API.

import { Router } from 'express';
const router = Router();//Creamos la instancia router.

//IMPORTAMOS LAS FUNCIONES-CONTROLADORES

import { insertCliente, insertProveedor, insertMarca, insertCategoria, insertArticulo, insertReciboMercancia, insertEncabezadoVenta, insertDetalleVenta, insertUsuario, insertPermiso, insertUsuarioPermiso,
updateCliente,updateProveedor,updateMarca, updateCategoria, updateArticulo, updateUsuario, updatePermiso, updateUsuarioPermiso,
deleteCliente, deleteProveedor, deleteCategoria, deleteArticulo, deleteUsuario, deletePermiso, deleteUsuarioPermiso} from '../controllers/crudController';

import { getClientesError, getProveedoresError, getMarcasError, getCategoriasError, getArticulosError,
		 getReciboMercanciasError, getKardexError, getUsuariosError, getPermisosError, getUsuarioPermisosError }from '../controllers/crudController'; 

import { getClienteByIdError, getProveedorByIdError, getMarcaByIdError, getCategoriaByIdError, getArticuloByIdError, 
getReciboMercanciaByIdError, getKardexByIdError,getUsuarioByIdError, getPermisoByIdError, getUsuarioPermisoByIdError } from '../controllers/crudController'; 



// ESTABLECEMOS LA RUTA Y EL CONTROLADOR

/********************************************************************************************
 * 																							*
 * esta línea de código configura una ruta en el servidor que, cuando se accede 			*
 * mediante una solicitud GET a /clientes, ejecuta la función getClientesError, 			*
 * que se encarga de manejar la lógica de obtención de clientes y manejo de errores 		*
 * para esa ruta específica.																*						*
 * 																							*
 * ******************************************************************************************/

router.get('/clientes', getClientesError);
router.get('/proveedores', getProveedoresError);
router.get('/marcas', getMarcasError);
router.get('/categorias', getCategoriasError);
router.get('/articulos', getArticulosError);
router.get('/reciboMercancias', getReciboMercanciasError);
router.get('/kardex', getKardexError);
router.get('/usuarios', getUsuariosError);
router.get('/permisos', getPermisosError);
router.get('/usuarioPermisos', getUsuarioPermisosError);

//consultas por id .

router.get('/clientes/:id', getClienteByIdError);
router.get('/proveedores/:id', getProveedorByIdError);
router.get('/marcas/:id', getMarcaByIdError);
router.get('/categorias/:id', getCategoriaByIdError);
router.get('/articulos/:id', getArticuloByIdError);
router.get('/reciboMercancias/:id', getReciboMercanciaByIdError);
router.get('/kardex/:id', getKardexByIdError);
router.get('/Usuarios/:id', getUsuarioByIdError);
router.get('/permisos/:id', getPermisoByIdError);
router.get('/usuarioPermisos/:id', getUsuarioPermisoByIdError);

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

