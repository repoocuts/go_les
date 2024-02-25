class AddAssistIdToGoal < ActiveRecord::Migration[7.0]
  def change
    add_column :goals, :assist_id, :integer
  end
end
