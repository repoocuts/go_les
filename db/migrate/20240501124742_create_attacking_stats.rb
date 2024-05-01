class CreateAttackingStats < ActiveRecord::Migration[7.0]
	def change
		create_table :attacking_stats do |t|
			t.references :player_season, null: false, foreign_key: true
			t.integer :scored_total
			t.integer :scored_home
			t.integer :scored_away
			t.integer :scored_first_half
			t.integer :scored_second_half
			t.integer :scored_home_first_half
			t.integer :scored_away_first_half
			t.integer :scored_home_second_half
			t.integer :scored_away_second_half
			t.integer :assists_total
			t.integer :assists_home
			t.integer :assists_away
			t.integer :assists_first_half
			t.integer :assists_second_half
			t.integer :assists_home_first_half
			t.integer :assists_away_first_half
			t.integer :assists_home_second_half
			t.integer :assists_away_second_half
			t.timestamps
		end
	end
end
