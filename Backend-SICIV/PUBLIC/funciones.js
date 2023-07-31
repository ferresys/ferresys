



//import obtener_articulos from '../consulta_articulos';

const alternar_submenu = (submenuid) => {
  const subMenu = document.getElementById(submenuid);
  const displayValue = window.getComputedStyle(subMenu).getPropertyValue('display');
  subMenu.style.display = (displayValue === 'block') ? 'none' : 'block';
};

const contenido= (content) => {
  const contentElement = document.getElementById('content');
  contentElement.innerHTML = `<h1>${content}</h1><p>Contenido relacionado con ${content}</p>`;
};

const obtenerArticulos = () => {

  return new Promise((resolve) => {
    setTimeout(() => {
      resolve([]);
    }, 1000);
  });
};


const showTable = (subMenuTitle) => {
  const contentElement = document.getElementById('content');
  let tableContent = '';

  switch (subMenuTitle) {
    case 'Administrar Artículo':
      obtenerArticulos()
        .then((articulos) => {
          tableContent = `
            <h1>${subMenuTitle}</h1>
            <p>Contenido relacionado con ${subMenuTitle}</p>
            <table id="tabla_articulo">
              <thead>
                <tr>
                  <th>consec_art</th>
                  <th>ean_art</th>
                  <th>fec_reg</th>
                  <th>nom_art</th>
                  <th>consec_marca</th>
                  <th>consec_categ</th>
                  <th>descrip_art</th>
                  <th>unid_med</th>
                  <th>val_unit</th>
                  <th>iva</th>
                  <th>val_stock</th>
                  <th>stock_min</th>
                  <th>stock_max</th>
                  <th>val_reorden</th>
                  <th>fec_vence</th>
                  <th>estado</th>
                </tr>
              </thead>
              <tbody>
                ${articulos.map((articulo) => `
                  <tr>
                    <td>${articulo.consec_art}</td>
                    <td>${articulo.ean_art}</td>
                    <td>${articulo.fec_reg}</td>
                    <td>${articulo.nom_art}</td>
                    <td>${articulo.consec_marca}</td>
                    <td>${articulo.consec_categ}</td>
                    <td>${articulo.descrip_art}</td>
                    <td>${articulo.unid_med}</td>
                    <td>${articulo.val_unit}</td>
                    <td>${articulo.iva}</td>
                    <td>${articulo.val_stock}</td>
                    <td>${articulo.stock_min}</td>
                    <td>${articulo.stock_max}</td>
                    <td>${articulo.val_reorden}</td>
                    <td>${articulo.fec_vence}</td>
                    <td>${articulo.estado}</td>
                  </tr>
                `).join('')}
              </tbody>
            </table>
          `;
          contentElement.innerHTML = tableContent;
        })
        .catch((error) => {
          console.error('Error al obtener los artículos:', error);
          // Muestra un mensaje de error en caso de no poder obtener los artículos
          contentElement.innerHTML = `<h1>Error</h1><p>Error al obtener los artículos.</p>`;
        });
      break;
    // Agrega más casos para los demás submenús que quieras mostrar tablas
    default:
      // Si no se selecciona un submenú válido, muestra un mensaje de error
      tableContent = `<h1>Error</h1><p>Submenú no válido.</p>`;
      contentElement.innerHTML = tableContent;
      break;
  }
};


