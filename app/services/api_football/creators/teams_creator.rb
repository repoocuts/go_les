module ApiFootball
	module Creators
		class TeamsCreator < ApplicationService

			def initialize(league:, season:)
				@league = league
				@season = season
			end

			def call
				teams = make_api_call['response']

				return :failure if teams.nil?

				teams.map { |elem| create_from_response(elem) }

				Rails.logger.info("Teams creator succeeded")
				:success
			end

			private

			attr_reader :league, :season

			def make_api_call
				ApiFootball::ApiFootballCall.new(endpoint: 'teams', options: { league: league.api_football_id, season: season.start_date.year }).make_api_call
			end

			def create_from_response(response_element)
				team = Team.find_by(api_football_id: response_element['team']['id'])
				unless team
					team = Team.create(
						acronym: response_element['team']['code'],
						api_football_id: response_element['team']['id'],
						league_id: league.id,
						country_id: league.country.id,
						name: response_element['team']['name']
					)

					object_handling_failure(response_element, league.country.id, league.id) if team.nil?
				end

				ApiFootball::Creators::TeamSeasonCreator.new(team:, season:).call
			end

			def object_handling_failure(element, related_country_id, related_league_id)
				ObjectHandlingFailure.create(object_type: 'team', api_response_element: element, related_country_id:, related_league_id:)
			end
		end
	end
end
