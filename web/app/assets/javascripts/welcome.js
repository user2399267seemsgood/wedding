// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

document.addEventListener("DOMContentLoaded", function () {
  const container = document.getElementById("map-container");
  const container2 = document.getElementById("map-container-2");

  function loadMap() {
    container.innerHTML = `
      <iframe 
        src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d7211.010679701457!2d-7.481402999999999!3d38.022586!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd1094589d4e076f%3A0x9e06c98c3ae0693b!2sChurch%20of%20Santa%20Luzia!5e1!3m2!1sde!2sch!4v1757942027034!5m2!1sde!2sch"
        style="border:0; width: 100%; height: 20vh; min-height: 30em;"
        allowfullscreen=""
        loading="lazy" referrerpolicy="no-referrer-when-downgrade">
      </iframe>
    `;
    container2.innerHTML = `
      <iframe 
        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3607.6643235726633!2d-7.395886423791308!3d37.97868470038725!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd10ecf5b99ba2d5%3A0xc4f486de5c29ab21!2sMonte%20das%20Louzeiras!5e1!3m2!1sde!2sch!4v1757942252994!5m2!1sde!2sch"
        style="border:0; width: 100%; height: 20vh; min-height: 30em;"
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
  const button2 = document.getElementById("load-map-2");
  if (button2) {
    button2.addEventListener("click", function () {
      localStorage.setItem("mapConsent", "true");
      loadMap();
    });
  }
});
