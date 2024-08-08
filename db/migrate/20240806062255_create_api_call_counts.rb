class CreateApiCallCounts < ActiveRecord::Migration[7.0]
	def change
		create_table :api_call_counts do |t|
			t.integer :count
			t.integer :last_league_id
			t.integer :last_team_id
			t.timestamps
		end
	end
end
