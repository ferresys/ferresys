//agregar proveedores
document.addEventListener("DOMContentLoaded", function () {
  const agregarProveedoresButton = document.getElementById("agregarProveedores");

  agregarProveedoresButton.addEventListener("click", function () {
    window.location.href = "registrarProveedor.html"; // Realizar la redirección
  });
});