class AddCountersToPlayerSeason < ActiveRecord::Migration[7.0]
	def change
		add_column :player_seasons, :assists_count, :integer, default: 0, null: false
		add_column :player_seasons, :goals_count, :integer, default: 0, null: false
		add_column :player_seasons, :appearances_count, :integer, default: 0, null: false
	end
end
