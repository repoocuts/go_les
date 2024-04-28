class ChangePositionToStringInPlayers < ActiveRecord::Migration[7.0]
	def change
		change_column :players, :position, :string
	end
end
