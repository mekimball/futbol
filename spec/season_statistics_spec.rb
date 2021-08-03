require './spec/spec_helper'
require './lib/stat_tracker'
require './lib/season_statistics'

RSpec.describe SeasonStatistics do
  context 'Season stats methods' do
    game_path       = './spec/fixture_files/test_games.csv'
    team_path       = './spec/fixture_files/test_teams.csv'
    game_teams_path = './spec/fixture_files/test_game_teams.csv'

    locations = {
      games:      game_path,
      teams:      team_path,
      game_teams: game_teams_path
      }

    stat_tracker = StatTracker.from_csv(locations)

    it '#game_ids_by_season' do
      expect(stat_tracker.game_ids_by_season("20122013").size).to eq(111)
    end

    it '#game_teams_by_season' do
      expect(stat_tracker.game_teams_by_season("20122013").size).to eq(220)
    end

    it '#coach_stats_by_season' do
      expect(stat_tracker.coach_stats_by_season("20122013")["John Tortorella"]).to eq([14, 2])
    end

    it '#winningest_coach' do
      expect(stat_tracker.winningest_coach("20132014")).to eq("Claude Noel")
    end

    it '#worst_coach' do
      expect(stat_tracker.worst_coach("20132014")).to eq("Mike Babcock")
    end

    it '#team_shots_by_season' do
      expect(stat_tracker.team_shots_by_season("20122013")["3"]).to eq([19, 100])
    end

    it '#most_accurate_team' do
      expect(stat_tracker.most_accurate_team("20132014")).to eq "Utah Royals FC"
      expect(stat_tracker.most_accurate_team("20142015")).to eq "Toronto FC"
    end

    it "#least_accurate_team" do
      expect(stat_tracker.least_accurate_team("20132014")).to eq "Sky Blue FC"
      expect(stat_tracker.least_accurate_team("20142015")).to eq "North Carolina Courage"
    end

    it "#tackles_by_season" do
      expect(stat_tracker.tackles_by_season("20132014")["3"]).to eq 102
    end

    it "#most_tackles" do
      expect(stat_tracker.most_tackles("20132014")).to eq "FC Cincinnati"
      expect(stat_tracker.most_tackles("20142015")).to eq "DC United"
    end

    it "#fewest_tackles" do
      expect(stat_tracker.fewest_tackles("20132014")).to eq "Sky Blue FC"
      expect(stat_tracker.fewest_tackles("20142015")).to eq "North Carolina Courage"
    end
  end
end
