const buildHtml = ((element, tagContainer) => {
  const tagId = element.dataset.elementId;
  const newButton = `<button class="tag-button topic-tag-button" data-element-id="${tagId}" data-element="tag">${element.innerText}</button>`;
  console.log(element.innerText);
  tagContainer.insertAdjacentHTML('beforeend', newButton);
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
        element.classList.toggle("selected");
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

    //query select the selected-tags container and store into variable
    const tagContainers = topicTagContainer.querySelectorAll(".selected-tags");

    //Add event listener to next button
    const nextButton = document.getElementById("btn-next");
    nextButton.addEventListener("click", (e) => {
      const selectedElements = topicTagContainer.querySelectorAll(".selected");

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
