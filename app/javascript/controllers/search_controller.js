import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
	static targets = ['search', 'table'];

	connect() {
		console.log('Search controller connected');

		const userTimeZone = Intl.DateTimeFormat().resolvedOptions().timeZone;
		this.setCookie('timezone', userTimeZone, 365);
	}

	search(event) {
		console.log('in the search func');
		const searchTerm = this.searchTarget.value;
		window.location.href = `/search?query=${encodeURIComponent(searchTerm)}`;
	}

	sort(event) {
		const column = event.target.cellIndex;
		const order = event.target.dataset.order || 'asc'; // Toggle sort direction
		const rows = Array.from(this.tableTarget.rows).slice(1); // Skip header row

		const sortedRows = rows.sort((a, b) => {
			const aValue = a.cells[column].innerText;
			const bValue = b.cells[column].innerText;

			return order === 'asc' ? aValue.localeCompare(bValue, undefined, {numeric: true}) : bValue.localeCompare(aValue, undefined, {numeric: true});
		});

		// Toggle order for the next click
		event.target.dataset.order = order === 'asc' ? 'desc' : 'asc';

		// Append sorted rows back to the table
		sortedRows.forEach(row => this.tableTarget.appendChild(row));
	}

	setCookie(name, value, days) {
		const date = new Date();
		date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
		const expires = "expires=" + date.toUTCString();
		document.cookie = name + "=" + value + ";" + expires + ";path=/";
	}
}
