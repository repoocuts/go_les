module Calculators
	module PlayerSeason
		class Appearances
			def initialize(player_season)
				@player_season = player_season
			end

			def total_minutes_played
				player_season.appearances.sum(:minutes)
			end

			def total_home_minutes_played
				home_appearances.sum(:minutes)
			end

			def total_away_minutes_played
				away_appearances.sum(:minutes)
			end

			def sub_appearances
				player_season.appearances.where(appearance_type: 'substitute')
			end

			def starts
				player_season.appearances.where(appearance_type: 'start')
			end

			private

			attr_reader :player_season

			def home_appearances
				player_season.appearances.where(is_home: true)
			end

			def away_appearances
				player_season.appearances.where(is_home: nil)
			end
		end
	end
end
