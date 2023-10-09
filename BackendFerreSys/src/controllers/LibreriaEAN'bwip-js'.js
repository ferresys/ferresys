import bwipjs from 'bwip-js';
import dbPool from './conectionDB';


async function generarAlmacenarCodigoBarras() {
    const codigoBarras = '123456789012'; // Genera el código de barras según tus necesidades
    const imageBuffer = await bwipjs.toBuffer({
        bcid: 'code128', // Tipo de código de barras
        text: codigoBarras,
        scale: 3, // Escala del código de barras
        height: 10 // Altura del código de barras
    });

    // Almacena el código de barras en la base de datos
    
    const insertArticuloQuery = 'SELECT insertArticulo($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)';
const values = [codigoBarras, 'Martillo', 1, 1, 'cacha madera', 1.20, '2023-11-21'];

try {
  await pool.query(insertArticuloQuery, values);
  console.log('Artículo insertado correctamente.');
} catch (error) {
  console.error('Error al insertar artículo:', error);
}

}

generarYAlmacenarCodigoBarras().catch(error => console.error(error));


