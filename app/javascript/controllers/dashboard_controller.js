import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="dashboard"
export default class extends Controller {
	static targets = ["scrollies", 'assisties', 'bookies', 'reddies'];

	connect() {
		console.log('Dashboard controller connected');
		if (this.hasScrolliesTarget) {
			this.setupInfiniteScroll(this.scrolliesTarget, 'loadMore');
		}
		if (this.hasAssistiesTarget) {
			this.setupInfiniteScroll(this.assistiesTarget, 'loadMoreAssists');
		}
		if (this.hasBookiesTarget) {
			this.setupInfiniteScroll(this.bookiesTarget, 'loadMoreBookings');
		}
		if (this.hasReddiesTarget) {
			this.setupInfiniteScroll(this.reddiesTarget, 'loadMoreReds');
		}
	}

	setupInfiniteScroll(target, methodName) {
		target.addEventListener('scroll', () => {
			const {scrollTop, scrollHeight, clientHeight} = target;
			if (scrollTop + clientHeight >= scrollHeight - 10) {
				this[methodName]();
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

	loadMoreAssists() {
		const nextPage = parseInt(this.assistiesTarget.dataset.nextPage);
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
				this.assistiesTarget.dataset.nextPage = nextPage + 1; // Update the nextPage data attribute
			}).catch(error => console.error('Failed to load more content:', error));
		}
	}

	loadMoreBookings() {
		const nextPage = parseInt(this.bookiesTarget.dataset.nextPage);
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
				this.bookiesTarget.dataset.nextPage = nextPage + 1; // Update the nextPage data attribute
			}).catch(error => console.error('Failed to load more content:', error));
		}
	}

	loadMoreReds() {
		const nextPage = parseInt(this.reddiesTarget.dataset.nextPage);
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
				this.reddiesTarget.dataset.nextPage = nextPage + 1; // Update the nextPage data attribute
			}).catch(error => console.error('Failed to load more content:', error));
		}
	}
}
