document.getElementById('logoutLink').addEventListener('click', function(event) {
    event.preventDefault();

    function logout() {
        localStorage.removeItem('token');

        document.cookie = 'token=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;';

        window.location.href = 'signin.html';
    }

    logout();
});