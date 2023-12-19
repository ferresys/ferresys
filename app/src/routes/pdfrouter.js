import express from 'express';
import puppeteer from 'puppeteer';
import fs from 'fs';


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
        title: "Marcas",
        subtitle: formattedDate,
        headers: headers,
        datas: datas
    };

    

    const html = `
    <html>

<head>
    <title>${table.title}</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap">
    <style>
        /* Aquí puedes añadir estilos CSS para la tabla */
        body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            font-family: 'Montserrat', sans-serif;
        }

        main {
            margin: 0 30px;
        }

        .estado-activo {
            background-color: #d9fbd0;
            color: #1c6c09;
        }

        .estado-inactivo {
            background-color: #ffe0db;
            color: #b81800;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th,
        td {
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

        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 7px solid #022232; /* Añade una línea divisoria al contenedor principal */
            padding: 10px;
            margin: 20px 0 40px;
        }
        
        /* Añade estilos a los elementos específicos dentro del encabezado, si es necesario */
        .header h1 {
            text-align: center;
            margin: 0;
        }
        
        .header img {
            height: 100px;
        }
        
        .header .date {
            text-align: right;
        }
        

        footer {
            background-color: #FACE37; /* Cambia esto al color que desees */
            color: black; /* Cambia esto al color de texto que desees */
            text-align: center;
            position: fixed;
            width: 100%;
            bottom: 0;
            padding: 10px;
            margin: 0;
            font-weight: bold; /* Ajusta el espaciado interno según tus preferencias */
        }
    </style>
</head>
<body>
    <main>
        <header class="header">
            <img src="https://drive.google.com/uc?id=1bSDI-0PONIf4_600TP4cbArpJjotXSUm" alt="Logo">
            <h1>${table.title}</h1>
            <div class="date">${new Date().toLocaleDateString()}</div>
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
                        ${table.headers.map(header => {
                            if (header.property === 'estado') {
                                // Aplica una clase CSS dependiendo del estado
                                const estadoClass = row[header.property] === 'Activo' ? 'estado-activo' : 'estado-inactivo';
                                return `<td class="${estadoClass}">${row[header.property]}</td>`;
                            } else {
                                return `<td>${row[header.property]}</td>`;
                            }
                        }).join('')}
                    </tr>
                `).join('')}
            </tbody>
        </table>

    </main>
    
    <footer>
        <p>Generado para FerreSys</p>
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