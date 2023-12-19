document.addEventListener('DOMContentLoaded', (event) => {
    consultarMarcas();
});
document.getElementById('agregarMarcas').addEventListener('click', () => {
    Swal.fire({
        title: 'Agregar Marca',
        input: 'text',
        inputPlaceholder: 'Nombre de la marca',
        confirmButtonText: 'Agregar',
        showCancelButton: true,
        preConfirm: async (nommarca) => {
            if (!nommarca) {
                Swal.showValidationMessage('Por favor, introduce el nombre de la marca.');
                return;
            }

            // Verificar si la marca ya existe
            const responseCheck = await fetch('https://ferresysrender.onrender.com/marcas');
            const data = await responseCheck.json();
            const existeMarca = data.some(marca => marca.nommarca === nommarca);

            if (existeMarca) {
                // Si la marca ya existe, mostrar una alerta
                Swal.showValidationMessage('La marca ya existe');
                return;
            }

            const url = `https://ferresysrender.onrender.com/marcas`; // URL del servidor para agregar marcas

            const response = await fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    nomMarca: nommarca,
                    estado: true, // El estado se guarda por defecto en true
                }),
            });

            if (!response.ok) {
                throw new Error('Network response was not ok');
            }

            // Aquí puedes agregar el código para añadir la nueva marca a la interfaz de usuario
        }
    }).then((result) => {
        if (result.isConfirmed) {
            Swal.fire('¡Agregado!', 'La marca ha sido agregada.', 'success')
                .then(() => {
                    // Refrescar la lista de marcas después de crear una nueva marca
                    consultarMarcas();
                });
        }

    }).catch(error => {
        console.error('Error:', error);
    });
});


function consultarMarcas(marcas = null) {
    const token = localStorage.getItem('token');

    const fetchMarcas = marcas
        ? Promise.resolve(marcas)
        : fetch('https://ferresysrender.onrender.com/marcas', {
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

    fetchMarcas.then(data => {
        const tablaMarca = document.querySelector('#tablaMarca tbody');
        tablaMarca.innerHTML = ''; // Limpiar la tabla antes de agregar nuevos datos

        data.forEach(marca => {
            const estado = marca.estado ? 'Activo' : 'Inactivo';
            const estadoClass = marca.estado ? 'my-success' : 'my-danger';
            const row = document.createElement('tr');
            row.innerHTML = `
            <td>${marca.consecmarca}</td>
            <td>${marca.nommarca}</td>
            <td class="text-center"><span class="${estadoClass}">${estado}</span></td>
            <td class="actions-cell">
            <button class="btn btn-primary btn-sm edit-button hidden btn-full-height"><i class="bi bi-pencil-fill"></i></button>
            <button class="btn btn-danger btn-sm delete-button hidden btn-full-height"><i class="bi bi-trash-fill"></i></button>
            </td>
        `;
            tablaMarca.appendChild(row);

            // Agregar evento de click al botón de editar

            row.querySelector('.edit-button').addEventListener('click', () => {
                Swal.fire({
                    title: 'Editar Marca',
                    html: `
                        <input id="swal-input1" class="swal2-input" value="${marca.nommarca}">
                        <select id="swal-input2" class="swal2-input">
                            <option value="Activo" ${marca.estado ? 'selected' : ''}>Activo</option>
                            <option value="Inactivo" ${!marca.estado ? 'selected' : ''}>Inactivo</option>
                        </select>
                    `,
                    focusConfirm: false,
                    showCancelButton: true, // Agrega esta línea
                    confirmButtonText: 'Guardar',
                    cancelButtonText: 'Cancelar',
                    preConfirm: async () => {
                        const nommarca = document.getElementById('swal-input1').value;
                        const estado = document.getElementById('swal-input2').value === 'Activo';

                        const id = marca.consecmarca; // Obtén el ID de la marca
                        const url = `https://ferresysrender.onrender.com/marcas/${id}`; // Incluye el ID en la URL

                        const response = await fetch(url, {
                            method: 'PUT',
                            headers: {
                                'Content-Type': 'application/json',
                            },
                            body: JSON.stringify({
                                nomMarca: nommarca,
                                estado,
                            }),
                        });

                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }

                        marca.nommarca = nommarca;
                        marca.estado = estado; // Actualizar el estado de la marca en el objeto marca

                        row.children[1].textContent = marca.nommarca;
                        row.children[2].children[0].textContent = marca.estado ? 'Activo' : 'Inactivo';
                        row.children[2].children[0].className = marca.estado ? 'my-success' : 'my-danger';
                    }
                }).then((result) => {
                    if (result.isConfirmed) {
                        Swal.fire({
                            position: 'top',
                            icon: 'success',
                            title: 'La marca ha sido editada.',
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

            // Agregar evento de click al botón de eliminar
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
                        const id = marca.consecmarca; // Obtén el ID de la marca
                        const url = `https://ferresysrender.onrender.com/marcas/${id}`; // Incluye el ID en la URL

                        const response = await fetch(url, {
                            method: 'DELETE',
                        });

                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }

                        // Aquí puedes agregar el código para eliminar la fila de la interfaz de usuario
                        row.remove();

                        Swal.fire({
                            position: 'top-end',
                            icon: 'info',
                            html: '<i class="fas fa-trash"></i> La marca ha sido eliminada',
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




document.getElementById('filtro').addEventListener('click', () => {
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
            filtrarMarcas(result.value);
        }
    });

});

function filtrarMarcas(estado) {
    const token = localStorage.getItem('token');

    fetch('https://ferresysrender.onrender.com/marcas', {
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
            let marcasFiltradas;

            if (estado === '') {
                // Si el usuario seleccionó "Todos", no filtrar las marcas
                marcasFiltradas = data;
            } else {
                // Si el usuario seleccionó "Activos" o "Inactivos", filtrar las marcas por estado
                const estadoBool = estado === 'true';
                marcasFiltradas = data.filter(marca => marca.estado === estadoBool);
            }

            // Actualizar la lista de marcas con las marcas filtradas
            consultarMarcas(marcasFiltradas);
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
        fetch('https://ferresysrender.onrender.com/generate-pdf', {
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