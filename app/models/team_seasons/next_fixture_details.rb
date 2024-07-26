module TeamSeasons
	class NextFixtureDetails

		def initialize(fixture:, team_season:)
			@fixture = fixture
			@team_season = team_season
		end

		def next_opponent_name
			next_fixture_team_name
		end

		def next_opponent_id
			return fixture.home_team_season_id if team_season == fixture.away_team_season

			fixture.away_team_season_id
		end

		def next_opponent_object
			return fixture.home_team_object if team_season == fixture.away_team_season

			fixture.away_team_object
		end

		def next_opponent_string
			return 'N/A' if fixture.nil?
			
			next_fixture_team_name + home_or_away_string
		end

		def home_or_away_identifier
			home_or_away_string
		end

		private

		attr_reader :fixture, :team_season

		def next_fixture_team_name
			@next_fixture_team_name ||= fixture.opponent_for_team_season(team_season.id)
		end

		def home_or_away_string
			return ' (H)' if fixture.home_team_season_id == team_season.id

			' (A)'
		end
	end
end
