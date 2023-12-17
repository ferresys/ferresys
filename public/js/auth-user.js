

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
    if (data.error) {
        // Si el servidor devuelve un error, muestra una alerta de error
        Swal.fire(
            'Error de registro',
            'El correo ya está registrado.',
            'error'
        );
    } else {
        // Si no hay error, muestra una alerta de éxito
        Swal.fire(
            'Registro exitoso!',
            'Por favor, espera a que te verifiquen.',
            'success'
        )
        .then(() => {
            // Refrescar la página después de que el usuario haga clic en OK
            location.reload();
        });
    }
})
.catch(error => console.error('Error:', error));
}

//recuperar contrasena

function forgotPassword() {
    Swal.fire({
        title: '¿Olvidaste tu contraseña?',
        text: 'Ingresa tu correo electrónico:',
        input: 'email',
        confirmButtonText: 'Enviar',
        allowOutsideClick: false
    })
        .then(result => {
            // Aquí usamos result.value para obtener el valor del input
            const correo = result.value;

            if (!correo) throw null;

            return fetch('http://localhost:4000/api/auth/forgot-password', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    correo: correo
                })
            });
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Error: ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            Swal.fire("¡Éxito!", "Se ha enviado un correo de restablecimiento de contraseña a tu correo electrónico.", "success");
        })
        .catch(error => {
            Swal.fire("¡Error!", "No se pudo enviar el correo de restablecimiento de contraseña.", "error");
        });
}


