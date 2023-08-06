module ApiFootball
  module Creators
    class SeasonCreator

      def create_current_season(league)
        start_date = DateTime.new(current_year, 8, 1)
        end_date = DateTime.new(next_year, 5, 31)
        Season.create(start_date: start_date, end_date: end_date, league_id: league.id, current_season: true, current_game_week: 1)
      end

      def create_last_season(league)
        start_date = DateTime.new(previous_year, 8, 1)
        end_date = DateTime.new(current_year, 5, 31)
        Season.create(start_date: start_date, end_date: end_date, league_id: league.id, current_season: false, current_game_week: 38)
      end

      private

      def current_year
        DateTime.now.year
      end

      def previous_year
        current_year - 1
      end

      def next_year
        current_year + 1
      end
    end
  end
end
