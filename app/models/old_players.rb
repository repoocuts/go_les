class OldPlayers
  include HTTParty

  def create_player(response_element)
    team = Team.find_by(api_football_id: options[:team])
    player = Player.create(
      full_name: response_element['player_name'],
      api_football_id: response_element['iplayer_idd'],
      position: response_element['position'],
      team_id: team.id,
    )
    PlayerSeason.create(
      player: player,
      team_season: team.team_seasons.first,
      current_season: false,
    )
  end

  def teams_loop
    Team.all.each do |team|
      response = call(team.api_football_id)
      response['api']['players'].each do |element|
        create_player(element, team)
      end
    end
  end

  private

  def call(team_id)
    HTTParty.get(uri(team_id), headers: headers)
  end

  def headers
    { 
      'Accept': '*/*', 
      'x-rapidapi-host': 'api-football-v1.p.rapidapi.com',
      'x-rapidapi-key': ENV['RAPID_API_KEY']
    }
  end

  def uri(team_id)
    "https://api-football-v1.p.rapidapi.com/v2/players/squad/#{team_id}/2022-2023"
  end

  def create_player(response_element, team)
    player = Player.create(
      full_name: response_element['player_name'],
      api_football_id: response_element['player_id'],
      position: response_element['position'],
      team_id: team.id,
    )
    PlayerSeason.create(
      player: player,
      team_season: team.team_seasons.first,
      current_season: false,
    )
  end
end
