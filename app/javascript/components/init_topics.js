const buildHtml = ((element, tagContainer) => {
  // console.log(element.innerText);
  const tagId = element.dataset.elementId;
  const newButton = `<button class="tag-button selected-tag topic-tag-button" data-element-id="${tagId}" data-element="tag">${element.innerText}</button>`;
  tagContainer.insertAdjacentHTML('beforeend', newButton);
  element.classList.add("tag-hidden");
});

const selectTags = (wrappers) => {
  wrappers.forEach((wrapper) => {
    const buttons = wrapper.querySelectorAll(".topic-tag-button");
    const wrapperName = wrapper.dataset.topicWrapper;
    const tagContainer = wrapper.querySelectorAll(`[data-topic-tags='${wrapperName}']`);

    // console.log(tagContainer);

    buttons.forEach((button) => {
      button.addEventListener('click', (e) => {
        const element = e.currentTarget;
        // element.classList.toggle("selected");
        buildHtml(element, tagContainer[0]);
      });
    });
  });
};

const initTopics = () => {
  const topicTagContainer = document.getElementById("topic-tag-container");

  if (topicTagContainer){
    const url = window.location.origin;
    const elements = topicTagContainer.querySelectorAll(".topic-tag-button");

    const wrappers = document.querySelectorAll("[data-topic-wrapper]");
    selectTags(wrappers);

    // const tagContainers = topicTagContainer.querySelectorAll(".selected-tags");

    //Add event listener to next button
    const nextButton = document.getElementById("btn-next");
    nextButton.addEventListener("click", (e) => {
      const selectedElements = topicTagContainer.querySelectorAll(".selected-tag");
      console.log(selectedElements);



      const elementIds = Array.from(selectedElements).map(element => {
        return element.dataset.elementId;
      });

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
