class AddIndexOnFullNameAndShortNameForPlayer < ActiveRecord::Migration[7.0]
	def change
		add_index :players, :full_name
		add_index :players, :short_name
	end
end
