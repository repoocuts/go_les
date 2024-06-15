class AddYearsToSeasons < ActiveRecord::Migration[7.0]
  def change
    add_column :seasons, :years, :string
  end
end
