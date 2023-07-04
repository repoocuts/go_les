namespace :full_name_csv do
  desc "TODO"
  task full_name_csv: :environment do
    require 'csv'
    CSV.open("player_full_names.csv", "wb") do |csv|
      Player.all.each do |player|
        split_name = player.full_name.split(' ')
        data = [player.id, split_name].flatten
        csv << data
      end
    end
  end
end
