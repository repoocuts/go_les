module ApiFootball
	module Creators
		class SeasonCreator < ApplicationService

			def initialize(league:, season_objects:)
				@league = league
				@season_objects = season_objects
			end

			def call
				season_objects.each do |season_object|
					true? season_object['current'] ? create_current_season(season_object:) : create_old_season(season_object:)
				end
			end

			private

			attr_reader :league, :season_objects

			def create_current_season(season_object:)
				start_date = season_object["start"].to_time
				end_date = season_object["end"].to_time
				years = start_date.year.to_s + "-" + end_date.year.to_s
				league_name_initials = league.name.split(' ').map(&:first).join.downcase
				slug = league.country.slug[0] + league_name_initials + '-' + years

				return if league.seasons.where(slug:).any?

				handle_existing_current_season(league.current_season) if league.current_season

				Season.create(start_date:, end_date:, years:, slug:, league_id: league.id, current_season: true, current_game_week: 1)
				puts "Created season #{start_date} / #{end_date} for #{league.name}"
			end

			def create_old_season(season_object:)
				start_date = season_object["start"].to_time
				end_date = season_object["end"].to_time
				years = start_date.year.to_s + "-" + end_date.year.to_s
				league_name_initials = league.name.split(' ').map(&:first).join.downcase
				slug = league.country.slug[0] + league_name_initials + '-' + years

				return if league.seasons.where(slug:).any?

				Season.create(start_date:, end_date:, years:, slug:, league_id: league.id, current_season: false, current_game_week: 38)
				puts "Created season #{start_date} / #{end_date} for #{league.name}"
			end

			def handle_existing_current_season(season)
				season.update(current_season: false)
			end
		end
	end
end
