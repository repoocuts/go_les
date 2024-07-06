class AddLogoAndHiddenToLeagues < ActiveRecord::Migration[7.0]
	def change
		add_column :leagues, :logo, :string
		add_column :leagues, :hidden, :boolean
	end
end
