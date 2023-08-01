# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

country = Country.first

league = League.first

season = Season.first

team_names = ['United', 'City', 'Athletic', 'Town']
player_names = %w[Adams Bruce Cooper Davies Evans Fish Gooch Harris Ings James Kirk Lee Miller Nielson Overmars Parker Quinn Rashford Stones Tristan Unsworth Vieira Walker Xavi Yeboah Zaha]
position = %w[keeper defender midfielder attacker]
4.times do
  name = team_names.pop
  acronym = name[0..2]
  team = Team.create(name: name, acronym: acronym, short_name: name, country_id: country.id, league: league)
  ts = TeamSeason.create(current_season: true, points: 0, season: season, team: team)
  20.times do 
    name = player_names.sample
    player = Player.create(full_name: name, position: position.sample, short_name: name, team: team)
    PlayerSeason.create(current_season: true, player: player, team_season: ts)
  end
end

team_seasons = TeamSeason.all

home_team_one = team_seasons[0]
away_team_one = team_seasons[1]
home_team_two = team_seasons[2]
away_team_two = team_seasons[3]

fixture_one = Fixture.create(away_score: 3, game_week: 1, home_score: 2, kick_off: DateTime.now - 48.hours, away_team_season_id: away_team_one.id, home_team_season_id: home_team_one.id, league: league, season: season)


fixture_two = Fixture.create(away_score: 1, game_week: 1, home_score: 1, kick_off: DateTime.now - 24.hours, away_team_season_id: away_team_two.id, home_team_season_id: home_team_two.id, league: league, season: season)

fixture_three = Fixture.create(game_week: 2, kick_off: DateTime.now + 1.week, away_team_season_id: away_team_two.id, home_team_season_id: home_team_one.id, league: league, season: season)

fixture_four = Fixture.create(game_week: 2, kick_off: DateTime.now + 1.week, away_team_season_id: away_team_one.id, home_team_season_id: home_team_two.id, league: league, season: season)

home_team_one_player_seasons = PlayerSeason.where(team_season: home_team_one)
away_team_one_player_seasons = PlayerSeason.where(team_season: away_team_one)

home_team_two_player_seasons = PlayerSeason.where(team_season: home_team_two)
away_team_two_player_seasons = PlayerSeason.where(team_season: away_team_two)

home_team_one_player_seasons.first(11).each do |ps|
  Appearance.create(appearance_type: 'start', is_home: true, minutes: 90, fixture: fixture_one, player_season: ps, team_season: home_team_one)
end
away_team_one_player_seasons.first(11).each do |ps|
  Appearance.create(appearance_type: 'start', is_home: false, minutes: 90, fixture: fixture_one, player_season: ps, team_season: away_team_one)
end

home_team_two_player_seasons.first(11).each do |ps|
  Appearance.create(appearance_type: 'start', is_home: true, minutes: 90, fixture: fixture_two, player_season: ps, team_season: home_team_two)
end
away_team_two_player_seasons.first(11).each do |ps|
  Appearance.create(appearance_type: 'start', is_home: true, minutes: 90, fixture: fixture_two, player_season: ps, team_season: home_team_two)
end
