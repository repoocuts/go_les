namespace :player_name_updater do
  desc "TODO"
  task player_name_updater: :environment do
    CSV.foreach("player_full_names.csv") do |row|
      player = Player.find(row[0].to_i)
      full_name, short_name = row[1] || nil, row[2] || nil
      player.update(full_name: full_name, short_name: short_name)
    end
  end
end