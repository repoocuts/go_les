class AddTeamSeasonKickOffScoreIndexToFixtures < ActiveRecord::Migration[7.0]
	def change
		add_index :fixtures, [:home_team_season_id, :away_team_season_id, :kick_off, :home_score], name: 'index_fixtures_on_team_seasons_and_kick_off_and_score'
	end
end
