class AddIndexOnScoresKickOffAndGameWeekForFixtures < ActiveRecord::Migration[7.0]
	def change
		add_index :fixtures, :kick_off
		add_index :fixtures, :game_week
		add_index :fixtures, :home_score
		add_index :fixtures, :away_score
	end
end
