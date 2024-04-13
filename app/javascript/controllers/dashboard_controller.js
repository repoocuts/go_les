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
		const nextPage = parseInt(this.scrolliesTarget.dataset.nextPage);
		if (nextPage) {
			const url = new URL(window.location);
			url.searchParams.set('page', nextPage);
			fetch(url.toString(), {
				headers: {
					'Accept': 'text/vnd.turbo-stream.html'
				}
			}).then(response => response.text())
			.then(html => {
				Turbo.renderStreamMessage(html);
				this.scrolliesTarget.dataset.nextPage = nextPage + 1; // Update the nextPage data attribute
			}).catch(error => console.error('Failed to load more content:', error));
		}
	}
}
