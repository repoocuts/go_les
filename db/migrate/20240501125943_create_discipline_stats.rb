class CreateDisciplineStats < ActiveRecord::Migration[7.0]
	def change
		create_table :discipline_stats do |t|
			t.references :player_season, null: false, foreign_key: true
			t.integer :yellow_card_total
			t.integer :yellow_card_home
			t.integer :yellow_card_away
			t.integer :yellow_card_first_half
			t.integer :yellow_card_second_half
			t.integer :yellow_card_home_first_half
			t.integer :yellow_card_away_first_half
			t.integer :yellow_card_home_second_half
			t.integer :yellow_card_away_second_half
			t.integer :red_card_total
			t.integer :red_card_home
			t.integer :red_card_away
			t.integer :red_card_first_half
			t.integer :red_card_second_half
			t.integer :red_card_home_first_half
			t.integer :red_card_away_first_half
			t.integer :red_card_home_second_half
			t.integer :red_card_away_second_half
		end
	end
end
