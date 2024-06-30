# == Schema Information
#
# Table name: countries
#
#  id              :bigint           not null, primary key
#  code            :string
#  name            :string
#  slug            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  api_football_id :integer
#
# Indexes
#
#  index_countries_on_slug  (slug) UNIQUE
#
class Country < ApplicationRecord
	extend FriendlyId
	friendly_id :name, use: :slugged

	has_many :leagues

	def to_param
		name.parameterize
	end
end
