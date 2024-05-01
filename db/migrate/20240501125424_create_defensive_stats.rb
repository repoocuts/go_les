class CreateDefensiveStats < ActiveRecord::Migration[7.0]
	def change
		create_table :defensive_stats do |t|
			t.references :player_season, null: false, foreign_key: true
			t.integer :conceded_total
			t.integer :conceded_home
			t.integer :conceded_away
			t.integer :conceded_first_half
			t.integer :conceded_second_half
			t.integer :conceded_home_first_half
			t.integer :conceded_away_first_half
			t.integer :conceded_home_second_half
			t.integer :conceded_away_second_half
			t.integer :clean_sheet_total
			t.integer :clean_sheet_home
			t.integer :clean_sheet_away
			t.integer :clean_sheet_first_half
			t.integer :clean_sheet_second_half
			t.integer :clean_sheet_home_first_half
			t.integer :clean_sheet_away_first_half
			t.integer :clean_sheet_home_second_half
			t.integer :clean_sheet_away_second_half
		end
	end
end
