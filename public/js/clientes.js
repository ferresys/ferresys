// Asume que la URL es la ruta en tu servidor que maneja la consulta de clientes
const url = 'http://localhost:4000/clientes';

fetch(url)
    .then(response => {
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.json();
    })
    .then(data => {
        const tableBody = document.querySelector('#clienteTable tbody');
        tableBody.innerHTML = ''; // Limpiar la tabla antes de agregar nuevos datos

        data.forEach(cliente => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${cliente.idcli}</td>
                <td>${cliente.tipocli}</td>
                <td>${cliente.nomcli}</td>
                <td>${cliente.apecli}</td>
                <td>${cliente.nomreplegal}</td>
                <td>${cliente.nomempresa}</td>
                <td>${cliente.telcli}</td>
                <td>${cliente.emailcli}</td>
                <td>${cliente.dircli}</td>
            `;
            tableBody.appendChild(row);
        });
    })
    .catch(error => {
        console.error('Error al realizar la consulta:', error);
    });