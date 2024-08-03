module TeamSeasons
	class PreviousFixtureDetails

		def initialize(fixture:, team_season:)
			@fixture = fixture
			@team_season = team_season
		end

		def previous_opponent_name
			return nil unless fixture

			previous_fixture_team_name
		end

		def previous_opponent_id
			return fixture.home_team_season_id if team_season == fixture.away_team_season

			fixture.away_team_season_id
		end

		def previous_opponent_object
			return fixture.home_team_object if team_season == fixture.away_team_season

			fixture.away_team_object
		end

		def previous_opponent_string
			return 'N/A' unless fixture

			home_or_away_string + ' ' + previous_fixture_team_name
		end

		def previous_fixture_result_as_string
			return 'N/A' unless fixture

			if fixture.home_team_season_id == team_season.id
				"#{fixture.home_score} - #{fixture.away_score}"
			else
				"#{fixture.home_score} - #{fixture.away_score}"
			end
		end

		private

		attr_reader :fixture, :team_season

		def previous_fixture_team_name
			@previous_fixture_team_name ||= fixture&.opponent_for_team_season(team_season.id)
		end

		def home_or_away_string
			return ' (H)' if fixture&.home_team_season_id == team_season.id

			' (A)'
		end
	end
end
