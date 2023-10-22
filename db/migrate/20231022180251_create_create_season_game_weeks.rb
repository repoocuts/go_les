class CreateCreateSeasonGameWeeks < ActiveRecord::Migration[7.0]
	def change
		create_table :season_game_weeks do |t|
			t.references :season
			t.references :fixture
			t.integer :game_week_number
			t.timestamps
		end
	end
end
