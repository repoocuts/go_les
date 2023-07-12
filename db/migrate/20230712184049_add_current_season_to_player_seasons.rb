class AddCurrentSeasonToPlayerSeasons < ActiveRecord::Migration[7.0]
  def change
    add_column :player_seasons, :current_season, :boolean
  end
end
