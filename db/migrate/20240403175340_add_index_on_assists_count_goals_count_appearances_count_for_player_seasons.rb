class AddIndexOnAssistsCountGoalsCountAppearancesCountForPlayerSeasons < ActiveRecord::Migration[7.0]
	def change
		add_index :player_seasons, :assists_count
		add_index :player_seasons, :goals_count
		add_index :player_seasons, :appearances_count
	end
end
