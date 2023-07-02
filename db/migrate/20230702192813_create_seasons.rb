class CreateSeasons < ActiveRecord::Migration[7.0]
  def change
    create_table :seasons do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :api_football_id
      t.boolean :current_season
      t.integer :current_game_week
      t.references :league, null: false, foreign_key: true

      t.timestamps
    end
  end
end
