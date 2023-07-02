class CreateAppearances < ActiveRecord::Migration[7.0]
  def change
    create_table :appearances do |t|
      t.integer :minutes
      t.string :goal_type
      t.boolean :is_home
      t.references :player_season, null: false, foreign_key: true
      t.references :team_season, null: false, foreign_key: true
      t.references :fixture, null: false, foreign_key: true

      t.timestamps
    end
  end
end
