# == Schema Information
#
# Table name: teams
#
#  id              :bigint           not null, primary key
#  acronym         :string
#  name            :string
#  short_name      :string
#  slug            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  api_football_id :integer
#  country_id      :bigint           not null
#  league_id       :bigint           not null
#
# Indexes
#
#  index_teams_on_acronym     (acronym)
#  index_teams_on_country_id  (country_id)
#  index_teams_on_league_id   (league_id)
#  index_teams_on_name        (name)
#  index_teams_on_slug        (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id) ON DELETE => cascade
#  fk_rails_...  (league_id => leagues.id) ON DELETE => cascade
#
class Team < ApplicationRecord
	extend FriendlyId
	friendly_id :name, use: :slugged

	has_many :players, dependent: :nullify
	has_many :team_seasons, dependent: :destroy
	has_many :head_to_heads, dependent: :destroy
	has_many :player_seasons, through: :team_seasons
	has_many :home_fixtures, class_name: "Fixture", foreign_key: "home_team_id"
	has_many :away_fixtures, class_name: "Fixture", foreign_key: "away_team_id"

	belongs_to :league
	belongs_to :country

	def current_team_season
		team_seasons.find_by(current_season: true)
	end

	def fixtures
		@fixtures ||= Fixture.where("home_team_id = ? OR away_team_id = ?", id, id)
	end
end
