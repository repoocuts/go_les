class CreateObjectHandlingFailure < ActiveRecord::Migration[7.0]
  def change
    create_table :object_handling_failures do |t|
      t.string :object_type
      t.jsonb :api_response_element
      t.jsonb :other_attributes
      t.integer :related_country_id
      t.integer :related_league_id
      t.integer :related_season_id
      t.integer :related_fixture_id
      t.integer :related_team_id
      t.integer :related_team_season_id
      t.integer :related_player_id
      t.integer :related_player_season_id
      t.integer :related_appearance_id
      t.timestamps
    end
  end
end
