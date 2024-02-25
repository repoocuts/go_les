module TeamPlayerChartHelper

	def team_player_season_goals
		column_chart team_player_season_goals_path(@team.current_team_season.id),
		             colors: ['red'],
		             library: {
			             plugins: {
				             title: {
					             text: 'Goals',
					             display: true,
					             font: {
						             size: 11
					             }
				             }
			             },
			             backgroundColor: 'rgb(247 254 231)',
		             }
	end

	def team_player_season_assists
		column_chart team_player_season_assists_path(@team.current_team_season.id),
		             colors: ['black'],
		             library: {
			             plugins: {
				             title: {
					             text: 'Assists',
					             display: true,
					             font: {
						             size: 11
					             }
				             }
			             }
		             }
	end

	def team_player_season_yellow_cards
		column_chart team_player_season_assists_path(@team.current_team_season.id),
		             colors: ['yellow'],
		             library: {
			             plugins: {
				             title: {
					             text: 'Yellow Cards',
					             display: true,
					             font: {
						             size: 11
					             }
				             }
			             }
		             }
	end

	def team_cards_line_chart
		line_chart team_cards_line_chart_path(@team.id, @next_opponent.id),
		           library: {
			           backgroundColor: 'transparent',
			           scales: {
				           x: {
					           ticks: {
						           font: {
							           size: 10
						           }
					           }
				           }
			           },
			           plugins: {
				           tooltip: {
					           labels: {
						           font: {
							           size: 10
						           }
					           }
				           }
			           }
		           }
	end
end
