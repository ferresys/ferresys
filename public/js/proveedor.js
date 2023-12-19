document.getElementById('consultarButton').addEventListener('click', () => {
    const token = localStorage.getItem('token');

    fetch('https://ferresysrender.onrender.com/proveedores', {
        method: 'GET',
        headers: {
            'Authorization': `Bearer ${token}`,
        }
    })
        .then(response => response.json())
        .then(data => {
            const tableBody = document.querySelector('#proveedorTable tbody');
            tableBody.innerHTML = ''; // Limpiar la tabla antes de agregar nuevos datos
            data.forEach(proveedor => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    
                    <td>${proveedor.idprov}</td>
                    <td>${proveedor.nomprov}</td>
                    <td>${proveedor.telprov}</td>
                    <td>${proveedor.emailprov}</td>
                    <td>${proveedor.dirprov}</td>
                    
                `;
                tableBody.appendChild(row);
            }); 
        })
        .catch(error => {
            console.error('Error al realizar la consulta:', error);
        });
});