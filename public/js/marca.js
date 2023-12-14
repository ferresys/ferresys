document.getElementById('consultarMarcas').addEventListener('click', () => {
    const token = localStorage.getItem('token');

    fetch('http://localhost:4000/marcas', {
        method: 'GET',
        headers: {
            'Authorization': `Bearer ${token}`,
        }
    })
        .then(response => response.json())
        .then(data => {
            const tablaMarca = document.querySelector('#tablaMarca tbody');
            tablaMarca.innerHTML = ''; // Limpiar la tabla antes de agregar nuevos datos

            data.forEach(marca => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${marca.consecmarca}</td>
                    <td>${marca.nommarca}</td>
                
                `;
                tablaMarca.appendChild(row);
            });
        })
        .catch(error => {
            console.error('Error al realizar la consulta:', error);
        });
});