document.addEventListener('DOMContentLoaded', function() {
  // Añade un listener al botón "Mostrar Clientes" (asume que tiene un id="mostrar-clientes")
  document.getElementById('mostrar-clientes').addEventListener('click', function() {
    // Realiza una petición fetch al endpoint que proporciona los datos de los clientes
    fetch('https://ferresysrender.onrender.com/clientes')
    
      .then(response => response.json())
      .then(data => {
        console.log(data);
        const tbody = document.getElementById('clientes-tbody');
        tbody.innerHTML = ''; // Limpia el tbody existente
        
        
        // Itera a través de cada cliente y añade una fila nueva al tbody
        data.forEach(cliente => {
          const row = `
          <tr>
            <th scope="row">${cliente.cedulaclinat}</th>
            <td>${cliente.fecreg}</td>
            <td>${cliente.nomcli}</td>
            <td>${cliente.apecli}</td>
            <td>${cliente.tipocli}</td>
            <td>${cliente.telcli}</td>
            <td>${cliente.emailcli}</td>
            <td>${cliente.dircli}</td>
            <td>${cliente.conseccli}</td>
          </tr>
        `;
        

          tbody.innerHTML += row;
        });
      })
      .catch(error => {
        console.error('Error:', error);
      });
  });
});
