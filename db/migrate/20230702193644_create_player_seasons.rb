class CreatePlayerSeasons < ActiveRecord::Migration[7.0]
  def change
    create_table :player_seasons do |t|
      t.integer :api_football_id
      t.references :team_season, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
