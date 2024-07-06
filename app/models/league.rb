# == Schema Information
#
# Table name: leagues
#
#  id              :bigint           not null, primary key
#  hidden          :boolean
#  logo            :string
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
# l
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id) ON DELETE => cascade
#
class League < ApplicationRecord
	extend FriendlyId
	friendly_id :name, use: :slugged

	belongs_to :country
	has_many :seasons, dependent: :destroy
	has_many :teams, dependent: :destroy

	scope :not_hidden, -> { where(hidden: false) }

	def current_season
		seasons.find_by(current_season: true)
	end

	def last_season
		seasons.find_by(start_date: current_season.start_date - 1.year)
	end
end
