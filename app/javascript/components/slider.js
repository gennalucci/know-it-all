const loadSlider = () => {
  const slider = document.getElementById("myRange");
console.log("test");
  if (slider){
    const output = document.getElementById("time-preference");
    output.innerHTML = slider.value; // Display the default slider value

    // Update the current slider value (each time you drag the slider handle)
    slider.oninput = function() {
      output.innerHTML = this.value;
    }
  }
}

export { loadSlider }
