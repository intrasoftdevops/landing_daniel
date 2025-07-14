document.addEventListener("DOMContentLoaded", () => {
  const navToggle = document.querySelector(".nav-toggle");
  const nav = document.querySelector(".nav");

  navToggle.addEventListener("click", () => {
    nav.classList.toggle("open");

    // Cambia icono de barra a X
    if (nav.classList.contains("open")) {
      navToggle.innerHTML = "<i class='fa-solid fa-xmark'></i>";
    } else {
      navToggle.innerHTML = "<i class='fa-solid fa-bars'></i>";
    }
  });
}); 