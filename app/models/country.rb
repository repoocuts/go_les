# == Schema Information
#
# Table name: countries
#
#  id              :bigint           not null, primary key
#  code            :string
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  api_football_id :integer
#
class Country < ApplicationRecord
	has_many :leagues

	def to_param
		name.parameterize
	end
end
