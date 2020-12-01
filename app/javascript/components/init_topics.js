const initUnselectAlreadySelectedTags = () => {
  const alreadySelectedTags = document.querySelectorAll(".selected-tags > .tag-button");
  alreadySelectedTags.forEach((tag) => {
    tag.addEventListener("click", (e) => {
      const tagId = tag.dataset.elementId;
      const tagOnTop = document.querySelector(`.unselected-tags .tag-button[data-element-id='${tagId}']`);
      tag.remove();
      tagOnTop.classList.remove("tag-hidden");
      tagOnTop.classList.remove("selected");
    });
  });
};

const buildHtml = ((element, tagContainer) => {
  const tagId = element.dataset.elementId;
  const newButton = `<button class="tag-button selected-tag topic-tag-button" data-element-id="${tagId}" data-element="tag">${element.innerText}</button>`;
  tagContainer.insertAdjacentHTML('beforeend', newButton);
  element.classList.add("tag-hidden");
  const newButtonElement = tagContainer.querySelector(`[data-element-id='${tagId}'`);
  newButtonElement.addEventListener("click", (e) => {
    newButtonElement.remove();
    element.classList.remove("tag-hidden");
    element.classList.remove("selected");
  })
});
const selectTags = (wrappers) => {
  wrappers.forEach((wrapper) => {
    const buttons = wrapper.querySelectorAll(".unselected-tags .topic-tag-button");
    const wrapperName = wrapper.dataset.topicWrapper;
    const tagContainer = wrapper.querySelectorAll(`[data-topic-tags='${wrapperName}']`);
    buttons.forEach((button) => {
      button.addEventListener('click', (e) => {
        const element = e.currentTarget;
        buildHtml(element, tagContainer[0]);
      });
    });
  });
};
const selectTopics = (elements) => {
  elements.forEach((el) => {
    el.addEventListener('click', (e) => {
      e.currentTarget.classList.toggle('selected');
    });
  })
};
const initTopics = () => {
  initUnselectAlreadySelectedTags();
  const topicTagContainer = document.getElementById("topic-tag-container");
  if (topicTagContainer){
    const url = window.location.origin;
    const elements = topicTagContainer.querySelectorAll(".topic-tag-button");
    if (elements.length > 0) { selectTopics(elements); }
    const wrappers = document.querySelectorAll("[data-topic-wrapper]");
    if (wrappers.length > 0) { selectTags(wrappers); }
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
export { initTopics };
