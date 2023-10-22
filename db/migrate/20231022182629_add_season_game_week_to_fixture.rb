class AddSeasonGameWeekToFixture < ActiveRecord::Migration[7.0]
	def change
		add_reference :fixtures, :season_game_week, foreign_key: true
	end
end
