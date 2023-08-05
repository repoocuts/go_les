class AddPointsToTeamSeasons < ActiveRecord::Migration[7.0]
  def change
    add_column :team_seasons, :points, :integer
  end
end
