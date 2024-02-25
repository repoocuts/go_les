class CreateHeadToHeads < ActiveRecord::Migration[7.0]
  def change
    create_table :head_to_heads do |t|
      t.integer :bookings_received
      t.integer :conceded_against_opponent
      t.integer :conceded_away
      t.integer :conceded_home
      t.integer :current_season_fixture_ids, array: true, default: []
      t.integer :current_team_season_id
      t.integer :fixture_ids, array: true, default: []
      t.integer :fixtures_played
      t.integer :opponent_bookings
      t.integer :opponent_id
      t.integer :opponent_reds
      t.integer :opponent_top_assist_player_season_id
      t.integer :opponent_top_scorer_player_season_id
      t.integer :reds_received
      t.integer :scored_against_opponent
      t.integer :scored_away
      t.integer :scored_home
      t.integer :top_assist_player_season_id
      t.integer :top_scorer_player_season_id
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
