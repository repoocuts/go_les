require "administrate/base_dashboard"

class RedCardsStatDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    away: Field::Number,
    away_first_half: Field::Number,
    away_second_half: Field::Number,
    first_half: Field::Number,
    home: Field::Number,
    home_first_half: Field::Number,
    home_second_half: Field::Number,
    second_half: Field::Number,
    team_season: Field::BelongsTo,
    total: Field::Number,
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
    away
    away_first_half
    away_second_half
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    away
    away_first_half
    away_second_half
    first_half
    home
    home_first_half
    home_second_half
    second_half
    team_season
    total
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    away
    away_first_half
    away_second_half
    first_half
    home
    home_first_half
    home_second_half
    second_half
    team_season
    total
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

  # Overwrite this method to customize how red cards stats are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(red_cards_stat)
  #   "RedCardsStat ##{red_cards_stat.id}"
  # end
end
