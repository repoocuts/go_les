module Calculators
	module PlayerSeason
		class Assists
			def initialize(player_season)
				@player_season = player_season
			end

			def season_assists_size
				player_season.assists.size
			end

			def home_assists_count
				home_assists.count
			end

			def away_assists_count
				away_assists.count
			end

			def first_half_assists_count
				first_half_assists.count
			end

			def second_half_assists_count
				second_half_assists.count
			end

			def first_half_home_assists_count
				first_half_assists.where(is_home: true).count
			end

			def first_half_away_assists_count
				first_half_assists.where(is_home: nil).count
			end

			def second_half_home_assists_count
				second_half_assists.where(is_home: true).count
			end

			def second_half_away_assists_count
				second_half_assists.where(is_home: nil).count
			end

			def average_minutes_per_assist
				return ::PlayerSeason::ZERO if season_assists_size.zero?

				player_season.total_minutes_played / season_assists_size
			end

			def average_minutes_per_home_assist
				return ::PlayerSeason::ZERO if home_assists_count.zero?

				player_season.total_home_minutes_played / home_assists_count
			end

			def average_minutes_per_away_assist
				return ::PlayerSeason::ZERO if away_assists_count.zero?

				player_season.total_away_minutes_played / away_assists_count
			end

			private

			attr_reader :player_season

			def home_assists
				player_season.assists.where(is_home: true)
			end

			def away_assists
				player_season.assists.where(is_home: nil)
			end

			def first_half_assists
				player_season.assists.where(minute: 0..45)
			end

			def second_half_assists
				player_season.assists.where(minute: 46..100)
			end
		end
	end
end
