//resetear password


function getParameterByName(name, url = window.location.href) {
    name = name.replace(/[\[\]]/g, '\\$&');
    var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, ' '));
}

export function resetPassword() {
    const form = document.getElementById('resetPasswordForm');
    form.addEventListener('submit', (event) => {
        event.preventDefault();

        const token = getParameterByName('token'); // Get token from URL
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (password !== confirmPassword) {
            Swal.fire("¡Error!", "Las contraseñas no coinciden.", "error");
            return;
        }

        fetch(`http://localhost:4000/api/auth/reset/${token}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                password: password
            })
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Error: ' + response.statusText);
                }
                return response.json();
            })
            .then(data => {
                Swal.fire("¡Éxito!", "Tu contraseña ha sido restablecida.", "success")
                    .then(() => {
                        window.location.href = 'http://localhost:4000';
                    });
            })
            .catch(error => {
                Swal.fire("¡Error!", "No se pudo restablecer la contraseña.", "error");
            });
    });
}