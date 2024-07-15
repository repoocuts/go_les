class ChangeTeamIdOnPlayers < ActiveRecord::Migration[7.0]
	def change
		change_column_null :players, :team_id, true
		remove_foreign_key :players, :teams if foreign_key_exists?(:players, :teams)
		add_foreign_key :players, :teams, on_delete: :nullify
	end
end
