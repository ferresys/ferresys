document.getElementById('consultarButton').addEventListener('click', () => {
    const token = localStorage.getItem('token');

    fetch('http://localhost:4000/clientes', {
        credentials: 'include',
        headers: {
            'Authorization': `Bearer ${token}`
        }
    })
    .then(response => response.json())
    .then(data => {
        const tableBody = document.querySelector('#clienteTable tbody');
        tableBody.innerHTML = '';

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
});