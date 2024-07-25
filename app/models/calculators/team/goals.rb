module Calculators
	module Team
		class Goals

			def initialize(team_season:)
				@goals_scored_stat = team_season.goals_scored_stat
				@goals_conceded_stat = team_season.goals_conceded_stat
				@completed_fixtures_count = team_season.completed_fixtures_count
				@home_fixtures_count = team_season.played_home_matches_count
				@away_fixtures_count = team_season.played_away_matches_count
			end

			def goal_difference
				goals_scored_stat.total - goals_conceded_stat.total
			end

			def average_goals(type: :scored, half: nil, location: nil)
				stat = send("#{type}_stat", half, location)
				count = fixture_count(location)

				return 0 if count.zero?

				(stat.to_f / count).round(2)
			end

			private

			attr_reader :goals_scored_stat, :goals_conceded_stat, :completed_fixtures_count, :home_fixtures_count, :away_fixtures_count

			def scored_stat(half, location)
				stat = goals_scored_stat
				stat = stat.public_send("#{location}_#{half}") if half && location
				stat = stat.public_send(location) if location && !half
				stat = stat.public_send(half) if half && !location
				stat.total unless half || location
			end

			def conceded_stat(half, location)
				stat = goals_conceded_stat
				stat = stat.public_send("#{location}_#{half}") if half && location
				stat = stat.public_send(location) if location && !half
				stat = stat.public_send(half) if half && !location
				stat.total unless half || location
			end

			def fixture_count(location)
				return home_fixtures_count if location == :home
				return away_fixtures_count if location == :away

				completed_fixtures_count
			end
		end
	end
end
