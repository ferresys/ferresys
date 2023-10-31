document.getElementById('consultarButton').addEventListener('click', () => {
    fetch('http://localhost:4000/proveedores')
        .then(response => response.json())
        .then(data => {
            const tableBody = document.querySelector('#proveedorTable tbody');
            tableBody.innerHTML = ''; // Limpiar la tabla antes de agregar nuevos datos

            
            data.forEach(proveedor => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    
                    <td>${proveedor.idProv}</td>
                    <td>${proveedor.nomProv}</td>
                    <td>${proveedor.telProv}</td>
                    <td>${proveedor.emailProv}</td>
                    <td>${proveedor.dirProv}</td>
                    
                `;
                tableBody.appendChild(row);
            });

            
        })
        .catch(error => {
            console.error('Error al realizar la consulta:', error);
        });
});

   


    
/*
    
        document.addEventListener("DOMContentLoaded", function() {
            const searchInput = document.getElementById("searchInput");
            const clienteTable = document.getElementById("clienteTable").querySelector("tbody").children;

            searchInput.addEventListener("input", function() {
                const searchTerm = searchInput.value.toLowerCase();

                for (const row of clienteTable) {
                    const text = row.innerText.toLowerCase();
                    if (text.includes(searchTerm)) {
                        row.style.display = "table-row";
                    } else {
                        row.style.display = "none";
                    }
                }
            });
        });
   */





