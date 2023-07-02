class Creators::TeamCreator < ApiFootball

  ENDPOINT = 'teams'

  def create_team
    teams = call['response']
    teams.map { |elem| create_from_response(elem) }
  end

  private

  attr_reader :league_api_football_id

  def interpolate_endpoint
    base_uri + ENDPOINT
  end

  def create_from_response(response_element)
    league = League.find_by(api_football_id: options[:league])
    Team.create(
      acronym: response_element['team']['code'],
      api_football_id: response_element['team']['id'],
      league_id: league.id,
      name: response_element['team']['name']
    )
  end
end