class AddIndexOnCountsForTeamSeasons < ActiveRecord::Migration[7.0]
	def change
		add_index :team_seasons, :goals_count
		add_index :team_seasons, :assists_count
		add_index :team_seasons, :appearances_count
		add_index :team_seasons, :yellow_cards_count
		add_index :team_seasons, :red_cards_count
	end
end
