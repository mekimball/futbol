module GameStatistics

  def highest_total_score
    @games.map do |game|
      game.home_goals + game.away_goals
    end.max
  end

  def lowest_total_score
    @games.map do |game|
      game.home_goals + game.away_goals
    end.min
  end

  def percentage_home_wins
    home_wins = @games.find_all do |game|
        game.home_goals > game.away_goals
    end.length
    (home_wins.to_f / (games.length)).round(2)
  end

  def percentage_visitor_wins
    vistor_wins = @games.find_all do |game|
      game.away_goals > game.home_goals
    end.length
    (vistor_wins.to_f / (games.length)).round(2)
  end

  def percentage_ties
    ties = @games.find_all do |game|
      game.away_goals == game.home_goals
    end.length
    (ties.to_f / (games.length)).round(2)
  end

  def count_of_games_by_season
    @games.each_with_object({}) do |game, count|
      if count[game.season].nil?
        count[game.season] = 1
      else
        count[game.season] += 1
      end
    end
  end

  def average_goals_per_game
    total_goals = @games.sum do |game|
      game.away_goals + game.home_goals
    end
    (total_goals.to_f / (@games.length)).round(2)
  end

  def all_goals_by_season
    @games.each_with_object({}) do |game, goals|
      if goals[game.season].nil?
        goals[game.season] = [1, game.home_goals + game.away_goals]
      else
        goals[game.season][0] += 1
        goals[game.season][1] += game.home_goals + game.away_goals
      end
    end
  end

  def average_goals_by_season
    average_goals = {}
    all_goals_by_season.each do |season, stats|
      average_goals[season] = (stats[1].to_f / stats[0]).round(2)
    end
    average_goals
  end
end
