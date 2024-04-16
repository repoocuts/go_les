class AddIndexOnNameAndAcronymForTeams < ActiveRecord::Migration[7.0]
	def change
		add_index :teams, :name
		add_index :teams, :acronym
	end
end
