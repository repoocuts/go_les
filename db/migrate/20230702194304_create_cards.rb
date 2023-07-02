class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.integer :minute
      t.string :card_type
      t.boolean :is_home
      t.integer :first_card_id
      t.references :appearance, null: false, foreign_key: true
      t.references :player_season, null: false, foreign_key: true
      t.references :team_season, null: false, foreign_key: true
      t.references :fixture, null: false, foreign_key: true

      t.timestamps
    end
  end
end
