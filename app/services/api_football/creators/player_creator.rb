module ApiFootball
	module Creators
		class PlayerCreator < ApplicationService
			include PlayerSeasonCreatorHelper

			def initialize(team:)
				@team = team
			end

			def call
				players = make_api_call['response'][0]['players']

				return :failure if players.blank?

				players.map { |elem| create_from_response(elem) }

				:success
			end

			private

			attr_reader :team

			def make_api_call
				ApiFootball::ApiFootballCall.new(endpoint: 'players/squads', options: { team: team.api_football_id }).make_api_call
			end

			def create_from_response(response_element)
				slug = response_element['name'].parameterize + SecureRandom.hex(3)

				player = Player.find_by(api_football_id: response_element['id']) || Player.create(full_name: response_element['name'], api_football_id: response_element['id'], position: response_element['position'], team_id: team.id, slug: slug)

				create_player_season(player, team.current_team_season)

				object_handling_failure(response_element, team.id) if player.nil?
			end

			def object_handling_failure(element, related_team_id)
				ObjectHandlingFailure.create(object_type: 'player', api_response_element: element, related_team_id:)
			end
		end
	end
end
