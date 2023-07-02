class Updaters::FixtureAwayStarts

  include Creators::AwayStartsCreator
  include PlayerSeasonCreatorHelper

  def update_fixture_away_starts(away_team_api_object, fixture)
    create_away_starts(away_team_api_object, fixture)
  end

  private

  def check_player_objects_exist(api_object, fixture)
    api_object.each do |object|
      create_player_season(object['player']['id'], fixture.away_team_season)
    end
  end
  
  def create_away_starts(starting_players, fixture)
    # check_player_objects_exist(starting_players, fixture)
    create_away_starting_lineup(starting_players, fixture)
  end
end
