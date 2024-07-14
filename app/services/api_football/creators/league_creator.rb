module ApiFootball
	module Creators
		class LeagueCreator < ApplicationService
			LEAGUES = ['Liga MX', 'Serie A', 'Primeira Liga', 'La Liga', 'Süper Lig', 'Premier League']

			def call
				leagues = make_api_call['response']

				leagues.each do |elem|
					create_from_response(elem)
				end

				:success
			end

			private

			def make_api_call
				ApiFootball::ApiFootballCall.new(endpoint: 'leagues', options: nil).make_api_call
			end

			def create_from_response(response_element)
				api_football_id = response_element['league']['id']
				return if League.where(api_football_id:).any?

				country = get_country(response_element['country']['name'])
				name = response_element['league']['name']
				logo = response_element['league']['logo']
				hidden = LEAGUES.include?(name) ? false : true

				if false?(country.hidden)
					season_objects = response_element['seasons']
					league = League.create(api_football_id:, country:, hidden:, logo:, name:)
					ApiFootball::Creators::SeasonCreator.new(league:, season_objects:).call if false?(hidden)
				end
			end

			def get_country(country_name)
				Country.find_by(name: country_name)
			end
		end
	end
end
