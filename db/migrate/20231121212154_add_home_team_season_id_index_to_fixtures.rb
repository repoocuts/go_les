class AddHomeTeamSeasonIdIndexToFixtures < ActiveRecord::Migration[7.0]
  def change
    add_index :fixtures, :home_team_season_id
    add_index :fixtures, :away_team_season_id
  end
end
