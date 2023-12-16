document.getElementById('signupForm').addEventListener('submit', registerUser);
console.log(loginForm);

// Captura los datos del formulario de registro


function loginUser(event) {
    console.log('loginUser function called');
    event.preventDefault();

    let correo = document.getElementById('loginEmail').value;
    let contrasena = document.getElementById('floatingPassword').value;

    fetch('http://localhost:4000/api/auth/login', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            correo: correo,
            contrasena: contrasena
        })
    })
        .then(response => {
            if (!response.ok) {
                return response.json().then(data => {
                    // Si el estado de la respuesta es 401, muestra una alerta de "contraseña incorrecta"
                    if (response.status === 401) {
                        Swal.fire(
                            'Error al iniciar sesión',
                            'La contraseña que ingresaste es incorrecta. Por favor, inténtalo de nuevo.',
                            'error'
                        );
                    } else if (data.error === 'Email not confirmed') {
                        Swal.fire({
                            icon: 'info',
                            title: 'Aún no has sido autorizado',
                            text: 'Por favor, espera que el administrador te de acceso.'
                        });
                    }
                    // Devuelve una promesa rechazada con el error para pasar al bloque catch
                    return Promise.reject(data.error || 'El inicio de sesión falló');
                });
            }
            // Si la respuesta es OK, devuelve los datos de la respuesta
            return response.json();
        })
        .then(data => {
            // Si la respuesta es OK, redirige al usuario al 'index.html'
            window.location.href = '/home';
        })
        .catch(error => {
            console.error('Error:', error);
        });
}
document.getElementById('loginForm').addEventListener('submit', loginUser);

//cerrar sesion

document.addEventListener('DOMContentLoaded', (event) => {
    const logoutButton = document.getElementById('logoutButton');
    if (logoutButton) {
        logoutButton.addEventListener('click', handleLogout);
    } else {
        console.error('No se encontró el botón de cierre de sesión');
    }
});

function handleLogout(event) {
    // Prevenir el comportamiento predeterminado del enlace
    if (event) {
        event.preventDefault();
    }

    fetch('/api/auth/logout')
        .then(response => {
            if (response.ok) {
                // La sesión se cerró con éxito, redirigir al usuario a la página de inicio de sesión
                window.location.href = '/';
            } else {
                // Hubo un error al cerrar la sesión
                console.error('Error al cerrar la sesión.');
            }
        })
        .catch(error => {
            // Hubo un error de red
            console.error('Error de red:', error);
        });
}
function registerUser(e) {
    e.preventDefault();

    let user = {
        nombre: document.getElementById('name').value,
        correo: document.getElementById('signupEmail').value,
        contrasena: document.getElementById('password').value
    };

    fetch('http://localhost:4000/api/auth/register', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(user),
    })
        .then(response => response.json())
        .then(data => {
            console.log(data);
            return Swal.fire(
                'Registro exitoso!',
                'Por favor, espera a que te verifiquen.',
                'success'
            );
        })
        .then(() => {
            // Refrescar la página después de que el usuario haga clic en OK
            location.reload();
        })
        .catch(error => console.error('Error:', error));
}


