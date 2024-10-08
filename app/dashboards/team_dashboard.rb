require "administrate/base_dashboard"

class TeamDashboard < Administrate::BaseDashboard
	# ATTRIBUTE_TYPES
	# a hash that describes the type of each of the model's fields.
	#
	# Each different type represents an Administrate::Field object,
	# which determines how the attribute is displayed
	# on pages throughout the dashboard.
	ATTRIBUTE_TYPES = {
		                  id: Field::Number,
		                  acronym: Field::String,
		                  api_football_id: Field::Number,
		                  country_id: Field::Number,
		                  league: Field::BelongsTo,
		                  name: Field::String,
		                  players: Field::HasMany,
		                  short_name: Field::String,
		                  team_seasons: Field::HasMany,
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
    acronym
    api_football_id
    country_id
  ].freeze

	# SHOW_PAGE_ATTRIBUTES
	# an array of attributes that will be displayed on the model's show page.
	SHOW_PAGE_ATTRIBUTES = %i[
    id
    acronym
    api_football_id
    country_id
    league
    name
    players
    short_name
    team_seasons
    created_at
    updated_at
  ].freeze

	# FORM_ATTRIBUTES
	# an array of attributes that will be displayed
	# on the model's form (`new` and `edit`) pages.
	FORM_ATTRIBUTES = %i[
    acronym
    api_football_id
    country_id
    league
    name
    players
    short_name
    team_seasons
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

	# Overwrite this method to customize how teams are displayed
	# across all pages of the ceefax dashboard.
	#
	def display_resource(team)
		"#{team.name}"
	end
end
