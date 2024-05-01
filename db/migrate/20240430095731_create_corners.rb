class CreateCorners < ActiveRecord::Migration[7.0]
	def change
		create_table :corners do |t|
			t.references :team_season, null: false, foreign_key: true
			t.references :fixture, null: false, foreign_key: true
			t.boolean :is_home
			t.integer :minute
			t.boolean :is_first_half
			t.boolean :is_second_half
			t.timestamps
		end
	end
end
