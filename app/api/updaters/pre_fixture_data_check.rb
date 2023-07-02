class Updaters::PreFixtureDataCheck < ApiFootball

  include Creators::HomeStartsCreator
  include Updaters::HomePlayerChecker

  ENDPOINT = 'fixtures'

  def initialize(options)
    @options = options
  end

  def home_team_data_verifyer
    verify_data(home_team_api_object)
  end

  private

  def interpolate_endpoint
    base_uri + ENDPOINT
  end

  def home_team_api_object
    call['response'][0]['lineups'][0]
  end
  
  def create_home_starts(fixture)
    starting_players = home_lineup_api_object
    create_home_starting_lineup(starting_players, fixture)
  end
end