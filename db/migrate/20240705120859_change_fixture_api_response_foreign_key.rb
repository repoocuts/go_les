class ChangeFixtureApiResponseForeignKey < ActiveRecord::Migration[7.0]
	def change
		remove_foreign_key :fixture_api_responses, :fixtures if foreign_key_exists?(:fixture_api_responses, :fixtures)
		add_foreign_key :fixture_api_responses, :fixtures, on_delete: :cascade
	end
end
