namespace :update_card_stat_objects do
	desc "Update YelowCard and RedCard stats"
	task update_card_stats: :environment do
		TeamSeason.all.each do |team_season|
			yellow_cards_stat = team_season.yellow_cards_stat || team_season.build_yellow_cards_stat
			red_cards_stat = team_season.red_cards_stat || team_season.build_red_cards_stat

			yellow_cards = team_season.yellow_cards
			home_yellow_cards = yellow_cards.where(is_home: true)
			away_yellow_cards = yellow_cards.where(is_home: nil)
			first_half_yellow_cards = yellow_cards.where(minute: 0..45)
			second_half_yellow_cards = yellow_cards.where(minute: 46..100)
			home_first_half_yellow_cards = first_half_yellow_cards.where(is_home: true)
			away_first_half_yellow_cards = first_half_yellow_cards.where(is_home: nil)
			home_second_half_yellow_cards = second_half_yellow_cards.where(is_home: true)
			away_second_half_yellow_cards = second_half_yellow_cards.where(is_home: nil)

			if yellow_cards_stat.total != yellow_cards.count
				yellow_cards_stat.update!(
					total: yellow_cards.count,
					home: home_yellow_cards.count,
					away: away_yellow_cards.count,
					first_half: first_half_yellow_cards.count,
					second_half: second_half_yellow_cards.count,
					home_first_half: home_first_half_yellow_cards.count,
					away_first_half: away_first_half_yellow_cards.count,
					home_second_half: home_second_half_yellow_cards.count,
					away_second_half: away_second_half_yellow_cards.count,
				)
			end

			red_cards = team_season.red_cards
			home_red_cards = red_cards.where(is_home: true)
			away_red_cards = red_cards.where(is_home: nil)
			first_half_red_cards = red_cards.where(minute: 0..45)
			second_half_red_cards = red_cards.where(minute: 46..100)
			home_first_half_red_cards = first_half_red_cards.where(is_home: true)
			away_first_half_red_cards = first_half_red_cards.where(is_home: nil)
			home_second_half_red_cards = second_half_red_cards.where(is_home: true)
			away_second_half_red_cards = second_half_red_cards.where(is_home: nil)

			if red_cards_stat.total != red_cards.count
				red_cards_stat.update!(
					total: red_cards.count,
					home: home_red_cards.count,
					away: away_red_cards.count,
					first_half: first_half_red_cards.count,
					second_half: second_half_red_cards.count,
					home_first_half: home_first_half_red_cards.count,
					away_first_half: away_first_half_red_cards.count,
					home_second_half: home_second_half_red_cards.count,
					away_second_half: away_second_half_red_cards.count,
				)
			end
		end
	end
end
