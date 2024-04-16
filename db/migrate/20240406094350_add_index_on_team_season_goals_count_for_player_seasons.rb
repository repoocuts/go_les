class AddIndexOnTeamSeasonGoalsCountForPlayerSeasons < ActiveRecord::Migration[7.0]
	def change
		add_index :player_seasons, [:team_season_id, :goals_count]
	end
end
