require './lib/stat_tracker'
require './spec/spec_helper'
require './lib/game_statistics'

RSpec.describe GameStatistics do
  context "Game stat methods" do
    game_path       = './spec/fixture_files/test_games.csv'
    team_path       = './spec/fixture_files/test_teams.csv'
    game_teams_path = './spec/fixture_files/test_game_teams.csv'

    locations = {
      games:      game_path,
      teams:      team_path,
      game_teams: game_teams_path
      }

    stat_tracker = StatTracker.from_csv(locations)

    it '#highest_total_score' do
      expect(stat_tracker.highest_total_score).to eq(9)
    end

    it '#lowest_total_score' do
      expect(stat_tracker.lowest_total_score).to eq(1)
    end

    it '#percentage_home_wins' do
      expect(stat_tracker.percentage_home_wins).to eq(0.45)
    end

    it '#percentage_visitor_wins' do
      expect(stat_tracker.percentage_visitor_wins).to eq(0.37)
    end

    it '#percentage_ties' do
      expect(stat_tracker.percentage_ties).to eq(0.18)
    end

    it '#count_of_games_by_season' do
      expect(stat_tracker.count_of_games_by_season).to eq({
        "20122013"=>111,
        "20132014"=>123,
        "20142015"=>221,
        "20152016"=>87,
        "20162017"=>73,
        "20172018"=>135
        })
    end

    it '#average_goals_per_game' do
      expect(stat_tracker.average_goals_per_game).to eq(4.2)
    end

    it '#all_goals_by_season' do
      expected =  {"20122013"=>[111, 452],
                   "20162017"=>[73, 318],
                   "20142015"=>[221, 900],
                   "20152016"=>[87, 363],
                   "20132014"=>[123, 525],
                   "20172018"=>[135, 592]}

      expect(stat_tracker.all_goals_by_season).to eq(expected)
    end

    it '#average_goals_by_season' do
      expect(stat_tracker.average_goals_by_season).to eq({
        "20122013" => 4.07,
        "20162017" => 4.36,
        "20142015" => 4.07,
        "20152016" => 4.17,
        "20132014" => 4.27,
        "20172018" => 4.39
        })
    end
  end
end
