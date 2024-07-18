class AddLastMatchIdToHeadToHeads < ActiveRecord::Migration[7.0]
	def change
		add_column :head_to_heads, :last_match_id, :integer
	end
end
