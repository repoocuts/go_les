class Creators::CountryCreator < ApiFootball

  ENDPOINT = 'countries'

  def create_england
    countries = call['response']
    countries.each do |elem|
      if elem['name'] == 'England'
        create_from_response(elem)
      end
    end
  end

  def create_countries
    countries = call['response']
    countries.each do |elem|
      if !Country.where(name: elem['name']).any?
        create_from_response(elem)
      end
    end
  end

  private

  def create_from_response(response_element)
    Country.create(name: response_element['name'], code: response_element['code'])
  end

  def interpolate_endpoint
    base_uri + ENDPOINT
  end
end