class AddAllForeignKeyWithCascade < ActiveRecord::Migration[7.0]
	def change
		remove_foreign_key :appearances, :fixtures if foreign_key_exists?(:appearances, :fixtures)
		add_foreign_key :appearances, :fixtures, on_delete: :cascade

		remove_foreign_key :appearances, :team_seasons if foreign_key_exists?(:appearances, :team_seasons)
		add_foreign_key :appearances, :team_seasons, on_delete: :cascade

		remove_foreign_key :assists, :appearances if foreign_key_exists?(:assists, :appearances)
		add_foreign_key :assists, :appearances, on_delete: :cascade

		remove_foreign_key :assists, :fixtures if foreign_key_exists?(:assists, :fixtures)
		add_foreign_key :assists, :fixtures, on_delete: :cascade

		remove_foreign_key :assists, :goals if foreign_key_exists?(:assists, :goals)
		add_foreign_key :assists, :goals, on_delete: :cascade

		remove_foreign_key :assists, :team_seasons if foreign_key_exists?(:assists, :team_seasons)
		add_foreign_key :assists, :team_seasons, on_delete: :cascade

		remove_foreign_key :cards, :appearances if foreign_key_exists?(:cards, :appearances)
		add_foreign_key :cards, :appearances, on_delete: :cascade

		remove_foreign_key :cards, :fixtures if foreign_key_exists?(:cards, :fixtures)
		add_foreign_key :cards, :fixtures, on_delete: :cascade

		remove_foreign_key :cards, :team_seasons if foreign_key_exists?(:cards, :team_seasons)
		add_foreign_key :cards, :team_seasons, on_delete: :cascade

		remove_foreign_key :goals, :appearances if foreign_key_exists?(:goals, :appearances)
		add_foreign_key :goals, :appearances, on_delete: :cascade

		remove_foreign_key :goals, :fixtures if foreign_key_exists?(:goals, :fixtures)
		add_foreign_key :goals, :fixtures, on_delete: :cascade

		remove_foreign_key :goals, :team_seasons if foreign_key_exists?(:goals, :team_seasons)
		add_foreign_key :goals, :team_seasons, on_delete: :cascade
	end
end
