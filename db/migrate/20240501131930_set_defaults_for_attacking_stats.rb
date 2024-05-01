class SetDefaultsForAttackingStats < ActiveRecord::Migration[7.0]
	def change
		change_column_default :attacking_stats, :scored_total, from: nil, to: 0
		change_column_default :attacking_stats, :scored_home, from: nil, to: 0
		change_column_default :attacking_stats, :scored_away, from: nil, to: 0
		change_column_default :attacking_stats, :scored_first_half, from: nil, to: 0
		change_column_default :attacking_stats, :scored_second_half, from: nil, to: 0
		change_column_default :attacking_stats, :scored_home_first_half, from: nil, to: 0
		change_column_default :attacking_stats, :scored_away_first_half, from: nil, to: 0
		change_column_default :attacking_stats, :scored_home_second_half, from: nil, to: 0
		change_column_default :attacking_stats, :scored_away_second_half, from: nil, to: 0
		change_column_default :attacking_stats, :assists_total, from: nil, to: 0
		change_column_default :attacking_stats, :assists_home, from: nil, to: 0
		change_column_default :attacking_stats, :assists_away, from: nil, to: 0
		change_column_default :attacking_stats, :assists_first_half, from: nil, to: 0
		change_column_default :attacking_stats, :assists_second_half, from: nil, to: 0
		change_column_default :attacking_stats, :assists_home_first_half, from: nil, to: 0
		change_column_default :attacking_stats, :assists_away_first_half, from: nil, to: 0
		change_column_default :attacking_stats, :assists_home_second_half, from: nil, to: 0
		change_column_default :attacking_stats, :assists_away_second_half, from: nil, to: 0
	end
end
