# == Schema Information
#
# Table name: object_handling_failures
#
#  id                       :bigint           not null, primary key
#  api_response_element     :jsonb
#  object_type              :string
#  other_attributes         :jsonb
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  related_appearance_id    :integer
#  related_country_id       :integer
#  related_fixture_id       :integer
#  related_league_id        :integer
#  related_player_id        :integer
#  related_player_season_id :integer
#  related_season_id        :integer
#  related_team_id          :integer
#  related_team_season_id   :integer
#
class ObjectHandlingFailure < ApplicationRecord
end
