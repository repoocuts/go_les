class AddJsonbColumnsToFixtureApiResponse < ActiveRecord::Migration[7.0]
  def change
    create_table :fixture_api_responses do |t|
      t.jsonb :pre_fixture
      t.jsonb :finished_fixture
      t.references :fixture, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
