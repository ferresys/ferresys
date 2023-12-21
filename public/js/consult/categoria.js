document.addEventListener('DOMContentLoaded', (event) => {
    consultarCategorias();
});


document.getElementById('searchInput-categ').addEventListener('keyup', function() {
    let input, filter, table, tr, td, i, j, txtValue;
    input = document.getElementById('searchInput-categ');
    filter = input.value.toUpperCase();
    table = document.getElementById('tablaCategor');
    tr = table.getElementsByTagName('tr');

    for (i = 0; i < tr.length; i++) {
        td = tr[i].getElementsByTagName('td');
        for (j = 0; j < td.length; j++) {
            if (td[j]) {
                txtValue = td[j].textContent || td[j].innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = '';
                    break;
                } else {
                    tr[i].style.display = 'none';
                }
            }       
        }
    }
});

document.getElementById('agregarCategorias').addEventListener('click', () => {
    Swal.fire({
        title: 'Agregar Categoría',
        input: 'text',
        inputPlaceholder: 'Nombre de la categoría',
        confirmButtonText: 'Agregar',
        showCancelButton: true,
        preConfirm: async (nomCateg) => {
            if (!nomCateg) {
                Swal.showValidationMessage('Por favor, introduce el nombre de la categoría.');
                return;
            }

            // Verificar si la categoría ya existe
            const responseCheck = await fetch('http://localhost:4000/categorias');
            const data = await responseCheck.json();
            const existeCategoria = data.some(categoria => categoria.nomCateg === nomCateg);

            if (existeCategoria) {
                // Si la categoría ya existe, mostrar una alerta
                Swal.showValidationMessage('La categoría ya existe');
                return;
            }

            const url = `http://localhost:4000/categorias`; // URL del servidor para agregar categorías

            const response = await fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    nomCateg: nomCateg,
                    estado: true, // El estado se guarda por defecto en true
                }),
            });

            if (!response.ok) {
                throw new Error('Network response was not ok');
            }

            
        }
    }).then((result) => {
        if (result.isConfirmed) {
            Swal.fire('¡Agregado!', 'La categoría ha sido agregada.', 'success')
                .then(() => {
                    // Refrescar la lista de categorías después de crear una nueva categoría
                    consultarCategorias();
                });
        }

    }).catch(error => {
        console.error('Error:', error);
    });
});

function consultarCategorias(categoria = null) {
    const token = localStorage.getItem('token');

    const fetchCategorias = categoria
        ? Promise.resolve(categoria)
        : fetch('http://localhost:4000/categorias', {
            method: 'GET',
            headers: {
                'Authorization': `Bearer ${token}`,
            }
        }).then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        });

    fetchCategorias.then(data => {
        const tablaCategoria = document.querySelector('#tablaCategor tbody');
        tablaCategoria.innerHTML = ''; // Limpiar la tabla antes de agregar nuevos datos

        data.forEach(categoria => {
            const estado = categoria.estado ? 'Activo' : 'Inactivo';
            const estadoClass = categoria.estado ? 'my-success' : 'my-danger';
            const row = document.createElement('tr');
            row.innerHTML = `
            <td>${categoria.conseccateg}</td>
            <td>${categoria.nomcateg}</td>
            <td class="text-center"><span class="${estadoClass}">${estado}</span></td>
            <td class="actions-cell">
            <button class="btn btn-primary btn-sm edit-button hidden btn-full-height"><i class="bi bi-pencil-fill"></i></button>
            <button class="btn btn-danger btn-sm delete-button hidden btn-full-height"><i class="bi bi-trash-fill"></i></button>
            </td>
        `;
            tablaCategoria.appendChild(row);

            // Aquí debes agregar los eventos de click para los botones de editar y eliminar
            // Asegúrate de cambiar las referencias a 'marcas' por 'categorias' en las URLs de las peticiones fetch


            // Agregar evento de click al botón de editar
            row.querySelector('.edit-button').addEventListener('click', () => {
                Swal.fire({
                    title: 'Editar Categoría',
                    html: `
                        <input id="swal-input1" class="swal2-input" value="${categoria.nomcateg}">
                        <select id="swal-input2" class="swal2-input">
                            <option value="Activo" ${categoria.estado ? 'selected' : ''}>Activo</option>
                            <option value="Inactivo" ${!categoria.estado ? 'selected' : ''}>Inactivo</option>
                        </select>
                    `,
                    focusConfirm: false,
                    showCancelButton: true, // Agrega esta línea
                    confirmButtonText: 'Guardar',
                    cancelButtonText: 'Cancelar',
                    preConfirm: async () => {
                        const nomCateg = document.getElementById('swal-input1').value;
                        const estado = document.getElementById('swal-input2').value === 'Activo';

                        const id = categoria.conseccateg; // Obtén el ID de la categoría
                        const url = `http://localhost:4000/categorias/${id}`; // Incluye el ID en la URL

                        const response = await fetch(url, {
                            method: 'PUT',
                            headers: {
                                'Content-Type': 'application/json',
                            },
                            body: JSON.stringify({
                                nomCateg: nomCateg,
                                estado,
                            }),
                        });

                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }

                        categoria.nomcateg = nomCateg;
                        categoria.estado = estado; // Actualizar el estado de la categoría en el objeto categoria

                        row.children[1].textContent = categoria.nomcateg;
                        row.children[2].children[0].textContent = categoria.estado ? 'Activo' : 'Inactivo';
                        row.children[2].children[0].className = categoria.estado ? 'my-success' : 'my-danger';
                    }
                }).then((result) => {
                    if (result.isConfirmed) {
                        Swal.fire({
                            position: 'top',
                            icon: 'success',
                            title: 'La categoría ha sido editada.',
                            showConfirmButton: false,
                            timer: 2500,
                            toast: true,
                            timerProgressBar: true,
                            onOpen: (toast) => {
                                toast.addEventListener('mouseenter', Swal.stopTimer)
                                toast.addEventListener('mouseleave', Swal.resumeTimer)
                            }
                        });
                    }
                }).catch(error => {
                    console.error('Error:', error);
                });
            });
            row.querySelector('.delete-button').addEventListener('click', () => {
                Swal.fire({
                    title: '¿Estás seguro?',
                    text: "¡No podrás revertir esto!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: '¡Sí, eliminar!'
                }).then(async (result) => {
                    if (result.isConfirmed) {
                        const id = categoria.conseccateg; // Obtén el ID de la categoría
                        const url = `http://localhost:4000/categorias/${id}`; 

                        const response = await fetch(url, {
                            method: 'DELETE',
                        });

                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }

                        
                        row.remove();

                        Swal.fire({
                            position: 'top-end',
                            icon: 'info',
                            html: '<i class="fas fa-trash"></i> La categoría ha sido eliminada',
                            showConfirmButton: false,
                            timer: 3000,
                            toast: true,
                            timerProgressBar: true,
                            onOpen: (toast) => {
                                toast.addEventListener('mouseenter', Swal.stopTimer)
                                toast.addEventListener('mouseleave', Swal.resumeTimer)
                            }
                        });
                    }
                })
            });
        });
    })
        .catch(error => {
            console.error('Error al realizar la consulta:', error);
        });
}

document.getElementById('filtroCateg').addEventListener('click', () => {
    Swal.fire({
        title: 'Filtrar por estado',
        input: 'select',
        inputOptions: {
            '': 'Todos',
            'true': 'Activos',
            'false': 'Inactivos',
        },
        inputPlaceholder: 'Selecciona un estado',
        showCancelButton: true,
    }).then((result) => {
        if (result.isConfirmed) {
            filtrarCategorias(result.value);
        }
    });
});

function filtrarCategorias(estado) {
    const token = localStorage.getItem('token');

    fetch('http://localhost:4000/categorias', {
        method: 'GET',
        headers: {
            'Authorization': `Bearer ${token}`,
        }
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            let categFiltradas;

            if (estado === '') {
                // Si el usuario seleccionó "Todos", no filtrar las categorías
                categFiltradas = data;
            } else {
                // Si el usuario seleccionó "Activos" o "Inactivos", filtrar las categorías por estado
                const estadoBool = estado === 'true';
                categFiltradas = data.filter(categoria => categoria.estado === estadoBool);
            }

            // Actualizar la lista de categorías con las categorías filtradas
            consultarCategorias(categFiltradas);
        })
        .catch(error => {
            console.error('Error al realizar la consulta:', error);
        });
}
document.addEventListener('DOMContentLoaded', (event) => {
    document.getElementById('exportar').addEventListener('click', function () {
        // Captura los datos de la tabla
        const table = document.getElementById('tablaMarca');
        const rows = Array.from(table.rows);
        const data = rows.map(row => Array.from(row.cells).map(cell => cell.textContent));

        // Convierte los datos a un formato que el servidor pueda entender
        const formattedData = data.slice(1).map(row => {
            return { id: row[0], marca: row[1], estado: row[2] };
        });

        // Envía los datos al servidor
        fetch('http://localhost:4000/generate-pdf', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                text: JSON.stringify(formattedData),
            }),
        })
            .then(response => response.blob())
            .then(blob => {
                const url = window.URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.style.display = 'none';
                a.href = url;
                a.download = 'tabla.pdf';
                document.body.appendChild(a);
                a.click();
                window.URL.revokeObjectURL(url);
            });
    });
});

document.addEventListener('DOMContentLoaded', (event) => {
    document.getElementById('exportarCateg').addEventListener('click', function () {
        // Captura los datos de la tabla
        const table = document.getElementById('tablaCategor');
        const rows = Array.from(table.rows);
        const data = rows.map(row => Array.from(row.cells).map(cell => cell.textContent));

        // Convierte los datos a un formato que el servidor pueda entender
        const formattedData = data.slice(1).map(row => {
            return { id: row[0], marca: row[1], estado: row[2] };
        });

        // Envía los datos al servidor
        fetch('http://localhost:4000/generate-pdf/categorias', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                text: JSON.stringify(formattedData),
            }),
        })
            .then(response => response.blob())
            .then(blob => {
                const url = window.URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.style.display = 'none';
                a.href = url;
                a.download = 'categorias.pdf';
                document.body.appendChild(a);
                a.click();
                window.URL.revokeObjectURL(url);
            });
    });
});