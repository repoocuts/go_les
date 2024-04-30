module ApiFootball
	module Creators
		class LeagueCreator < ApplicationService

			LEAGUES = ["Premier League", "Ligue 1", "Serie A", "La Liga", "Bundesliga", "Primeira Liga", "Premiership"].freeze

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
				country = get_country(response_element['country']['name'])
				league_name = response_element['league']['name']
				if country
					League.create(
						name: league_name,
						api_football_id: response_element['league']['id'],
						country:
					) if LEAGUES.include?(league_name) && !country.leagues.where(name: league_name).any?
				end
			end

			def get_country(country_name)
				Country.find_by(name: country_name)
			end
		end
	end
end
