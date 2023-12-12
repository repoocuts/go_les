module Calculators
	module TeamGoals
		class TotalGoalsCalculator

			def initialize(goals: [], total_goals_count:, completed_fixtures: [], completed_fixtures_count:,
			               team_season_id:)
				@goals = goals
				@total_goals_count = total_goals_count
				@completed_fixtures = completed_fixtures
				@completed_fixtures_count = completed_fixtures_count
				@team_season_id = team_season_id
			end

			def first_half_goals
				goals.where(minute: 0..45)
			end

			def first_half_goals_total
				first_half_goals.size
			end

			def second_half_goals
				goals.where(minute: 46..100)
			end

			def second_half_goals_total
				second_half_goals.size
			end

			def goals_against
				ids = completed_fixtures.pluck(:id)

				goals = Goal.where(fixture_id: ids)
				goals.where.not(team_season_id: team_season_id)
			end

			def goals_against_number
				goals_against.size
			end

			def first_half_goals_against
				goals_against.where(minute: 0..45)
			end

			def first_half_goals_against_total
				first_half_goals_against.size
			end

			def second_half_goals_against
				goals_against.where(minute: 46..100)
			end

			def second_half_goals_against_total
				goals_against.size
			end

			def average_first_half_goals
				(first_half_goals_total / completed_fixtures_count.to_f).round(2)
			end

			def average_second_half_goals
				(second_half_goals_total / completed_fixtures_count.to_f).round(2)
			end

			def average_goals_scored_per_match
				(total_goals_count.to_f / completed_fixtures_count.to_f).round(2)
			end

			def average_goals_conceded_per_match
				(goals_against.size.to_f / completed_fixtures_count).round(2)
			end

			def average_goals_scored_first_half
				(total_goals_count.to_f / completed_fixtures_count).round(2)
			end

			def average_goals_scored_second_half
				(total_goals_count.to_f / completed_fixtures_count).round(2)
			end

			def first_half_goals_conceded_count
				goals_against.where('minute < ?', 46).size
			end

			def second_half_goals_conceded_count
				goals_against.where('minute > ?', 45).size
			end

			private

			attr_reader :goals, :total_goals_count, :completed_fixtures, :completed_fixtures_count,
			            :team_season_id
		end
	end
end
