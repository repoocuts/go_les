class CreateLeagues < ActiveRecord::Migration[7.0]
  def change
    create_table :leagues do |t|
      t.string :name
      t.integer :api_football_id
      t.references :country, null: false, foreign_key: true

      t.timestamps
    end
  end
end
