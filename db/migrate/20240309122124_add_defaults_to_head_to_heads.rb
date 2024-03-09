class AddDefaultsToHeadToHeads < ActiveRecord::Migration[7.0]
  def change
    change_column :head_to_heads, :bookings_received, :integer, default: 0
    change_column :head_to_heads, :conceded_against_opponent, :integer, default: 0
    change_column :head_to_heads, :conceded_away, :integer, default: 0
    change_column :head_to_heads, :conceded_home, :integer, default: 0
    change_column :head_to_heads, :fixtures_played, :integer, default: 0
    change_column :head_to_heads, :opponent_bookings, :integer, default: 0
    change_column :head_to_heads, :opponent_id, :integer, default: 0
    change_column :head_to_heads, :opponent_reds, :integer, default: 0
    change_column :head_to_heads, :reds_received, :integer, default: 0
    change_column :head_to_heads, :scored_against_opponent, :integer, default: 0
    change_column :head_to_heads, :scored_away, :integer, default: 0
    change_column :head_to_heads, :scored_home, :integer, default: 0
  end
end
