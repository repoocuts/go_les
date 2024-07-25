module Calculators
	module PlayerSeason
		class Cards
			def initialize(player_season)
				@player_season = player_season
			end

			def season_yellows_count
				yellow_cards.count
			end

			def season_home_yellows_count
				yellow_cards.where(is_home: true).count
			end

			def season_away_yellows_count
				yellow_cards.where(is_home: [false, nil]).count
			end

			def season_reds_count
				red_cards.count
			end

			def season_home_reds_count
				red_cards.where(is_home: true).count
			end

			def season_away_reds_count
				red_cards.where(is_home: [false, nil]).count
			end

			def first_half_home_yellow_cards_count
				first_half_yellow_cards.where(is_home: true).count
			end

			def first_half_away_yellow_cards_count
				first_half_yellow_cards.where(is_home: [false, nil]).count
			end

			def second_half_home_yellow_cards_count
				second_half_yellow_cards.where(is_home: true).count
			end

			def second_half_away_yellow_cards_count
				second_half_yellow_cards.where(is_home: [false, nil]).count
			end

			def first_half_home_red_cards_count
				first_half_red_cards.where(is_home: true).count
			end

			def first_half_away_red_cards_count
				first_half_red_cards.where(is_home: [false, nil]).count
			end

			def second_half_home_red_cards_count
				second_half_red_cards.where(is_home: true).count
			end

			def second_half_away_red_cards_count
				second_half_red_cards.where(is_home: [false, nil]).count
			end

			def average_minutes_per_home_yellow_card
				return ::PlayerSeason::ZERO if season_home_yellows_count.zero?

				player_season.total_home_minutes_played / season_home_yellows_count
			end

			def average_minutes_per_away_yellow_card
				return ::PlayerSeason::ZERO if season_away_yellows_count.zero?

				player_season.total_away_minutes_played / season_away_yellows_count
			end

			def average_minutes_per_home_red_card
				return ::PlayerSeason::ZERO if season_home_reds_count.zero?

				player_season.total_home_minutes_played / season_home_reds_count
			end

			def average_minutes_per_away_red_card
				return ::PlayerSeason::ZERO if season_away_reds_count.zero?

				player_season.total_away_minutes_played / season_away_reds_count
			end

			private

			attr_reader :player_season

			def yellow_cards
				player_season.cards.where(card_type: "yellow")
			end

			def first_half_yellow_cards
				yellow_cards.where(minute: 0..45)
			end

			def second_half_yellow_cards
				yellow_cards.where(minute: 46..100)
			end

			def red_cards
				player_season.cards.where(card_type: "red")
			end

			def first_half_red_cards
				red_cards.where(minute: 0..45)
			end

			def second_half_red_cards
				red_cards.where(minute: 46..100)
			end
		end
	end
end
