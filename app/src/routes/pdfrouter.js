import express from 'express';
import puppeteer from 'puppeteer';
import fs from 'fs';
import path from 'path';

const router = express.Router();
router.post('/generate-pdf', async (req, res) => {
    const tableData = JSON.parse(req.body.text);

    const headers = [
        { label: "ID", property: 'id', width: 200 },
        { label: "Marca", property: 'marca', width: 200 },
        { label: "Estado", property: 'estado', width: 200 }
    ];

    const datas = tableData.map(row => {
        return {
            id: row.id,
            marca: row.marca,
            estado: row.estado
        };
    });

    const date = new Date();
    const formattedDate = `${date.getDate()}-${date.getMonth()+1}-${date.getFullYear()}`;

    const table = {
        title: "Tabla de Marca",
        subtitle: formattedDate,
        headers: headers,
        datas: datas
    };

    const imagePath = '/home/diegol/Software-Sena/ferresys/public/img/logo_ferreSys1.png';
    const imageBase64 = fs.readFileSync(imagePath).toString('base64');

    const html = `
        <html>
            <head>
                <title>${table.title}</title>
                <style>
                    /* Aquí puedes añadir estilos CSS para la tabla */
                    body {
                        font-family: Arial, sans-serif;
                    }
                    table {
                        width: 100%;
                        border-collapse: collapse;
                    }
                    th, td {
                        border: 1px solid #ddd;
                        padding: 8px;
                    }
                    th {
                        padding-top: 12px;
                        padding-bottom: 12px;
                        text-align: left;
                        background-color: #4CAF50;
                        color: white;
                    }
                </style>
            </head>
            <body>
                <header>
                <img src="data:image/png;base64,${imageBase64}" alt="Logo" style="float: right; height: 100px;">
                    <h1>${table.title}</h1>
                    <h2>${table.subtitle}</h2>
                </header>
                <table>
                    <thead>
                        <tr>
                            ${table.headers.map(header => `<th>${header.label}</th>`).join('')}
                        </tr>
                    </thead>
                    <tbody>
                        ${table.datas.map(row => `
                            <tr>
                                ${table.headers.map(header => `<td>${row[header.property]}</td>`).join('')}
                            </tr>
                        `).join('')}
                    </tbody>
                </table>
                <footer>
                    <p style="text-align: center;">Generado para FerreSys</p>
                </footer>
            </body>
        </html>
    `;

    const browser = await puppeteer.launch();
    const page = await browser.newPage();

    await page.setContent(html, { waitUntil: 'networkidle0' });

    const pdf = await page.pdf({ format: 'A4', printBackground: true });

    await browser.close();

    res.set({ 'Content-Type': 'application/pdf', 'Content-Length': pdf.length });
    res.send(pdf);
});

export default router;