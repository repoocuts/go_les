class AddHiddenToSeason < ActiveRecord::Migration[7.0]
	def change
		add_column :seasons, :hidden, :boolean
	end
end
