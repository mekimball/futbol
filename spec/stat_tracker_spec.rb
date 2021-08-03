require './lib/stat_tracker'
require './spec/spec_helper'

RSpec.describe StatTracker do
  context '#initialize' do
    game_path       = './spec/fixture_files/test_games.csv'
    team_path       = './spec/fixture_files/test_teams.csv'
    game_teams_path = './spec/fixture_files/test_game_teams.csv'

    locations = {
      games:      game_path,
      teams:      team_path,
      game_teams: game_teams_path
      }

    stat_tracker = StatTracker.new(locations)
    stat_tracker = StatTracker.from_csv(locations)

    it 'exists' do
      expect(stat_tracker).to be_a StatTracker
    end

    it 'accepts data' do
      expect(stat_tracker.games[0].game_id).to eq("2012030221")
      expect(stat_tracker.games[0].away_goals).to eq(2)
      expect(stat_tracker.teams[0].team_id).to eq("1")
      expect(stat_tracker.game_teams[0].game_id).to eq("2012030221")
      expect(stat_tracker).to be_a(StatTracker)
    end
  end
end
