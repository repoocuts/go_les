require "administrate/base_dashboard"

class HeadToHeadDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    bookings_received: Field::Number,
    conceded_against_opponent: Field::Number,
    conceded_away: Field::Number,
    conceded_home: Field::Number,
    current_season_fixture_ids: Field::Number,
    current_team_season_id: Field::Number,
    fixture_ids: Field::Number,
    fixtures_played: Field::Number,
    opponent_bookings: Field::Number,
    opponent_id: Field::Number,
    opponent_reds: Field::Number,
    opponent_top_assist_player_season_id: Field::Number,
    opponent_top_scorer_player_season_id: Field::Number,
    reds_received: Field::Number,
    scored_against_opponent: Field::Number,
    scored_away: Field::Number,
    scored_home: Field::Number,
    team: Field::BelongsTo,
    top_assist_player_season_id: Field::Number,
    top_scorer_player_season_id: Field::Number,
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
    bookings_received
    conceded_against_opponent
    conceded_away
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    bookings_received
    conceded_against_opponent
    conceded_away
    conceded_home
    current_season_fixture_ids
    current_team_season_id
    fixture_ids
    fixtures_played
    opponent_bookings
    opponent_id
    opponent_reds
    opponent_top_assist_player_season_id
    opponent_top_scorer_player_season_id
    reds_received
    scored_against_opponent
    scored_away
    scored_home
    team
    top_assist_player_season_id
    top_scorer_player_season_id
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    bookings_received
    conceded_against_opponent
    conceded_away
    conceded_home
    current_season_fixture_ids
    current_team_season_id
    fixture_ids
    fixtures_played
    opponent_bookings
    opponent_id
    opponent_reds
    opponent_top_assist_player_season_id
    opponent_top_scorer_player_season_id
    reds_received
    scored_against_opponent
    scored_away
    scored_home
    team
    top_assist_player_season_id
    top_scorer_player_season_id
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

  # Overwrite this method to customize how head to heads are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(head_to_head)
  #   "HeadToHead ##{head_to_head.id}"
  # end
end
