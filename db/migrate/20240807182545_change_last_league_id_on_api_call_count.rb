class ChangeLastLeagueIdOnApiCallCount < ActiveRecord::Migration[7.0]
	def change
		remove_column :api_call_counts, :last_league_id, :integer
		add_column :api_call_counts, :last_league_ids, :integer, array: true, default: []
	end
end
