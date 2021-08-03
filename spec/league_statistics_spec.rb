require './spec/spec_helper'
require './lib/stat_tracker'
require './lib/league_statistics'

RSpec.describe LeagueStatistics do
  context 'league stats methods' do
    game_path       = './spec/fixture_files/test_games.csv'
    team_path       = './spec/fixture_files/test_teams.csv'
    game_teams_path = './spec/fixture_files/test_game_teams.csv'

    locations = {
      games:      game_path,
      teams:      team_path,
      game_teams: game_teams_path
      }

    stat_tracker = StatTracker.from_csv(locations)

    it '#count_of_teams' do
      expect(stat_tracker.count_of_teams).to eq(32)
    end

    it '#games_by_team_id' do
      expect(stat_tracker.games_by_team_id).to be_a Hash
    end

  #mock and stub
    it '#goals_per_team' do
      expect(stat_tracker.goals_per_team["3"]).to eq([2, 2, 1, 2, 1, 1, 0, 2, 2, 1, 1, 3, 2, 2, 1, 0, 3, 2, 3, 2, 2, 2, 2, 2, 3, 3, 0, 5, 0, 1, 3, 0, 1, 2, 2, 2, 3, 2, 1, 1, 3, 0])
    end

    it '#team_name_by_team_id' do
      expect(stat_tracker.team_name_by_team_id("1")).to eq("Atlanta United")
    end

    it '#best_offense' do
      expect(stat_tracker.best_offense).to eq("FC Dallas")
    end

    it '#worst_offense' do
      expect(stat_tracker.worst_offense).to eq("Sky Blue FC")
    end

  # MOCK AND STUB PLZ
    it '#finds_home_games' do
      expect(stat_tracker.games_by_hoa("home")["3"]).to eq([20, 32])
    end

    it '#highest_scoring_visitor' do
      expect(stat_tracker.highest_scoring_visitor).to eq("Columbus Crew SC")
    end

    it '#highest_scoring_home_team' do
      expect(stat_tracker.highest_scoring_home_team).to eq("San Jose Earthquakes")
    end

    it '#lowest_scoring_visitor' do
      expect(stat_tracker.lowest_scoring_visitor).to eq("Chicago Fire")
    end

    it '#lowest_scoring_home_team' do
      expect(stat_tracker.lowest_scoring_home_team).to eq("Washington Spirit FC")
    end
  end
end
