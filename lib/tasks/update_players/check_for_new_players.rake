namespace :check_for_new_players do
	desc "Check for new players"
	task setup: :environment do
		include PlayerSeasonCreatorHelper
		counter = ApiCallCount.first_or_create(count: 0)
		counter.update(count: 0)

		League.not_hidden.each do |league|
			next if counter.last_league_ids.include? league.id
			puts "Updating #{league.name}"
			teams_to_update = league.teams_for_current_season
			count_required = teams_to_update.count
			puts "Counter count is #{counter.count}"
			if counter.can_make_api_call?(count_required)
				teams_to_update.each do |team|
					players = team.players
					team_season_id = team.current_team_season.id
					counter.increment_count

					make_api_call = ApiFootball::ApiFootballCall.new(endpoint: 'players/squads', options: { team: team.api_football_id }).make_api_call
					sleep 2
					puts "Updating #{team.name} post API Call sleep"
					api_response_players = make_api_call['response'][0]['players']
					api_response_ids = api_response_players.pluck("id")
					player_api_id_attributes = team.players.pluck(:api_football_id)
					ids_not_in_api_response = player_api_id_attributes - api_response_ids

					database_players = players.where(api_football_id: ids_not_in_api_response)
					database_players.each do |p|
						player_seasons = p.player_seasons.where(team_season_id: team_season_id)
						if player_seasons.length > 0
							player_seasons.first.destroy unless player_seasons.first.appearances.any?
						end
					end

					ids_not_in_database = api_response_ids - player_api_id_attributes
					filtered_players = api_response_players.select { |player| ids_not_in_database.include?(player["id"]) }
					filtered_players.each do |response_element|
						create_from_response(response_element, team)
					end
					counter.update(last_team_id: team.id)
				end
				processed_leagues = counter.last_league_ids << league.id
				counter.update(last_league_id: processed_leagues)
			end
		end
	end

	def create_from_response(response_element, team)
		slug = response_element['name'].parameterize + SecureRandom.hex(3)

		player = Player.find_by(api_football_id: response_element['id']) || Player.create(full_name: response_element['name'], api_football_id: response_element['id'], position: response_element['position'], team_id: team.id, slug: slug)

		player.update(position: response_element['position'], slug: slug) if player.slug.nil?

		create_player_season(player, team.current_team_season)

		object_handling_failure(response_element, team.id) if player.nil?
	end

	def object_handling_failure(element, related_team_id)
		ObjectHandlingFailure.create(object_type: 'player', api_response_element: element, related_team_id:)
	end
end
