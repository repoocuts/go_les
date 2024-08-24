import {Controller} from "@hotwired/stimulus";

// Connects to data-controller="players"
export default class extends Controller {
	static targets = ["scrollies"];

	connect() {
		console.log("Players controller connected");
		if (this.hasScrolliesTarget) {
			this.setupInfiniteScroll(this.scrolliesTarget, this.loadMore.bind(this));
		}
	}

	setupInfiniteScroll(target, loadMoreFunction) {
		target.addEventListener(
				"scroll",
				debounce(() => {
					const {scrollTop, scrollHeight, clientHeight} = target;
					if (scrollTop + clientHeight >= scrollHeight - 10) {
						loadMoreFunction();
					}
				}, 100)
		);
	}

	loadMore() {
		const nextPage = parseInt(this.scrolliesTarget.dataset.nextPage, 10);
		if (nextPage) {
			const url = new URL(`/players/players_streaming`, window.location.origin);
			url.searchParams.set("page", nextPage);

			fetch(url.toString(), {
				headers: {
					Accept: "text/vnd.turbo-stream.html",
				},
			})
			.then((response) => response.text())
			.then((html) => {
				Turbo.renderStreamMessage(html);
				this.scrolliesTarget.dataset.nextPage = nextPage + 1; // Update the nextPage data attribute
			})
			.catch((error) => console.error("Failed to load more content:", error));
		}
	}
}

function debounce(func, wait) {
	let timeout;
	return function (...args) {
		clearTimeout(timeout);
		timeout = setTimeout(() => func.apply(this, args), wait);
	};
}
