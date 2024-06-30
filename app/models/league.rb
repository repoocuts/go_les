# == Schema Information
#
# Table name: leagues
#
#  id              :bigint           not null, primary key
#  name            :string
#  slug            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  api_football_id :integer
#  country_id      :bigint           not null
#
# Indexes
#
#  index_leagues_on_country_id  (country_id)
#  index_leagues_on_slug        (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id)
#
class League < ApplicationRecord
	extend FriendlyId
	friendly_id :name, use: :slugged
  
	belongs_to :country
	has_many :seasons
	has_many :teams

	def current_season
		seasons.find_by(current_season: true)
	end

	def last_season
		seasons.find_by(start_date: current_season.start_date - 1.year)
	end
end
