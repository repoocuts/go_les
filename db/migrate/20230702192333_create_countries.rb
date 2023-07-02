class CreateCountries < ActiveRecord::Migration[7.0]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :code
      t.integer :api_football_id

      t.timestamps
    end
  end
end
