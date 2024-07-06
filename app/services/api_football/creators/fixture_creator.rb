module ApiFootball
	module Creators
		class FixtureCreator

			ENDPOINT = 'fixtures'

			def initialize(league:, season:)
				@league = league
				@season = season
			end

			def call
				Rails.logger.info "Creating fixtures for #{league.name} #{season.years}"
				fixtures = make_api_call['response']

				game_weeks = fixtures.map { |f| f['league']['round'] }.uniq
				game_weeks.each_with_index do |_game_week, index|
					SeasonGameWeek.create(season_id: season.id, game_week_number: index + 1)
				end

				fixtures.map { |elem| create_from_response(elem) }
			end

			def create_old_fixture
				fixtures = call['response']
				fixtures.map { |elem| create_old_from_response(elem) }
			end

			private

			attr_reader :league, :season

			def make_api_call
				Rails.logger.info "Making API call for #{ENDPOINT} options : { league: #{league.api_football_id}, season: #{season.start_date.year} }"
				ApiFootball::ApiFootballCall.new(endpoint: ENDPOINT, options: { league: league.api_football_id, season: season.start_date.year }).make_api_call
			end

			def create_from_response(response_element)
				return if Fixture.where(api_football_id: response_element['fixture']['id']).any?
				Rails.logger.info "Creating fixture for fixture.api_football_id #{response_element['fixture']['id']}"
				season_game_week = season.season_game_weeks.find_by(game_week_number: response_element['league']['round'].split('-').last.strip.to_i)
				fixture = Fixture.create(
					api_football_id: response_element['fixture']['id'],
					away_team_season_id: get_current_away_team_season_id(response_element['teams']['away']),
					home_team_season_id: get_current_home_team_season_id(response_element['teams']['home']),
					kick_off: response_element['fixture']['date'],
					league_id: league.id,
					season_id: season.id,
					season_game_week_id: season_game_week&.id,
				)

				FixtureApiResponse.create(fixture_id: fixture.id, pre_fixture: response_element)
			end

			def get_current_home_team_season_id(response_home_team_element)
				team = Team.find_by(api_football_id: response_home_team_element['id'])
				team.current_team_season.id
			end

			def get_current_away_team_season_id(response_away_team_element)
				team = Team.find_by(api_football_id: response_away_team_element['id'])
				team.current_team_season.id
			end
		end
	end
end
