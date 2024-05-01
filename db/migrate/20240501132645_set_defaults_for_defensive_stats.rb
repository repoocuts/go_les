class SetDefaultsForDefensiveStats < ActiveRecord::Migration[7.0]
	def change
		change_column_default :defensive_stats, :conceded_total, from: nil, to: 0
		change_column_default :defensive_stats, :conceded_home, from: nil, to: 0
		change_column_default :defensive_stats, :conceded_away, from: nil, to: 0
		change_column_default :defensive_stats, :conceded_first_half, from: nil, to: 0
		change_column_default :defensive_stats, :conceded_second_half, from: nil, to: 0
		change_column_default :defensive_stats, :conceded_home_first_half, from: nil, to: 0
		change_column_default :defensive_stats, :conceded_away_first_half, from: nil, to: 0
		change_column_default :defensive_stats, :conceded_home_second_half, from: nil, to: 0
		change_column_default :defensive_stats, :conceded_away_second_half, from: nil, to: 0
		change_column_default :defensive_stats, :clean_sheet_total, from: nil, to: 0
		change_column_default :defensive_stats, :clean_sheet_home, from: nil, to: 0
		change_column_default :defensive_stats, :clean_sheet_away, from: nil, to: 0
		change_column_default :defensive_stats, :clean_sheet_first_half, from: nil, to: 0
		change_column_default :defensive_stats, :clean_sheet_second_half, from: nil, to: 0
		change_column_default :defensive_stats, :clean_sheet_home_first_half, from: nil, to: 0
		change_column_default :defensive_stats, :clean_sheet_away_first_half, from: nil, to: 0
		change_column_default :defensive_stats, :clean_sheet_home_second_half, from: nil, to: 0
		change_column_default :defensive_stats, :clean_sheet_away_second_half, from: nil, to: 0
	end
end
