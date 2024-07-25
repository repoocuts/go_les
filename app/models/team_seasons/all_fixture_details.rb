module TeamSeasons
	class AllFixtureDetails

		def initialize(team_season:, fixtures:)
			@team_season = team_season
			@fixtures = fixtures
		end

		def completed_fixtures
			finished_fixtures
		end

		def completed_fixtures_size
			finished_fixtures.size
		end

		def remaining_fixtures
			fixtures - finished_fixtures
		end

		def last_five_fixtures
			finished_fixtures.last(5)
		end

		def last_five_results_hash
			last_five_fixtures.map do |match|
				results_formatter(match)
			end
		end

		private

		attr_reader :team_season, :fixtures

		def finished_fixtures
			@finished_fixtures ||= fixtures.where('kick_off < ? AND home_score IS NOT NULL', Date.today)
		end

		def home_or_away_string
			return ' (H)' if fixture&.home_team_season_id == team_season.id

			' (A)'
		end

		def results_formatter(match, hash: {})
			outcome = if match.home_score.nil?
				          '-'
				        elsif match.home_team_season_id == team_season.id
					        if match.home_score > match.away_score
						        'W'
					        elsif match.home_score == match.away_score
						        'D'
					        else
						        'L'
					        end
				        else
					        if match.away_score > match.home_score
						        'W'
					        elsif match.home_score == match.away_score
						        'D'
					        else
						        'L'
					        end
			          end

			hash[match.game_week] = outcome
			hash
		end
	end
end
