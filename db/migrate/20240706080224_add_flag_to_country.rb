class AddFlagToCountry < ActiveRecord::Migration[7.0]
	def change
		add_column :countries, :flag, :string
	end
end
