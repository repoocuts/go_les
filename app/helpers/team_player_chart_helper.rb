module TeamPlayerChartHelper

	def team_player_season_goals
		column_chart team_player_season_goals_path(@team.current_team_season.id),
		             colors: ['red'],
		             library: {
			             yAxis: {
				             title: { text: 'Goals' },
				             allowDecimals: false,
				             minTickInterval: 1
			             },
			             xAxis: {
				             labels: { enabled: false }
			             },
			             backgroundColor: 'rgb(247 254 231)',
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
end