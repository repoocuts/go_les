module Calculators
	module Team
		class RedCards

			def initialize(red_cards_stat:, completed_fixtures_count:, home_fixtures_count:, away_fixtures_count:)
				@red_cards_stat = red_cards_stat
				@completed_fixtures_count = completed_fixtures_count
				@home_fixtures_count = home_fixtures_count
				@away_fixtures_count = away_fixtures_count
			end

			def average_first_half_red_cards
				(red_cards_stat.first_half / completed_fixtures_count.to_f).round(2)
			end

			def average_second_half_red_cards
				(red_cards_stat.second_half / completed_fixtures_count.to_f).round(2)
			end

			def average_red_cards_per_match
				(red_cards_stat.total.to_f / completed_fixtures_count.to_f).round(2)
			end

			def average_red_cards_conceded_per_match
				(red_cards_conceded_stat.total.to_f / completed_fixtures_count).round(2)
			end

			def average_home_red_cards
				(red_cards_stat.home.to_f / home_fixtures_count).round(2)
			end

			def average_away_red_cards
				(red_cards_stat.away.to_f / away_fixtures_count).round(2)
			end

			def average_home_red_cards_conceded
				(red_cards_conceded_stat.home.to_f / home_fixtures_count).round(2)
			end

			def average_away_red_cards_conceded
				(red_cards_conceded_stat.away.to_f / away_fixtures_count).round(2)
			end

			def average_home_red_cards_first_half
				(red_cards_stat.home_first_half.to_f / home_fixtures_count).round(2)
			end

			def average_away_red_cards_first_half
				(red_cards_stat.away_first_half.to_f / away_fixtures_count).round(2)
			end

			def average_home_red_cards_second_half
				(red_cards_stat.home_second_half.to_f / home_fixtures_count).round(2)
			end

			def average_away_red_cards_second_half
				(red_cards_stat.away_second_half.to_f / away_fixtures_count).round(2)
			end

			def average_home_red_cards_conceded_first_half
				(red_cards_conceded_stat.home_first_half.to_f / home_fixtures_count).round(2)
			end

			def average_away_red_cards_conceded_first_half
				(red_cards_conceded_stat.away_first_half.to_f / away_fixtures_count).round(2)
			end

			def average_home_red_cards_conceded_second_half
				(red_cards_conceded_stat.home_second_half.to_f / home_fixtures_count).round(2)
			end

			def average_away_red_cards_conceded_second_half
				(red_cards_conceded_stat.away_second_half.to_f / away_fixtures_count).round(2)
			end

			def average_red_cards
				(red_cards_stat.total.to_f / completed_fixtures_count.to_f).round(2)
			end

			def average_red_cards_conceded
				(red_cards_conceded_stat.total.to_f / completed_fixtures_count).round(2)
			end

			def average_red_cards_home
				(red_cards_stat.home.to_f / home_fixtures_count).round(2)
			end

			def average_red_cards_away
				(red_cards_stat.away.to_f / away_fixtures_count).round(2)
			end

			def average_red_cards_conceded_home
				(red_cards_conceded_stat.home.to_f / home_fixtures_count).round(2)
			end

			def average_red_cards_conceded_away
				(red_cards_conceded_stat.away.to_f / away_fixtures_count).round(2)
			end

			def average_red_cards_first_half
				(red_cards_stat.first_half.to_f / completed_fixtures_count).round(2)
			end

			def average_red_cards_second_half
				(red_cards_stat.second_half.to_f / completed_fixtures_count).round(2)
			end

			def average_red_cards_conceded_first_half
				(red_cards_conceded_stat.first_half.to_f / completed_fixtures_count).round(2)
			end

			def average_red_cards_conceded_second_half
				(red_cards_conceded_stat.second_half.to_f / completed_fixtures_count).round(2)
			end

			def average_red_cards_home_first_half
				(red_cards_stat.home_first_half.to_f / home_fixtures_count).round(2)
			end

			def average_red_cards_away_first_half
				(red_cards_stat.away_first_half.to_f / away_fixtures_count).round(2)
			end

			def average_red_cards_home_second_half
				(red_cards_stat.home_second_half.to_f / home_fixtures_count).round(2)
			end

			def average_red_cards_away_second_half
				(red_cards_stat.away_second_half.to_f / away_fixtures_count).round(2)
			end

			def average_red_cards_conceded_home_first_half
				(red_cards_conceded_stat.home_first_half.to_f / home_fixtures_count).round(2)
			end

			def average_red_cards_conceded_away_first_half
				(red_cards_conceded_stat.away_first_half.to_f / away_fixtures_count).round(2)
			end

			def average_red_cards_conceded_home_second_half
				(red_cards_conceded_stat.home_second_half.to_f / home_fixtures_count).round(2)
			end

			def average_red_cards_conceded_away_second_half
				(red_cards_conceded_stat.away_second_half.to_f / away_fixtures_count).round(2)
			end

			private

			attr_reader :red_cards_stat, :completed_fixtures_count, :home_fixtures_count, :away_fixtures_count
		end
	end
end
