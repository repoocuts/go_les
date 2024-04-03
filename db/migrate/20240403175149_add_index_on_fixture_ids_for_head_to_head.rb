class AddIndexOnFixtureIdsForHeadToHead < ActiveRecord::Migration[7.0]
	def change
		add_index :head_to_heads, :fixture_ids, using: 'gin'
	end
end
