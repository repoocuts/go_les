require "administrate/base_dashboard"

class PlayerSeasonDashboard < Administrate::BaseDashboard
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
		                  cards: Field::HasMany,
		                  current_season: Field::Boolean,
		                  goals: Field::HasMany,
		                  goals_count: Field::Number,
		                  player: Field::BelongsTo,
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
    player
    team_season
    appearances_count
  ].freeze

	# SHOW_PAGE_ATTRIBUTES
	# an array of attributes that will be displayed on the model's show page.
	SHOW_PAGE_ATTRIBUTES = %i[
	  player
    team_season
    appearances
    id
    api_football_id
    appearances_count
    assists
    assists_count
    cards
    current_season
    goals
    goals_count
    created_at
    updated_at
  ].freeze

	# FORM_ATTRIBUTES
	# an array of attributes that will be displayed
	# on the model's form (`new` and `edit`) pages.
	FORM_ATTRIBUTES = %i[
    api_football_id
    current_season
    player
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

	# Overwrite this method to customize how player seasons are displayed
	# across all pages of the ceefax dashboard.
	#
	def display_resource(player_season)
		"#{player_season.player.full_name}" if player_season.player.full_name

		"#{player_season.player.short_name}"
	end
end
