import { Router } from 'express';
import { validateToken } from '../../middleware/validate-token';
const router = Router(); //Creamos la instancia router.

import { getClientesError, getClienteByIdError, insertCliente, updateCliente, deleteCliente} from '../controllers/clientes';
import { getProveedoresError, getProveedorByIdError, insertProveedor, updateProveedor, deleteProveedor} from '../controllers/proveedores';
import { getMarcasError, getMarcaByIdError, insertMarca, updateMarca, deleteMarca }from '../controllers/marcas';
import { getCategoriasError, getCategoriaByIdError, insertCategoria, updateCategoria, deleteCategoria} from '../controllers/categorias';
import { getArticulosError, getArticuloByIdError, insertArticulo, updateArticulo, deleteArticulo} from '../controllers/articulos';
import { getReciboMercanciasError, getReciboMercanciaByIdError, insertReciboMercancia} from '../controllers/recibo-mercancias';
import { getKardexError, getKardexByIdError} from '../controllers/kardex';
import { getUsuariosError, getUsuarioByIdError, insertUsuario, updateUsuario, deleteUsuario, login} from '../controllers/usuarios';
import { getPermisosError, getPermisoByIdError, insertPermiso, updatePermiso, deletePermiso} from '../controllers/permisos';
import { getUsuarioPermisosError, getUsuarioPermisoByIdError, insertUsuarioPermiso, updateUsuarioPermiso, deleteUsuarioPermiso  }from '../controllers/usuario-permisos';
import { insertEncabezadoVenta} from '../controllers/encabezado-venta';
import { insertDetalleVenta}from '../controllers/detalle-venta';

// ESTABLECEMOS LA RUTA Y EL CONTROLADOR

router.get('/clientes', validateToken, getClientesError);
router.get('/proveedores', validateToken, getProveedoresError);
router.get('/marcas', validateToken, getMarcasError);
router.get('/categorias', validateToken, getCategoriasError);
router.get('/articulos', validateToken, getArticulosError);
router.get('/reciboMercancias', validateToken, getReciboMercanciasError);
router.get('/kardex', validateToken, getKardexError);
router.get('/usuarios', validateToken, getUsuariosError);
router.get('/permisos', validateToken, getPermisosError);
router.get('/usuarioPermisos', validateToken, getUsuarioPermisosError);

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

router.post('/login', login);
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
router.delete('/marcas/:id', deleteMarca);
router.delete('/categorias/:id', deleteCategoria);
router.delete('/articulos/:id', deleteArticulo);
router.delete('/usuarios/:id', deleteUsuario);
router.delete('/permisos/:id', deletePermiso);
router.delete('/usuarioPermisos/:id', deleteUsuarioPermiso);

export default router;