class CreateFixtures < ActiveRecord::Migration[7.0]
  def change
    create_table :fixtures do |t|
      t.integer :home_team_season_id
      t.integer :away_team_season_id
      t.integer :home_score
      t.integer :away_score
      t.datetime :kick_off
      t.integer :game_week
      t.integer :api_football_id
      t.references :season, null: false, foreign_key: true
      t.references :league, null: false, foreign_key: true

      t.timestamps
    end
  end
end
