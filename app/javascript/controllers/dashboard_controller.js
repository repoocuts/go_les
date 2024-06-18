import {Controller} from "@hotwired/stimulus";

// Connects to data-controller="dashboard"
export default class extends Controller {
	static targets = ["scrollies", "assisties", "bookies", "reddies"];

	connect() {
		console.log("Dashboard controller connected");
		if (this.hasScrolliesTarget) {
			this.setupInfiniteScroll(this.scrolliesTarget, this.loadMore.bind(this));
		}
		if (this.hasAssistiesTarget) {
			this.setupInfiniteScroll(this.assistiesTarget, this.loadMoreAssists.bind(this));
		}
		if (this.hasBookiesTarget) {
			this.setupInfiniteScroll(this.bookiesTarget, this.loadMoreBookings.bind(this));
		}
		if (this.hasReddiesTarget) {
			this.setupInfiniteScroll(this.reddiesTarget, this.loadMoreReds.bind(this));
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
		this.loadMoreGeneric(this.scrolliesTarget, "scorers_streaming");
	}

	loadMoreAssists() {
		this.loadMoreGeneric(this.assistiesTarget, "assists_streaming");
	}

	loadMoreBookings() {
		this.loadMoreGeneric(this.bookiesTarget, "bookings_streaming");
	}

	loadMoreReds() {
		this.loadMoreGeneric(this.reddiesTarget, "reds_streaming");
	}

	loadMoreGeneric(target, endpoint) {
		const nextPage = parseInt(target.dataset.nextPage);
		const currentUrl = new URL(window.location.href);
		const pathname = currentUrl.pathname;
		const pathSegments = pathname.split("/");
		const countryParam = pathSegments[2]; // Adjust the index if needed
		const leagueParam = pathSegments[4]; // Adjust the index if needed
		const seasonParam = pathSegments[6]; // Adjust the index if needed

		if (nextPage) {
			const url = new URL(
					`/countries/${countryParam}/leagues/${leagueParam}/seasons/${seasonParam}/${endpoint}`,
					window.location.origin
			);
			url.searchParams.set("page", nextPage);
			url.searchParams.set("country_id", countryParam);
			url.searchParams.set("league_id", leagueParam);
			url.searchParams.set("id", seasonParam);

			fetch(url.toString(), {
				headers: {
					Accept: "text/vnd.turbo-stream.html",
				},
			})
			.then((response) => response.text())
			.then((html) => {
				Turbo.renderStreamMessage(html);
				target.dataset.nextPage = nextPage + 1; // Update the nextPage data attribute
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
