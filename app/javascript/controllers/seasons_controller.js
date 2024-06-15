import {Controller} from "@hotwired/stimulus";

export default class extends Controller {
	connect() {
		console.log('Season controller connected');
		this.setupLinks();
	}

	setupLinks() {
		this.element.querySelectorAll('.season-link').forEach(link => {
			link.addEventListener('click', this.loadSeasonContent.bind(this));
		});
	}

	loadSeasonContent(event) {
		event.preventDefault();
		const seasonId = event.currentTarget.dataset.seasonId;
		const url = `/countries/${this.element.dataset.countryId}/leagues/${this.element.dataset.leagueId}/seasons/${seasonId}`;

		fetch(url, {
			headers: {
				'Accept': 'text/vnd.turbo-stream.html'
			}
		})
		.then(response => response.text())
		.then(html => {
			Turbo.renderStreamMessage(html);
		})
		.catch(error => console.error('Error loading season content:', error));
	}
}
