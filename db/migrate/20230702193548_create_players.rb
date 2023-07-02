class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :full_name
      t.string :short_name
      t.string :position
      t.integer :api_football_id
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
