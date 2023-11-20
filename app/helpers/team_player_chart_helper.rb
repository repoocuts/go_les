module TeamPlayerChartHelper

	def team_player_season_goals
		column_chart team_player_season_goals_path(@team.current_team_season.id),
		             colors: ['red'],
		             library: {
			             yAxis: {
				             title: {
					             text: 'Goals' },
				             allowDecimals: false,
				             minTickInterval: 1
		             },
			             xAxis: {
				             labels: {
					             enabled: false
				             }
			             }
		             }
	end

	def team_player_season_assists
		column_chart team_player_season_assists_path(@team.current_team_season.id),
		             colors: ['black'],
		             library: {
			             yAxis: {
				             title: {
					             text: 'Assists' },
				             allowDecimals: false,
				             minTickInterval: 1
			             },
			             xAxis: {
				             labels: {
					             enabled: false
				             }
			             }
		             }
	end

	def team_player_season_yellow_cards
		column_chart team_player_season_assists_path(@team.current_team_season.id),
		             colors: ['yellow'],
		             library: {
			             yAxis: {
				             title: {
					             text: 'Yellow Cards' },
				             allowDecimals: false,
				             minTickInterval: 1
			             },
			             xAxis: {
				             labels: {
					             enabled: false
				             }
			             }
		             }
	end

	def radar_chart_thingy(current_team_season, opponent_team_season)
		# Prepare data for the current team
		current_team_season_data = [
			current_team_season.goals_for.size,
			current_team_season.goals_against_number,
			current_team_season.yellow_card_count,
			current_team_season.red_card_count,
			current_team_season.home_goals_scored.size,
			current_team_season.away_goals_scored.size,
			current_team_season.home_goals_conceded_count,
			current_team_season.away_goals_conceded_count,
			current_team_season.home_yellow_cards.size,
			current_team_season.away_yellow_cards.size
		]

		# Prepare data for the opponent team
		opponent_team_season_data = [
			opponent_team_season.goals_for.size,
			opponent_team_season.goals_against_number,
			opponent_team_season.yellow_card_count,
			opponent_team_season.red_card_count,
			opponent_team_season.home_goals_scored,
			opponent_team_season.away_goals_scored,
			opponent_team_season.home_goals_conceded_count,
			opponent_team_season.away_goals_conceded_count,
			opponent_team_season.home_yellow_cards.size,
			opponent_team_season.away_yellow_cards.size
		]

		# Radar chart data structure
		data = {
			labels: ['Scored', 'Conceded', 'Bookings', 'Reds', 'Home Scored', 'Away Scored', 'Home Conceded', 'Away Conceded', 'Home Bookings', 'Away Bookings'],
			datasets: [
				{
					label: current_team_season.team_name,
					data: current_team_season_data,
					fill: true,
					backgroundColor: 'rgba(255, 99, 132, 0.2)',
					borderColor: 'rgb(255, 99, 132)',
					pointBackgroundColor: 'rgb(255, 99, 132)',
					pointBorderColor: '#fff',
					pointHoverBackgroundColor: '#fff',
					pointHoverBorderColor: 'rgb(255, 99, 132)'
				},
				{
					label: opponent_team_season.team_name,
					data: opponent_team_season_data,
					fill: true,
					backgroundColor: 'rgba(54, 162, 235, 0.2)',
					borderColor: 'rgb(54, 162, 235)',
					pointBackgroundColor: 'rgb(54, 162, 235)',
					pointBorderColor: '#fff',
					pointHoverBackgroundColor: '#fff',
					pointHoverBorderColor: 'rgb(54, 162, 235)'
				}
			]
		}

		@radar_chart_data = data
	end
end