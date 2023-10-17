class CreateAssists < ActiveRecord::Migration[7.0]
  def change
    create_table :assists do |t|
      t.references :player_season, null: false, foreign_key: true
      t.references :goal, null: false, foreign_key: true
      t.references :team_season, null: false, foreign_key: true
      t.references :fixture, null: false, foreign_key: true
      t.references :appearances, null: false, foreign_key: true
      t.boolean :is_home
      t.integer :minute

      t.timestamps
    end
  end
end
