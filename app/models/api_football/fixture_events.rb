class FixtureEvents < ApiFootball

  ENDPOINT = 'fixtures/events'

  def initialize(options)
    @options = options
  end

  attr_accessor :events

  def update_fixture_home_substitutions(fixture)
    fixture_events_api_object
    subs = []
    cards = []
    goals = []
    events.each do |e|
      case e['type']
      when 'subst'
        subs.push(e)
      when 'Card'
        cards.push(e)
      else
        goals.push(e)
      end
    end
    create_home_substitutions(subs)
    create_home_cards(cards)
    create_home_goals(goals)
  end

  private

  def interpolate_endpoint
    base_uri + ENDPOINT
  end

  def fixture_events_api_object
    @events ||= call['response']
  end

  def check_player_objects_exist(api_object, fixture)
    api_object.each do |object|
      create_player_season(object['player']['id'], fixture.home_team_season)
    end
  end
  
  def create_home_substitutions(fixture)
  end
end
