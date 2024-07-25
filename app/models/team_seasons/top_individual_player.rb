module TeamSeasons
	class TopIndividualPlayer

		def initialize(team_season:)
			@team_season = team_season
			@player_seasons = team_season.player_seasons
		end

		def top_scoring_player_season
			player_seasons.order(:goals_count).reverse.first
		end

		def top_assists_player_season
			player_seasons.order(:assists_count).reverse.first
		end

		def most_booked_player_season
			player_seasons
			.booked_players
			.select('player_seasons.*, COUNT(cards.id) as cards_count')
			.group('player_seasons.id')
			.order('cards_count DESC')
			.first || player_seasons.first
		end

		def most_reds_player_season
			player_seasons
			.sent_off_players
			.select('player_seasons.*, COUNT(cards.id) as cards_count')
			.group('player_seasons.id')
			.order('cards_count DESC')
			.first || player_seasons.first
		end

		def previous_fixture_result_as_string
			return 'N/A' unless fixture

			if fixture.home_team_season_id == id
				"#{fixture.home_score} - #{fixture.away_score}"
			else
				"#{fixture.home_score} - #{fixture.away_score}"
			end
		end

		private

		attr_reader :player_seasons, :team_season

		def previous_fixture_team_name
			@previous_fixture_team_name ||= fixture&.opponent_for_team_season(team_season.id)
		end

		def home_or_away_string
			return ' (H)' if fixture&.home_team_season_id == team_season.id

			' (A)'
		end
	end
end
