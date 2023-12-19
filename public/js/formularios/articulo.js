/* formulario Articulos*/

document.addEventListener("DOMContentLoaded", function () {
  const form = document.getElementById("registroForm");

  form.addEventListener("submit", function (e) {
    e.preventDefault();
    const formData = new FormData(form);

    // Crear un objeto para almacenar los datos
    const data = {};

    formData.forEach((value, key) => {
      data[key] = value;
    });

    fetch("https://ferresysrender.onrender.com/articulos", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(data),
    })
      .then((response) => response.json())
      .then((data) => {
        // Manejar la respuesta del servidor (si es necesario)
        console.log(data);

        // Limpiar los campos del formulario
        form.reset();
      })
      .catch((error) => {
        console.error("Error:", error);
      });
  });
});