class AddCardCountsToTeamSeasons < ActiveRecord::Migration[7.0]
  def change
    add_column :team_seasons, :yellow_cards_count, :integer, default: 0, null: false
    add_column :team_seasons, :red_cards_count, :integer, default: 0, null: false
  end
end
