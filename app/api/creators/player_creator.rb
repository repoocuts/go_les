class Creators::PlayerCreator < ApiFootball

  ENDPOINT = 'players/squads'

  include PlayerSeasonCreatorHelper

  def create_player
    players = call['response'][0]['players']
    players.map { |elem| create_from_response(elem) }
  end

  private

  def interpolate_endpoint
    base_uri + ENDPOINT
  end

  def create_from_response(response_element)
    team = Team.find_by(api_football_id: options[:team])
    player = Player.find_or_create_by(
      full_name: response_element['name'],
      api_football_id: response_element['id'],
      position: response_element['position'],
      team_id: team.id
    )
    create_player_season(player.api_football_id, team.current_team_season)
  end
end
