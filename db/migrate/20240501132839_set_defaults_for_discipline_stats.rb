class SetDefaultsForDisciplineStats < ActiveRecord::Migration[7.0]
	def change
		change_column_default :discipline_stats, :yellow_card_total, from: nil, to: 0
		change_column_default :discipline_stats, :yellow_card_home, from: nil, to: 0
		change_column_default :discipline_stats, :yellow_card_away, from: nil, to: 0
		change_column_default :discipline_stats, :yellow_card_first_half, from: nil, to: 0
		change_column_default :discipline_stats, :yellow_card_second_half, from: nil, to: 0
		change_column_default :discipline_stats, :yellow_card_home_first_half, from: nil, to: 0
		change_column_default :discipline_stats, :yellow_card_away_first_half, from: nil, to: 0
		change_column_default :discipline_stats, :yellow_card_home_second_half, from: nil, to: 0
		change_column_default :discipline_stats, :yellow_card_away_second_half, from: nil, to: 0
		change_column_default :discipline_stats, :red_card_total, from: nil, to: 0
		change_column_default :discipline_stats, :red_card_home, from: nil, to: 0
		change_column_default :discipline_stats, :red_card_away, from: nil, to: 0
		change_column_default :discipline_stats, :red_card_first_half, from: nil, to: 0
		change_column_default :discipline_stats, :red_card_second_half, from: nil, to: 0
		change_column_default :discipline_stats, :red_card_home_first_half, from: nil, to: 0
		change_column_default :discipline_stats, :red_card_away_first_half, from: nil, to: 0
		change_column_default :discipline_stats, :red_card_home_second_half, from: nil, to: 0
		change_column_default :discipline_stats, :red_card_away_second_half, from: nil, to: 0
	end
end
