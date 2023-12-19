document.getElementById('consultarButton').addEventListener('click', () => {
    fetch('https://ferresysrender.onrender.com/articulos')
        .then(response => response.json())
        .then(data => {
            const tableBody = document.querySelector('#articuloTable tbody');
            tableBody.innerHTML = ''; // Limpiar la tabla antes de agregar nuevos datos

            
            data.forEach(articulo => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    
                    <td>${articulo.eanart}</td>
                    <td>${articulo.nomart}</td>
                    <td>${articulo.descart}</td>
                    <td>${articulo.valunit}</td>
                    <td>${articulo.porcentaje}</td>
                    <td>${articulo.iva}</td>
                    <td>${articulo.valstock}</td>
                    <td>${articulo.stockmin}</td>
                    <td>${articulo.stockmax}</td>
                    <td>${articulo.valreorden}</td>
                    <td>${articulo.fecvence}</td>
                    <td>${articulo.estado}</td>
                    
                `;
                tableBody.appendChild(row);
            });

            
        })
        .catch(error => {
            console.error('Error al realizar la consulta:', error);
        });
});

   


    

    
        document.addEventListener("DOMContentLoaded", function() {
            const searchInput = document.getElementById("searchInput");
            const articuloTable = document.getElementById("articuloTable").querySelector("tbody").children;

            searchInput.addEventListener("input", function() {
                const searchTerm = searchInput.value.toLowerCase();

                for (const row of articuloTable) {
                    const text = row.innerText.toLowerCase();
                    if (text.includes(searchTerm)) {
                        row.style.display = "table-row";
                    } else {
                        row.style.display = "none";
                    }
                }
            });
        });
   

