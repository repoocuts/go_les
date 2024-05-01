class AddHomeAndAwayCornersToFixture < ActiveRecord::Migration[7.0]
	def change
		add_column :fixtures, :home_corners, :integer
		add_column :fixtures, :away_corners, :integer
	end
end
