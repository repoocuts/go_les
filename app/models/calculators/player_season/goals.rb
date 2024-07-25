module Calculators
	module PlayerSeason
		class Goals
			def initialize(player_season)
				@player_season = player_season
			end

			def season_goals_size
				player_season.goals.size
			end

			def home_goals_count
				home_goals.count
			end

			def away_goals_count
				away_goals.count
			end

			def first_half_goals_count
				first_half_goals.count
			end

			def second_half_goals_count
				second_half_goals.count
			end

			def first_half_home_goals_count
				first_half_goals.where(is_home: true).count
			end

			def first_half_away_goals_count
				first_half_goals.where(is_home: nil).count
			end

			def second_half_home_goals_count
				second_half_goals.where(is_home: true).count
			end

			def second_half_away_goals_count
				second_half_goals.where(is_home: nil).count
			end

			def average_minutes_per_goal
				return ::PlayerSeason::ZERO if season_goals_size.zero?

				player_season.total_minutes_played / season_goals_size
			end

			def average_minutes_per_home_goal
				return ::PlayerSeason::ZERO if season_goals_size.zero?

				player_season.total_home_minutes_played / home_goals_count
			end

			def average_minutes_per_away_goal
				return ::PlayerSeason::ZERO if season_goals_size.zero?

				player_season.total_away_minutes_played / away_goals_count
			end

			private

			attr_reader :player_season

			def home_goals
				player_season.goals.where(is_home: true)
			end

			def away_goals
				player_season.goals.where(is_home: [false, nil])
			end

			def first_half_goals
				player_season.goals.where(minute: 0..45)
			end

			def second_half_goals
				player_season.goals.where(minute: 46..100)
			end
		end
	end
end
