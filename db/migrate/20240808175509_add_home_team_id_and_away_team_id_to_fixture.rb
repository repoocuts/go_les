class AddHomeTeamIdAndAwayTeamIdToFixture < ActiveRecord::Migration[7.0]
	def change
		add_column :fixtures, :home_team_id, :integer
		add_column :fixtures, :away_team_id, :integer
	end
end
