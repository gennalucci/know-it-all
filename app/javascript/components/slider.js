const sendTime = (time) => {
};

const loadSlider = () => {
  const slider = document.getElementById("myRange");

  if (slider) {
    const output = document.getElementById("time-preference");
    output.innerHTML = slider.value; // Display the default slider value

    // Update the current slider value (each time you drag the slider handle)
    slider.oninput = function() {
      output.innerHTML = this.value;
    }

    const nextButton = document.getElementById("btn-go");

    nextButton.addEventListener("click", (e) => {
      console.log(output.innerHTML);
      const url = window.location.origin;
      window.location.replace(`${url}/dashboards?time=${output.innerHTML}`);

    });


  }
}

export { loadSlider }
