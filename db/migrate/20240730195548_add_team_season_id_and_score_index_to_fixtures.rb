class AddTeamSeasonIdAndScoreIndexToFixtures < ActiveRecord::Migration[7.0]
	def change
		add_index :fixtures, [:home_team_season_id, :home_score]
		add_index :fixtures, [:away_team_season_id, :away_score]
	end
end
