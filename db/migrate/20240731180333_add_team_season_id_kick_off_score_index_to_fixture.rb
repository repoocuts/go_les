class AddTeamSeasonIdKickOffScoreIndexToFixture < ActiveRecord::Migration[7.0]
	def change
		add_index :fixtures, [:home_team_season_id, :kick_off, :home_score], unique: true, name: 'index_fixtures_on_home_ts_id_kick_off_home_score'
		add_index :fixtures, [:away_team_season_id, :kick_off, :away_score], unique: true, name: 'index_fixtures_on_away_ts_id_kick_off_away_score'
	end
end
