module CheckPlayerExists

	def verify_data(lineups, fixture)
		find_or_create_players(lineups, fixture)
	end

	private

	def find_or_create_players(lineups, fixture)
		lineups.each do |lineup|
			team = home_team(fixture).api_football_id == lineup['team']['id'] ? home_team(fixture) : away_team(fixture)
			all_data = lineup['startXI'] + lineup['substitutes']

			all_data.each do |player_data|
				# This puts is so you can find the appearance & player for a borked fixture_event
				puts "find_or_create_players method API FOOTBALL ID = #{player_data['player']['id']}"
				player = Player.find_or_initialize_by(api_football_id: player_data['player']['id'])

				unless player.persisted? && player.player_seasons.exists?
					player.assign_attributes(
						short_name: player_data['player']['name'],
						position: map_position_initial(player_data['player']['pos']),
						team_id: team.id
					)
					player.save! if player.changed?

					create_player_season(player, team.current_team_season)
				end
			end
		end
	end

	def create_player_season(player, team_season)
		PlayerSeason.create(
			player_id: player.id,
			team_season_id: team_season.id,
			current_season: true,
		)
	end

	def home_team(fixture)
		@home_team ||= fixture.home_team_object
	end

	def away_team(fixture)
		@away_team ||= fixture.away_team_object
	end

	def map_position_initial(initial)
		case initial
		when 'G'
			'Goalkeeper'
		when 'D'
			'Defender'
		when 'M'
			'Midfielder'
		when 'A'
			'Attacker'
		else
			'Attacker'
		end
	end
end
