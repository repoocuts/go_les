class Updaters::FixtureHomeStarts

  include Creators::HomeStartsCreator
  include PlayerSeasonCreatorHelper

  def update_fixture_home_starts(home_team_api_object, fixture)
    create_home_starts(home_team_api_object, fixture)
  end

  private

  def check_player_objects_exist(api_object, fixture)
    api_object.each do |object|
      create_player_season(object['player']['id'], fixture.home_team_season)
    end
  end
  
  def create_home_starts(starting_players, fixture)
    # check_player_objects_exist(starting_players, fixture)
    create_home_starting_lineup(starting_players, fixture)
  end
end
