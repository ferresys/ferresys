import QRCode from 'qrcode'; // Importa la biblioteca para generar códigos QR
import { toBuffer } from 'qrcode';
import { writeFile } from 'fs/promises';
import { resolve } from 'path';

export const generateQRCode = async (data, qrCodeUUID) => {
  try {
    const qrCodeBuffer = await toBuffer(data);

    // Define la ruta del directorio donde se guardarán los códigos QR
    const directoryPath = resolve(__dirname, './CodeQR');

    // Genera la ruta completa del archivo donde se guardará el código QR
    const filePath = resolve(directoryPath, `QR-${qrCodeUUID}.png`);

    // Guarda el código QR en el archivo
    await writeFile(filePath, qrCodeBuffer);

    // Devuelve la ruta del archivo
    return filePath;
  } catch (error) {
    throw error;
  }
};
