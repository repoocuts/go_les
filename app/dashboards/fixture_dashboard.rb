require "administrate/base_dashboard"

class FixtureDashboard < Administrate::BaseDashboard
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
                      assists: Field::HasMany,
                      away_assists_with_player_season: Field::HasMany,
                      away_goals_with_player_season_and_assist: Field::HasMany,
                      away_score: Field::Number,
                      away_starts: Field::HasMany,
                      away_team_season: Field::BelongsTo,
                      cards: Field::HasMany,
                      game_week: Field::Number,
                      goals: Field::HasMany,
                      home_assists_with_player_season: Field::HasMany,
                      home_goals_with_player_season_and_assist: Field::HasMany,
                      home_score: Field::Number,
                      home_starts: Field::HasMany,
                      home_team_season: Field::BelongsTo,
                      kick_off: Field::DateTime,
                      league: Field::BelongsTo,
                      season: Field::BelongsTo,
                      season_game_week: Field::BelongsTo,
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
    assists
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    api_football_id
    appearances
    assists
    away_assists_with_player_season
    away_goals_with_player_season_and_assist
    away_score
    away_starts
    away_team_season
    cards
    game_week
    goals
    home_assists_with_player_season
    home_goals_with_player_season_and_assist
    home_score
    home_starts
    home_team_season
    kick_off
    league
    season
    season_game_week
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    api_football_id
    appearances
    assists
    away_assists_with_player_season
    away_goals_with_player_season_and_assist
    away_score
    away_starts
    away_team_season
    cards
    game_week
    goals
    home_assists_with_player_season
    home_goals_with_player_season_and_assist
    home_score
    home_starts
    home_team_season
    kick_off
    league
    season
    season_game_week
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

  # Overwrite this method to customize how fixtures are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(fixture)
    "#{fixture.home_team_name} vs #{fixture.away_team_name}"
  end
end
