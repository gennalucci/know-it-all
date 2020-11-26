const initTopics = () => {
  const topicTagContainer = document.getElementById("topic-tag-container");

  if (topicTagContainer){
    const url = window.location.origin;
    const elements = topicTagContainer.querySelectorAll("li");

    //Add event listeners to all LIs
    elements.forEach(element => {
      element.addEventListener("click", (e) =>{
        element.classList.toggle("selected");
      })
    });

    //Add event listener to next button
    const nextButton = document.getElementById("btn-next");
    nextButton.addEventListener("click", (e) => {
      const selectedElements = topicTagContainer.querySelectorAll(".selected");

      const elementIds = Array.from(selectedElements).map(element => {
        return element.dataset.elementId;
      });

      console.log(selectedElements[0].dataset.element);
      if (selectedElements[0].dataset.element === "topic") {
        window.location.replace(`${url}/user_tags/new?elementIds=${elementIds.join(',')}`);
      } else {
        window.location.replace(`${url}/user_tags/create?elementIds=${elementIds.join(',')}`);
      }
    })
  }
}

// Check if html file has container-id
// if yes, then event listener on li's
// toggle class when user selects topic
// add event listener on next button
// find all buttons selected (by class)
// pull data-set-id from all buttons selected by user
// create a url containing all IDs
// send user to next page/url where they can choose tags
export { initTopics };
