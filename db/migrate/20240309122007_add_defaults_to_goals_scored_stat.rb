class AddDefaultsToGoalsScoredStat < ActiveRecord::Migration[7.0]
  def change
    change_column :goals_scored_stats, :total, :integer, default: 0
    change_column :goals_scored_stats, :home, :integer, default: 0
    change_column :goals_scored_stats, :away, :integer, default: 0
    change_column :goals_scored_stats, :first_half, :integer, default: 0
    change_column :goals_scored_stats, :second_half, :integer, default: 0
    change_column :goals_scored_stats, :home_first_half, :integer, default: 0
    change_column :goals_scored_stats, :away_first_half, :integer, default: 0
    change_column :goals_scored_stats, :home_second_half, :integer, default: 0
    change_column :goals_scored_stats, :away_second_half, :integer, default: 0
  end
end
