class ChangeForeignKeyConstraints < ActiveRecord::Migration[7.0]
	def change
		change_column_null :referee_fixtures, :season_id, true

		remove_foreign_key :referees, :seasons if foreign_key_exists?(:referees, :seasons)
		add_foreign_key :referees, :seasons, on_delete: :cascade

		remove_foreign_key :referee_fixtures, :referees if foreign_key_exists?(:referee_fixtures, :referees)
		add_foreign_key :referee_fixtures, :referees, on_delete: :cascade

		remove_foreign_key :referee_fixtures, :seasons if foreign_key_exists?(:referee_fixtures, :seasons)
		add_foreign_key :referee_fixtures, :seasons, on_delete: :cascade
	end
end
