# == Schema Information
#
# Table name: leagues
#
#  id              :bigint           not null, primary key
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  api_football_id :integer
#  country_id      :bigint           not null
#
# Indexes
#
#  index_leagues_on_country_id  (country_id)
#
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id)
#
class League < ApplicationRecord
  belongs_to :country
  has_many :seasons
  has_many :teams
end
