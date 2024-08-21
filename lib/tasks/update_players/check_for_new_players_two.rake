namespace :check_for_new_players_two do
	desc "Check for new players in La Liga, Süper Lig, Liga MX"
	task setup: :environment do
		include PlayerSeasonCreatorHelper
		counter = ApiCallCount.first_or_create(count: 0)
		counter.update(count: 0)

		leagues = League.not_hidden.where(id: [4, 5, 37])

		leagues.each do |league|
			puts "Updating #{league.name}"
			teams_to_update = league.teams_for_current_season
			puts "Counter count is #{counter.count}"

			teams_to_update.each do |team|
				players = team.players
				team_season_id = team.current_team_season.id
				counter.increment_count

				api_call = ApiFootball::ApiFootballCall.new(endpoint: 'players/squads', options: { team: team.api_football_id }).make_api_call
				sleep 2
				puts "Updating #{team.name} post API Call sleep"

				api_response_players = api_call['response'][0]['players']
				api_response_ids = api_response_players.pluck("id")

				player_api_id_attributes = players.pluck(:api_football_id)
				ids_not_in_api_response = player_api_id_attributes - api_response_ids

				remove_existing_player_seasons(players, ids_not_in_api_response, team_season_id)

				ids_not_in_database = api_response_ids - player_api_id_attributes
				filtered_players = api_response_players.select { |player| ids_not_in_database.include?(player["id"]) }
				puts "FILTERED players #{filtered_players.length}"
				create_new_players_from_filtered_players(filtered_players, team)
			end
		end
	end

	def remove_existing_player_seasons(players, ids_not_in_api_response, team_season_id)
		database_players = players.where(api_football_id: ids_not_in_api_response)
		database_players.each do |p|
			player_seasons = p.player_seasons.where(team_season_id: team_season_id)
			if player_seasons.length > 0
				player_seasons.first.destroy unless player_seasons.first.appearances.any?
			end
		end
	end

	def create_new_players_from_filtered_players(filtered_players, team)
		filtered_players.each do |response_element|
			create_from_response(response_element, team)
		end
	end

	def create_from_response(response_element, team)
		slug = response_element['name'].parameterize + SecureRandom.hex(3)

		player = Player.find_by(api_football_id: response_element['id']) ||
			Player.create(
				full_name: response_element['name'],
				api_football_id: response_element['id'],
				position: response_element['position'],
				team_id: team.id,
				slug: slug
			)

		player.update(position: response_element['position'], slug: slug) if player.slug.nil?
		player.update(team:) if player.team != team

		create_player_season(player, team.current_team_season)
		puts "Created a player season for #{player.return_name} id #{player.id}, team #{team.name}" if player
		object_handling_failure(response_element, team.id) if player.nil?
	end

	def object_handling_failure(element, related_team_id)
		ObjectHandlingFailure.create(object_type: 'player', api_response_element: element, related_team_id:)
	end
end
