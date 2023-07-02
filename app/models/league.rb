class League < ApplicationRecord
  belongs_to :country
  has_many :seasons
  has_many :teams
end
