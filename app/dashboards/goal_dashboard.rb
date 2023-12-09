require "administrate/base_dashboard"

class GoalDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
                      id: Field::Number,
                      appearance: Field::BelongsTo.with_options(searchable: true, searchable_field: "appearance.player_season.get_player_name"),
                      assist: Field::HasOne,
                      fixture: Field::BelongsTo,
                      goal_type: Field::String,
                      is_home: Field::Boolean,
                      minute: Field::Number,
                      own_goal: Field::Boolean,
                      player_season: Field::BelongsTo,
                      team_season: Field::BelongsTo,
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
    appearance
    assist
    fixture
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    appearance
    assist
    fixture
    goal_type
    is_home
    minute
    own_goal
    player_season
    team_season
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    appearance
    assist
    fixture
    goal_type
    is_home
    minute
    own_goal
    player_season
    team_season
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

  # Overwrite this method to customize how goals are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(goal)
    "#{goal.player_season.get_player_name}"
  end
end
