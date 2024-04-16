class AddIndexOnCardTypeForCards < ActiveRecord::Migration[7.0]
	def change
		add_index :cards, :card_type
	end
end
