class AddIndexOnGoalTypeAndAssistForGoals < ActiveRecord::Migration[7.0]
	def change
		add_index :goals, :goal_type
		add_index :goals, :assist_id
	end
end
