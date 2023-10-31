document.getElementById('consultarMarcas').addEventListener('click', () => {
    fetch('http://localhost:4000/marcas')
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

/* codigo para la barra de busqueda
    
        document.addEventListener("DOMContentLoaded", function() {
            const searchInput = document.getElementById("searchInput");
            const proveedorTable = document.getElementById("proveedorTable").querySelector("tbody").children;

            searchInput.addEventListener("input", function() {
                const searchTerm = searchInput.value.toLowerCase();

                for (const row of proveedorTable) {
                    const text = row.innerText.toLowerCase();
                    if (text.includes(searchTerm)) {
                        row.style.display = "table-row";
                    } else {
                        row.style.display = "none";
                    }
                }
            });
        });*/