const initTopics = () => {
  const topicContainer = document.getElementById("topic-container");
  if (topicContainer){
    const topics = topicContainer.querySelectorAll("li");
    //Add event listeners to all LIs
    topics.forEach(topic => {
      topic.addEventListener("click", (e) =>{
        topic.classList.toggle("selected");
      } )
    });
    //Add event listener to next button
    const nextButton = document.getElementById("btn-next");
    nextButton.addEventListener("click", (e) => {
      const selectedTopics = topicContainer.querySelectorAll(".selected");

      const topicIds = Array.from(selectedTopics).map(topic => {
        return topic.dataset.topicId;
      });
      console.log(topicIds);
      window.location.replace(`${window.location.orgin}/user_tags/new?topicIds=${topicIds.join(',')}`);
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
