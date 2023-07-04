namespace :update_fixture do
  desc "Loop through fixtures to update score and create lineups"
  task update_fixtures: :environment do
    fixtures = Fixture.where('kick_off < ? AND home_score IS NULL AND away_score IS NULL', DateTime.now).order(:kick_off)
  end
end
