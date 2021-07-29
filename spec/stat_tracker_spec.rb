require './lib/stat_tracker'
require './spec/spec_helper'

RSpec.describe StatTracker do
  context '#initialize' do
  game_path = './spec/fixture_files/test_games.csv'
  team_path = './spec/fixture_files/test_teams.csv'
  game_teams_path = './spec/fixture_files/test_game_teams.csv'

  locations = {
  games: game_path,
  teams: team_path,
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

  context 'Season stats methods' do
    game_path = './spec/fixture_files/test_games.csv'
    team_path = './spec/fixture_files/test_teams.csv'
    game_teams_path = './spec/fixture_files/test_game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    it '#winningest_coach' do
      expect(stat_tracker.winningest_coach("20132014")).to eq("Claude Noel")
    end

    it '#worst_coach' do
      expect(stat_tracker.worst_coach("20132014")).to eq("Mike Babcock")
    end

    it '#game_ids_by_season' do
      expect(stat_tracker.game_ids_by_season("20122013").size).to eq(111)
    end

    it '#game_teams_by_season' do
      expect(stat_tracker.game_teams_by_season("20122013").size).to eq(220)
    end

    it '#coach_stats_by_season' do
      expect(stat_tracker.coach_stats_by_season("20122013")["John Tortorella"]).to eq([14, 2])
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

  context 'Team stats methods' do
    game_path = './spec/fixture_files/test_games.csv'
    team_path = './spec/fixture_files/test_teams.csv'
    game_teams_path = './spec/fixture_files/test_game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    it '#team_info(team_id)' do
      expected = {
        "team_id" => "18",
        "franchise_id" => "34",
        "team_name" => "Minnesota United FC",
        "abbreviation" => "MIN",
        "link" => "/api/v1/teams/18"
        }
      expect(stat_tracker.team_info("18")).to eq(expected)
    end

    it "#find_win_count" do
      expect(stat_tracker.find_win_count("6")).to eq({
        "20122013"=>[11, 10],
        "20172018"=>[16, 10],
        "20132014"=>[8, 6],
        "20142015"=>[10, 4],
        "20152016"=>[3, 1],
        "20162017"=>[2, 0]
        })
    end

    it "#best_season(team_id)" do
      expect(stat_tracker.best_season("6")).to eq "20122013"
    end

    it "#worst_season(team_id)" do
      expect(stat_tracker.worst_season("6")).to eq "20162017"
    end

    it "#total_win_count(team_id)" do
      expect(stat_tracker.total_win_count("6")).to eq 23
    end

    it "#average_win_percentage(team_id)" do
      expect(stat_tracker.average_win_percentage("6")).to eq 0.46
    end

#MOCK N STUB
    xit "#game_teams_by_id(team_id)" do
      expect(stat_tracker.game_teams_by_id("18")).to eq 7
    end

    it "#most_goals_scored(team_id)" do
      expect(stat_tracker.most_goals_scored("18")).to eq 5
    end

    it "#fewest_goals_scored(team_id)" do
      expect(stat_tracker.fewest_goals_scored("18")).to eq 0
    end

#mock and stub
    xit "#games_against_rivals(team_id)" do
      expect(stat_tracker.games_against_rivals("18")[3]).to eq 0
    end

    it "#win_percentage_against_rivals(team_id)" do
      expect(stat_tracker.wins_against_rivals("18")["3"]).to eq [1, 0]
    end

    it "#favorite_opponent(team_id)" do
      expect(stat_tracker.favorite_opponent("18")).to eq("Atlanta United")
    end

    it "#rival(team_id)" do
      expect(stat_tracker.rival("18")).to eq("Houston Dash").or(eq("LA Galaxy"))
    end
  end
end
