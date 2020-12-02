import { Controller } from "stimulus";

export default class extends Controller {

  static targets = ["content"]

  connect() {
    //console.log('Hello!');
  }

  seeMore(event) {
    // store the <a> inside a variable
    const link = event.currentTarget;
    // print the current topic to console
    const topic = link.dataset.topic;
    // console.log(topic);

    // send a fetch() request to the server with the topic in params
    fetch(`/show_all_articles?topic=${topic}&time=10`)
    .then(response => response.json())
    .then((data) => {
      // query select the card container in the DOM and store it in a variable
      // load the JSON of all the new cards into the card container
      const container = link.parentElement;
      container.innerHTML = "";

      data.articles.slice(0, 10).forEach(article => {
        container.insertAdjacentHTML('beforeEnd', article);
      });
      link.remove();
      const seeLessLink = `<a class="" data-action="articles#seeLess" data-topic="${topic}"> see less </a>`;

      container.insertAdjacentHTML("beforeEnd", seeLessLink);
    });
  }

  seeLess(event) {
    const topic = event.currentTarget.dataset.topic;
    const cards = Array.from(this.contentTargets).filter((el) => {
      return el.dataset.articletopic === topic;
    });
    const cardsToHide = cards.slice(4, 10);

    cardsToHide.forEach((card) => {
      card.classList.toggle("card-hidden")
    });

    const text = event.currentTarget.innerText;

    if (text === "see less") {
      event.currentTarget.innerText = "See More";
    } else {
      event.currentTarget.innerText = "see less";
    }
  }
}









