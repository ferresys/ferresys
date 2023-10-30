document.getElementById('consultarProveedor').addEventListener('click', () => {
    fetch('http://localhost:4000/Proveedores')
        .then(response => response.json())
        .then(data => {
            const tablaProveedor = document.querySelector('#tablaProveedor tbody');
            tablaProveedor.innerHTML = ''; // Limpiar la tabla antes de agregar nuevos datos

            data.forEach(proveedor => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${proveedor.idProv}</td>
                    <td>${proveedor.nomProv}</td>
                    <td>${proveedor.telProv}</td>
                    <td>${proveedor.emailProv}</td>
                    <td>${proveedor.dirProv}</td>
                   
                `;
                tablaProveedor.appendChild(row);
            });
        })
        .catch(error => {
            console.error('Error al realizar la consulta:', error);
        });
});

   
    
/*
    
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