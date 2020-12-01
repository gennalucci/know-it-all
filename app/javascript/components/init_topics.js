const buildHtml = ((element, tagContainer) => {
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
