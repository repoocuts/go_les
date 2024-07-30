class AddKickOffAndHomeScoreIndexToFixtures < ActiveRecord::Migration[7.0]
	def change
		add_index :fixtures, %i[kick_off home_score]
	end
end
