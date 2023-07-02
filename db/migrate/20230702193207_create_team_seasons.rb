class CreateTeamSeasons < ActiveRecord::Migration[7.0]
  def change
    create_table :team_seasons do |t|
      t.integer :api_football_id
      t.references :season, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
