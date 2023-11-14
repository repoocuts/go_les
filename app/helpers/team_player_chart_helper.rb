module TeamPlayerChartHelper

	def team_player_season_goals
		column_chart team_player_season_goals_path(@team.current_team_season.id),
		             colors: ['red'],
		             ytitle: 'Goals',
		             library: { title: { text: 'Top Scorers', align: 'center' }, yAxis: { title: { text: 'Goals' },
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
		             ytitle: 'Assists'
	end

	def team_player_season_yellow_cards
		column_chart team_player_season_assists_path(@team.current_team_season.id),
		             colors: ['yellow'],
		             ytitle: 'Assists'
	end
end