module CheckPlayerExists

	def verify_data(lineups, fixture)
		find_or_create_players(lineups, fixture)
	end

	private

	attr_reader :team_data_api_object

	def get_current_team_season(team_api_football_id)
		Team.find_by(api_football_id: team_api_football_id).current_team_season
	end

	def find_or_create_players(lineups, fixture)
		lineups.each do |lineup|
			team = Team.find_by_api_football_id(lineup['team']['id'])
			all_data = lineup['startXI'] + lineup['substitutes']
			all_data.each do |player_data|
				# This puts is so you can find the appearance & player for a borked fixture_event
				puts "find_or_create_players method API FOOTBALL ID = #{player_data['player']['id']}"
				player = Player.where(api_football_id: player_data['player']['id']).first
				next if player && player.player_seasons.count > 0

				if player.nil?
					player = Player.create(
						short_name: player_data['player']['name'],
						position: player_data['player']['pos'],
						team_id: team.id,
						api_football_id: player_data['player']['id']
					)
					create_player_season(player, team.current_team_season)
				else
					create_player_season(player, team.current_team_season)
				end
			end
		end
	end

	def create_player_season(player, team_season)
		PlayerSeason.create(
			player: player,
			team_season: team_season,
			current_season: true,
		)
	end
end
