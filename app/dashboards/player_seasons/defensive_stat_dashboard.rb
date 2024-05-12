require "administrate/base_dashboard"

class PlayerSeasons::DefensiveStatDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    clean_sheet_away: Field::Number,
    clean_sheet_away_first_half: Field::Number,
    clean_sheet_away_second_half: Field::Number,
    clean_sheet_first_half: Field::Number,
    clean_sheet_home: Field::Number,
    clean_sheet_home_first_half: Field::Number,
    clean_sheet_home_second_half: Field::Number,
    clean_sheet_second_half: Field::Number,
    clean_sheet_total: Field::Number,
    conceded_away: Field::Number,
    conceded_away_first_half: Field::Number,
    conceded_away_second_half: Field::Number,
    conceded_first_half: Field::Number,
    conceded_home: Field::Number,
    conceded_home_first_half: Field::Number,
    conceded_home_second_half: Field::Number,
    conceded_second_half: Field::Number,
    conceded_total: Field::Number,
    player_season: Field::BelongsTo,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    clean_sheet_away
    clean_sheet_away_first_half
    clean_sheet_away_second_half
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    clean_sheet_away
    clean_sheet_away_first_half
    clean_sheet_away_second_half
    clean_sheet_first_half
    clean_sheet_home
    clean_sheet_home_first_half
    clean_sheet_home_second_half
    clean_sheet_second_half
    clean_sheet_total
    conceded_away
    conceded_away_first_half
    conceded_away_second_half
    conceded_first_half
    conceded_home
    conceded_home_first_half
    conceded_home_second_half
    conceded_second_half
    conceded_total
    player_season
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    clean_sheet_away
    clean_sheet_away_first_half
    clean_sheet_away_second_half
    clean_sheet_first_half
    clean_sheet_home
    clean_sheet_home_first_half
    clean_sheet_home_second_half
    clean_sheet_second_half
    clean_sheet_total
    conceded_away
    conceded_away_first_half
    conceded_away_second_half
    conceded_first_half
    conceded_home
    conceded_home_first_half
    conceded_home_second_half
    conceded_second_half
    conceded_total
    player_season
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

  # Overwrite this method to customize how defensive stats are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(defensive_stat)
  #   "PlayerSeasons::DefensiveStat ##{defensive_stat.id}"
  # end
end
