class AddGoalsCountToAppearances < ActiveRecord::Migration[7.0]
	def change
		add_column :appearances, :goals_count, :integer, default: 0, null: false
	end
end
