document.getElementById('consultarCategorias').addEventListener('click', () => {
    fetch('http://localhost:4000/categorias')
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

//codigo para la barra de busqueda
    
        document.addEventListener("DOMContentLoaded", function() {
            const searchInput = document.getElementById("searchInput");
            const tablaCategoria = document.getElementById("tablaCategoria").querySelector("tbody").children;

            searchInput.addEventListener("input", function() {
                const searchTerm = searchInput.value.toLowerCase();

                for (const row of tablaCategoria) {
                    const text = row.innerText.toLowerCase();
                    if (text.includes(searchTerm)) {
                        row.style.display = "table-row";
                    } else {
                        row.style.display = "none";
                    }
                }
            });
        });
   