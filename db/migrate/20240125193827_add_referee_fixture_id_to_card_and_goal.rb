class AddRefereeFixtureIdToCardAndGoal < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :referee_fixture_id, :integer
    add_column :goals, :referee_fixture_id, :integer
  end
end
