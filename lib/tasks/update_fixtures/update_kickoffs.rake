namespace :update_kickoffs do
	desc "update kick offs for next 50 fixtures per league"
	task setup: :environment do

		League.not_hidden.each do |league|
			ApiFootball::Updaters::FixtureKickOffs.new(league:).call
		end
	end
end
