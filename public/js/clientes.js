document.getElementById('consultarButton').addEventListener('click', () => {
    fetch('http://localhost:4000/clientes')
        .then(response => response.json())
        .then(data => {
            const tableBody = document.querySelector('#clienteTable tbody');
            tableBody.innerHTML = ''; // Limpiar la tabla antes de agregar nuevos datos

            /*data.forEach(cliente => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${cliente.codcli}</td>
                    <td>${cliente.idcli}</td>
                    <td>${cliente.tipocli}</td>
                    <td>${cliente.nomcli}</td>
                    <td>${cliente.apecli}</td>
                    <td>${cliente.nomreplegal}</td>
                    <td>${cliente.nomempresa}</td>
                    <td>${cliente.telcli}</td>
                    <td>${cliente.emailcli}</td>
                    <td>${cliente.dircli}</td>
                    <td>${cliente.fecinsert}</td>
                    <td>${cliente.userinsert}</td>
                    <td>${cliente.fecupdate}</td>
                    <td>${cliente.userupdate}</td>
                `;
                tableBody.appendChild(row);
            });
            */
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

