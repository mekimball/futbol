require './lib/stat_tracker'
require './spec/spec_helper'
require './lib/team_statistics'

RSpec.describe TeamStatistics do
  context 'Team stats methods' do
    game_path       = './spec/fixture_files/test_games.csv'
    team_path       = './spec/fixture_files/test_teams.csv'
    game_teams_path = './spec/fixture_files/test_game_teams.csv'

    locations = {
      games:      game_path,
      teams:      team_path,
      game_teams: game_teams_path
      }

    stat_tracker = StatTracker.from_csv(locations)

    it '#team_info(team_id)' do
      expected = {
        "team_id" =>      "18",
        "franchise_id" => "34",
        "team_name" =>    "Minnesota United FC",
        "abbreviation" => "MIN",
        "link" =>         "/api/v1/teams/18"
        }
      expect(stat_tracker.team_info("18")).to eq(expected)
    end

    it '#team_win?' do
      expect(stat_tracker.team_win?("3", stat_tracker.games[0])).to be false
      expect(stat_tracker.team_win?("6", stat_tracker.games[0])).to be true
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
    it "#game_teams_by_id(team_id)" do
      expect(stat_tracker.game_teams_by_id("18")).to be_an(Array)
      expect(stat_tracker.game_teams_by_id("18").length).to eq(28)
    end

    it "#most_goals_scored(team_id)" do
      expect(stat_tracker.most_goals_scored("18")).to eq 5
    end

    it "#fewest_goals_scored(team_id)" do
      expect(stat_tracker.fewest_goals_scored("18")).to eq 0
    end

  #mock and stub
    it "#games_against_rivals(team_id)" do
      expect(stat_tracker.games_against_rivals("18")).to be_a(Hash)
      expect(stat_tracker.games_against_rivals("18").length).to eq(17)
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
