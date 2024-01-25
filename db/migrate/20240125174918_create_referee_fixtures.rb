class CreateRefereeFixtures < ActiveRecord::Migration[7.0]
  def change
    create_table :referee_fixtures do |t|
      t.references :fixture, null: false, foreign_key: true
      t.references :referee, null: false, foreign_key: true
      t.references :season, null: false, foreign_key: true

      t.timestamps
    end
  end
end
