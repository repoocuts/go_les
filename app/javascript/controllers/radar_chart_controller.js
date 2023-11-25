// noinspection NpmUsedModulesInstalled

import {Controller} from '@hotwired/stimulus';
import {Chart, registerables} from 'chart.js';

Chart.register(...registerables);

export default class extends Controller {
  static values = {currentTeamSeasonId: Number, opponentTeamSeasonId: Number}

  connect() {
    this.fetchChartData().then(data => {
      this.initializeChart(data);
    });
  }

  fetchChartData() {
    return fetch(`/radar_chart_thingy/${this.currentTeamSeasonIdValue}/${this.opponentTeamSeasonIdValue}`)
    .then(response => response.json());
  }

  initializeChart(data) {
    const ctx = this.element.querySelector('canvas').getContext('2d');

    new Chart(ctx, {
      type: 'radar',
      data: data,
      options: {
        responsive: false,
        elements: {
          line: {
            borderWidth: 3
          }
        }
      }
    });
  }
}
