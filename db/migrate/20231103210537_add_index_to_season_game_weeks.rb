class AddIndexToSeasonGameWeeks < ActiveRecord::Migration[7.0]
	def change
		add_index :season_game_weeks, :game_week_number
	end
end
