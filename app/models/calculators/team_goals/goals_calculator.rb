module Calculators
	module TeamGoals
		class GoalsCalculator

			def initialize(goals_scored_stat:, goals_conceded_stat:, completed_fixtures_count:, home_fixtures_count:, away_fixtures_count:)
				@goals_scored_stat = goals_scored_stat
				@goals_conceded_stat = goals_conceded_stat
				@completed_fixtures_count = completed_fixtures_count
				@home_fixtures_count = home_fixtures_count
				@away_fixtures_count = away_fixtures_count
			end

			def goal_difference
				gd = goals_scored_stat.total - goals_conceded_stat.total
				return 0 if gd.zero?

				gd
			end

			def average_first_half_goals
				(goals_scored_stat.first_half / completed_fixtures_count.to_f).round(2)
			end

			def average_second_half_goals
				(goals_scored_stat.second_half / completed_fixtures_count.to_f).round(2)
			end

			def average_goals_scored_per_match
				return 0 if completed_fixtures_count.zero?

				(goals_scored_stat.total.to_f / completed_fixtures_count.to_f).round(2)
			end

			def average_goals_conceded_per_match
				return 0 if completed_fixtures_count.zero?

				(goals_conceded_stat.total.to_f / completed_fixtures_count).round(2)
			end

			def average_home_goals_scored
				(goals_scored_stat.home.to_f / home_fixtures_count).round(2)
			end

			def average_away_goals_scored
				(goals_scored_stat.away.to_f / away_fixtures_count).round(2)
			end

			def average_home_goals_conceded
				(goals_conceded_stat.home.to_f / home_fixtures_count).round(2)
			end

			def average_away_goals_conceded
				(goals_conceded_stat.away.to_f / away_fixtures_count).round(2)
			end

			def average_home_goals_scored_first_half
				(goals_scored_stat.home_first_half.to_f / home_fixtures_count).round(2)
			end

			def average_away_goals_scored_first_half
				(goals_scored_stat.away_first_half.to_f / away_fixtures_count).round(2)
			end

			def average_home_goals_scored_second_half
				(goals_scored_stat.home_second_half.to_f / home_fixtures_count).round(2)
			end

			def average_away_goals_scored_second_half
				(goals_scored_stat.away_second_half.to_f / away_fixtures_count).round(2)
			end

			def average_home_goals_conceded_first_half
				(goals_conceded_stat.home_first_half.to_f / home_fixtures_count).round(2)
			end

			def average_away_goals_conceded_first_half
				(goals_conceded_stat.away_first_half.to_f / away_fixtures_count).round(2)
			end

			def average_home_goals_conceded_second_half
				(goals_conceded_stat.home_second_half.to_f / home_fixtures_count).round(2)
			end

			def average_away_goals_conceded_second_half
				(goals_conceded_stat.away_second_half.to_f / away_fixtures_count).round(2)
			end

			def average_goals_scored
				(goals_scored_stat.total.to_f / completed_fixtures_count.to_f).round(2)
			end

			def average_goals_conceded
				(goals_conceded_stat.total.to_f / completed_fixtures_count).round(2)
			end

			def average_goals_scored_home
				(goals_scored_stat.home.to_f / home_fixtures_count).round(2)
			end

			def average_goals_scored_away
				(goals_scored_stat.away.to_f / away_fixtures_count).round(2)
			end

			def average_goals_conceded_home
				(goals_conceded_stat.home.to_f / home_fixtures_count).round(2)
			end

			def average_goals_conceded_away
				(goals_conceded_stat.away.to_f / away_fixtures_count).round(2)
			end

			def average_goals_scored_first_half
				return 0 if completed_fixtures_count.zero?

				(goals_scored_stat.first_half.to_f / completed_fixtures_count).round(2)
			end

			def average_goals_scored_second_half
				return 0 if completed_fixtures_count.zero?

				(goals_scored_stat.second_half.to_f / completed_fixtures_count).round(2)
			end

			def average_goals_conceded_first_half
				return 0 if completed_fixtures_count.zero?

				(goals_conceded_stat.first_half.to_f / completed_fixtures_count).round(2)
			end

			def average_goals_conceded_second_half
				return 0 if completed_fixtures_count.zero?

				(goals_conceded_stat.second_half.to_f / completed_fixtures_count).round(2)
			end

			def average_goals_scored_home_first_half
				return 0 if home_fixtures_count.zero?

				(goals_scored_stat.home_first_half.to_f / home_fixtures_count).round(2)
			end

			def average_goals_scored_away_first_half
				return 0 if away_fixtures_count.zero?

				(goals_scored_stat.away_first_half.to_f / away_fixtures_count).round(2)
			end

			def average_goals_scored_home_second_half
				return 0 if home_fixtures_count.zero?

				(goals_scored_stat.home_second_half.to_f / home_fixtures_count).round(2)
			end

			def average_goals_scored_away_second_half
				return 0 if away_fixtures_count.zero?

				(goals_scored_stat.away_second_half.to_f / away_fixtures_count).round(2)
			end

			def average_goals_conceded_home_first_half
				return 0 if home_fixtures_count.zero?

				(goals_conceded_stat.home_first_half.to_f / home_fixtures_count).round(2)
			end

			def average_goals_conceded_away_first_half
				return 0 if away_fixtures_count.zero?

				(goals_conceded_stat.away_first_half.to_f / away_fixtures_count).round(2)
			end

			def average_goals_conceded_home_second_half
				return 0 if home_fixtures_count.zero?

				(goals_conceded_stat.home_second_half.to_f / home_fixtures_count).round(2)
			end

			def average_goals_conceded_away_second_half
				return 0 if away_fixtures_count.zero?

				(goals_conceded_stat.away_second_half.to_f / away_fixtures_count).round(2)
			end

			private

			attr_reader :goals_scored_stat, :goals_conceded_stat, :completed_fixtures_count, :home_fixtures_count, :away_fixtures_count
		end
	end
end
