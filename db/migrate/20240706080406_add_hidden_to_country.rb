class AddHiddenToCountry < ActiveRecord::Migration[7.0]
	def change
		add_column :countries, :hidden, :boolean
	end
end
