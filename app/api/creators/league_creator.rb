class Creators::LeagueCreator < ApiFootball

  ENDPOINT = 'leagues'
  
  def create_premier_league
    leagues = call['response']
    leagues.each do |elem|
      if elem['league']['name'] == 'Premier League' &&  elem['country']['name'] == 'England'
        create_from_response(elem)
      end
    end
  end

  def create_leagues
    leagues = call['response']
    leagues.each do |elem|
      if !League.where(name: elem['league']['name']).any?
        create_from_response(elem)
      end
    end
  end

  private

  def interpolate_endpoint
    base_uri + ENDPOINT
  end

  def create_from_response(response_element)
    country = get_country(response_element['country']['name'])
    League.create(name: response_element['league']['name'], api_football_id: response_element['league']['id'], country_id: country.id)
  end

  def get_country(country_name)
    Country.find_by(name: country_name)
  end

end