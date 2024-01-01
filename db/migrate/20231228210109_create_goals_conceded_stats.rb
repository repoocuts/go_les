class CreateGoalsConcededStats < ActiveRecord::Migration[7.0]
  def change
    create_table :goals_conceded_stats do |t|
      t.references :team_season, null: false, foreign_key: true
      t.integer :total
      t.integer :home
      t.integer :away
      t.integer :first_half
      t.integer :second_half
      t.integer :home_first_half
      t.integer :away_first_half
      t.integer :home_second_half
      t.integer :away_second_half
      t.timestamps
    end
  end
end
