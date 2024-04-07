import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="dashboard"
export default class extends Controller {
	static targets = ["scrollies"];

	connect() {
		console.log('Dashboard controller connected');
		this.setupInfiniteScroll();
	}

	setupInfiniteScroll() {
		this.scrolliesTarget.addEventListener('scroll', () => {
			const {scrollTop, scrollHeight, clientHeight} = this.scrolliesTarget;
			// Check if we are near the bottom of the element
			if (scrollTop + clientHeight >= scrollHeight - 10) {
				this.loadMore();
			}
		});
	}

	loadMore() {
		const turboFrame = document.getElementById("top_scorers");
		if (!turboFrame) return;

		const srcAttr = turboFrame.getAttribute("src");
		if (!srcAttr) return;

		const nextUrl = new URL(srcAttr, window.location.origin);
		const nextPage = parseInt(turboFrame.dataset.nextPage) || 1;
		nextUrl.searchParams.set("page", nextPage);
		turboFrame.setAttribute("src", nextUrl.toString()); // Make sure to set the new URL back to the turbo frame's src attribute
		turboFrame.dataset.nextPage = nextPage + 1; // Increment for the next call
	}
}
