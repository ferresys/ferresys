document.getElementById('consultarCategorias').addEventListener('click', () => {
    const token = localStorage.getItem('token');

    fetch('https://ferresysrender.onrender.com/categorias', {
        method: 'GET',
        headers: {
            'Authorization': `Bearer ${token}`,
        }
    })
        .then(response => response.json())
        .then(data => {
            const tablaMarca = document.querySelector('#tablaCategoria tbody');
            tablaMarca.innerHTML = ''; // Limpiar la tabla antes de agregar nuevos datos
            data.forEach(categoria => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${categoria.conseccateg}</td>
                    <td>${categoria.nomcateg}</td> 
                `;
                tablaMarca.appendChild(row);
            });
        })
        .catch(error => {
            console.error('Error al realizar la consulta:', error);
        });
});