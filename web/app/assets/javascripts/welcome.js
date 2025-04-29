// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

document.addEventListener("DOMContentLoaded", function () {
  const container = document.getElementById("map-container");

  function loadMap() {
    container.innerHTML = `
      <iframe 
        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1279.2404895506465!2d8.774427678521535!3d47.20452317238129!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x479ab14e93de7655%3A0x6ef6304bfa438773!2sSchlossgut%20Pf%C3%A4ffikon!5e0!3m2!1sde!2sch!4v1695904978818!5m2!1sde!2sch"
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
