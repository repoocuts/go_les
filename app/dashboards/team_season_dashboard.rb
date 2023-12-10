require "administrate/base_dashboard"

class TeamSeasonDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
                      id: Field::Number,
                      api_football_id: Field::Number,
                      appearances: Field::HasMany,
                      appearances_count: Field::Number,
                      assists: Field::HasMany,
                      assists_count: Field::Number,
                      away_fixtures: Field::HasMany,
                      cards: Field::HasMany,
                      current_season: Field::Boolean,
                      goals: Field::HasMany,
                      goals_count: Field::Number,
                      home_fixtures: Field::HasMany,
                      player_seasons: Field::HasMany,
                      points: Field::Number,
                      red_cards: Field::HasMany,
                      red_cards_count: Field::Number,
                      season: Field::BelongsTo,
                      team: Field::BelongsTo,
                      yellow_cards: Field::HasMany,
                      yellow_cards_count: Field::Number,
                      created_at: Field::DateTime,
                      updated_at: Field::DateTime,
                    }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    api_football_id
    appearances
    appearances_count
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    api_football_id
    appearances
    appearances_count
    assists
    assists_count
    away_fixtures
    cards
    current_season
    goals
    goals_count
    home_fixtures
    player_seasons
    points
    red_cards
    red_cards_count
    season
    team
    yellow_cards
    yellow_cards_count
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    api_football_id
    appearances
    appearances_count
    assists
    assists_count
    away_fixtures
    cards
    current_season
    goals
    goals_count
    home_fixtures
    player_seasons
    points
    red_cards
    red_cards_count
    season
    team
    yellow_cards
    yellow_cards_count
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how team seasons are displayed
  # across all pages of the ceefax dashboard.
  #
  def display_resource(team_season)
    "#{team_season.team_name}"
  end
end
