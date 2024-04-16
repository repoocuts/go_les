# frozen_string_literal: true

class NextGameWeekFixturesComponent < ViewComponent::Base
	include ApplicationHelper
	with_collection_parameter :fixture

	def initialize(fixture)
		@fixture = fixture
	end

	def home_team_acronym
		fixture[:fixture].home_team_name_acronym
	end

	def home_team_name
		fixture[:fixture].home_team_name
	end

	def away_team_acronym
		fixture[:fixture].away_team_name_acronym
	end

	def away_team_name
		fixture[:fixture].away_team_name
	end

	def home_team_object
		fixture[:fixture].home_team_object
	end

	def away_team_object
		fixture[:fixture].away_team_object
	end

	def kick_off_or_score
		fixture[:fixture].kick_off_or_score
	end

	private

	attr_reader :fixture
end
