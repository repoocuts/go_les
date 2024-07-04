class AddForeignKeyConstraintsWithCascade < ActiveRecord::Migration[7.0]
	def change
		remove_foreign_key :leagues, :countries if foreign_key_exists?(:leagues, :countries)
		add_foreign_key :leagues, :countries, on_delete: :cascade

		remove_foreign_key :teams, :leagues if foreign_key_exists?(:teams, :leagues)
		add_foreign_key :teams, :leagues, on_delete: :cascade

		remove_foreign_key :teams, :countries if foreign_key_exists?(:teams, :countries)
		add_foreign_key :teams, :countries, on_delete: :cascade

		remove_foreign_key :head_to_heads, :teams if foreign_key_exists?(:head_to_heads, :teams)
		add_foreign_key :head_to_heads, :teams, on_delete: :cascade

		remove_foreign_key :seasons, :leagues if foreign_key_exists?(:seasons, :leagues)
		add_foreign_key :seasons, :leagues, on_delete: :cascade

		remove_foreign_key :team_seasons, :seasons if foreign_key_exists?(:team_seasons, :seasons)
		add_foreign_key :team_seasons, :seasons, on_delete: :cascade

		remove_foreign_key :team_seasons, :teams if foreign_key_exists?(:team_seasons, :teams)
		add_foreign_key :team_seasons, :teams, on_delete: :cascade

		remove_foreign_key :fixtures, :leagues if foreign_key_exists?(:fixtures, :leagues)
		add_foreign_key :fixtures, :leagues, on_delete: :cascade

		remove_foreign_key :fixture_api_responses, :fixtures if foreign_key_exists?(:fixture_api_responses, :fixtures)
		add_foreign_key :fixture_api_responses, :fixtures, on_delete: :cascade

		remove_foreign_key :player_seasons, :players if foreign_key_exists?(:player_seasons, :players)
		add_foreign_key :player_seasons, :players, on_delete: :cascade

		remove_foreign_key :player_seasons, :team_seasons if foreign_key_exists?(:player_seasons, :team_seasons)
		add_foreign_key :player_seasons, :team_seasons, on_delete: :cascade

		remove_foreign_key :appearances, :player_seasons if foreign_key_exists?(:appearances, :player_seasons)
		add_foreign_key :appearances, :player_seasons, on_delete: :cascade

		remove_foreign_key :goals, :player_seasons if foreign_key_exists?(:goals, :player_seasons)
		add_foreign_key :goals, :player_seasons, on_delete: :cascade

		remove_foreign_key :cards, :player_seasons if foreign_key_exists?(:cards, :player_seasons)
		add_foreign_key :cards, :player_seasons, on_delete: :cascade

		remove_foreign_key :assists, :player_seasons if foreign_key_exists?(:assists, :player_seasons)
		add_foreign_key :assists, :player_seasons, on_delete: :cascade

		remove_foreign_key :goals_scored_stats, :team_seasons if foreign_key_exists?(:goals_scored_stats, :team_seasons)
		add_foreign_key :goals_scored_stats, :team_seasons, on_delete: :cascade

		remove_foreign_key :goals_conceded_stats, :team_seasons if foreign_key_exists?(:goals_conceded_stats, :team_seasons)
		add_foreign_key :goals_conceded_stats, :team_seasons, on_delete: :cascade

		remove_foreign_key :yellow_cards_stats, :team_seasons if foreign_key_exists?(:yellow_cards_stats, :team_seasons)
		add_foreign_key :yellow_cards_stats, :team_seasons, on_delete: :cascade

		remove_foreign_key :red_cards_stats, :team_seasons if foreign_key_exists?(:red_cards_stats, :team_seasons)
		add_foreign_key :red_cards_stats, :team_seasons, on_delete: :cascade
	end
end
