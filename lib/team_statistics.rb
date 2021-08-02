module TeamStatistics

  def team_info(team_id)
    find_team = @teams.find do |team|
      team.team_id == team_id
    end
    team_info = {
      "team_id" => find_team.team_id,
      "franchise_id" => find_team.franchise_id,
      "team_name" => find_team.team_name,
      "abbreviation" => find_team.abbreviation,
      "link" => find_team.link
    }
  end

  def find_games_by_team_id(team_id)
    games_by_team = @games.find_all do |game|
      game.away_team_id == team_id || game.home_team_id == team_id
    end
    games_by_team
  end

  def team_win?(team_id, game)
    away = game.away_team_id == team_id && game.away_goals > game.home_goals
    home = game.home_team_id == team_id && game.home_goals > game.away_goals
    if home || away
      true
    else
      false
    end
  end

  def find_win_count(team_id)
    find_games_by_team_id(team_id).each_with_object({}) do |game, season_wins|
      if season_wins[game.season].nil?
        season_wins[game.season] = [0, 0]# total games, wins
      end
      season_wins[game.season][0] += 1
      if team_win?(team_id, game)
        season_wins[game.season][1] += 1
      end
    end
  end

  def best_season(team_id)
    best_season = find_win_count(team_id).max_by do |season, wins|
      wins[1] / wins[0].to_f
    end
    best_season.first
  end

  def worst_season(team_id)
    worst_season = find_win_count(team_id).min_by do |season, wins|
      wins[1] / wins[0].to_f
    end
    worst_season.first
  end

  def total_win_count(team_id)
    team_wins = @game_teams.count do |game|
      team_id == game.team_id && game.result == "WIN"
    end
    team_wins
  end

  def average_win_percentage(team_id)
    win = total_win_count(team_id).to_f / find_games_by_team_id(team_id).count
    win.round(2)
  end

  def game_teams_by_id(team_id)
    @game_teams.find_all do |game|
      game.team_id == team_id
    end
  end

  def most_goals_scored(team_id)
    most_goals = game_teams_by_id(team_id).max_by do |game|
      game.goals
    end
    most_goals.goals
  end

  def fewest_goals_scored(team_id)
    fewest_goals = game_teams_by_id(team_id).min_by do |game|
      game.goals
    end
    fewest_goals.goals
  end

  def games_against_rivals(team_id)
    all_games = home_games_rivals(team_id).merge(away_games_rivals(team_id)){|k,v1,v2|[v1,v2].flatten}
    all_games
  end

  def home_games_rivals(team_id)
    find_games_by_team_id(team_id).each_with_object({}) do |game, rival_games|
      if game.home_team_id == team_id && rival_games[game.away_team_id].nil?
        rival_games[game.away_team_id] = [game]
      elsif game.home_team_id == team_id
        rival_games[game.away_team_id] << game
      end
    end
  end

  def away_games_rivals(team_id)
    find_games_by_team_id(team_id).each_with_object({}) do |game, rival_games|
      if game.away_team_id == team_id && rival_games[game.home_team_id].nil?
        rival_games[game.home_team_id] = [game]
      elsif game.away_team_id == team_id
        rival_games[game.home_team_id] << game
      end
    end
  end

  def wins_against_rivals(team_id)
    wins_against_rivals = wins_hash(team_id)
    games_against_rivals(team_id).each do |rival, games|
      games.each do |game|
        wins_against_rivals[rival][0] += 1
        if (game.away_team_id == team_id && game.away_goals > game.home_goals) ||
          (game.home_team_id == team_id && game.home_goals > game.away_goals)
          wins_against_rivals[rival][1] += 1
        end
      end
    end
    wins_against_rivals
  end

  def wins_hash(team_id)
    wins_against_rivals = {}
    games_against_rivals(team_id).each do |rival, games|
      if wins_against_rivals[rival].nil?
        wins_against_rivals[rival] = [0, 0]
      end
    end
    wins_against_rivals
  end

  def favorite_opponent(team_id)
    favorite = wins_against_rivals(team_id).max_by do |team, stats|
      stats[1].to_f / stats[0]
    end
    team_name_by_team_id(favorite.first)
  end

  def rival(team_id)
    least_favorite = wins_against_rivals(team_id).min_by do |team, stats|
      stats[1].to_f / stats[0]
    end
    team_name_by_team_id(least_favorite.first)
  end
end
