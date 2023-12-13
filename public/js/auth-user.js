document.getElementById('loginForm').addEventListener('submit', function(event) {
    event.preventDefault();

    const usuario = document.getElementById('floatingInput').value;
    const password = document.getElementById('floatingPassword').value;

    fetch('http://localhost:4000/login', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ usuario, password })
    })
    .then(response => response.json())
    .then(data => {
        console.log('Success:', data);
        if (data.token) {
            localStorage.setItem('token', data.token);
            document.cookie = `token=${data.token}; path=/`;
            window.location.href = 'index.html';
        } else {
            throw new Error('No se recibió ningún token');
        }
    })
    .catch((error) => {
        console.error('Error:', error);
        alert('Usuario o contraseña incorrectos');
    });
});