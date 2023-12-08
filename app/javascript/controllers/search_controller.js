import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ['search'];

  connect() {
    console.log('Search controller connected');
  }

  search(event) {
    console.log('in the search func');
    const searchTerm = this.searchTarget.value;
    window.location.href = `/search?query=${encodeURIComponent(searchTerm)}`;
  }
}
