// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

document.addEventListener("DOMContentLoaded", function () {
  const container = document.getElementById("map-container");

  function loadMap() {
    container.innerHTML = `
      <iframe 
        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d11776384.336762946!2d-18.82697955!3d35.99157515!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xb32242dbf4226d5%3A0x2ab84b091c4ef041!2sPortugal!5e1!3m2!1sde!2sch!4v1746958467634!5m2!1sde!2sch"
        style="border:0; width: 100%; height: 30vh; min-height: 20em;"
        allowfullscreen=""
        loading="lazy" referrerpolicy="no-referrer-when-downgrade">
      </iframe>
    `;
  }

  // If already consented, load immediately
  if (localStorage.getItem("mapConsent") === "true") {
    loadMap();
  }

  // Otherwise, show button
  const button = document.getElementById("load-map");
  if (button) {
    button.addEventListener("click", function () {
      localStorage.setItem("mapConsent", "true");
      loadMap();
    });
  }
});
