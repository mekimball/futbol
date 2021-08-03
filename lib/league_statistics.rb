module LeagueStatistics

  def count_of_teams
    @teams.count
  end

  def games_by_team_id
    @game_teams.each_with_object({}) do |team, teams|
      if teams[team.team_id].nil?
        teams[team.team_id] = [team]
      else
        teams[team.team_id] << team
      end
    end
  end

  def goals_per_team
    @game_teams.each_with_object({}) do |team, team_goals|
      if team_goals[team.team_id].nil?
        team_goals[team.team_id] = [team.goals]
      else
        team_goals[team.team_id] << team.goals
      end
    end
  end

  def team_name_by_team_id(team_id)
    team = @teams.find do |team|
      team_id == team.team_id
    end
    team.team_name
  end

  def best_offense
    team_id = goals_per_team.max_by do |team, goals|
      goals.sum / goals.count.to_f
    end
    team_name_by_team_id(team_id.first)
  end

  def worst_offense
    team_id = goals_per_team.min_by do |team, goals|
      goals.sum / goals.count.to_f
    end
    team_name_by_team_id(team_id.first)
  end

  def games_by_hoa(hoa)
    hoa_by_team_id = {}
    games_by_team_id.each do |id, games|
      games.each do |game|
          if game.hoa == hoa && hoa_by_team_id[id].nil?
            hoa_by_team_id[id] = [1, game.goals]
          elsif game.hoa == hoa
            hoa_by_team_id[id][0] += 1
            hoa_by_team_id[id][1] += game.goals
          end
      end
    end
    hoa_by_team_id
  end

  def highest_scoring_visitor
    highest_visitor = games_by_hoa("away").max_by do |team, stats|
      stats[1] / stats[0].to_f
    end
    team_name_by_team_id(highest_visitor.first)
  end

  def highest_scoring_home_team
    highest_home_team = games_by_hoa("home").max_by do |team, stats|
      stats[1] / stats[0].to_f
    end
    team_name_by_team_id(highest_home_team.first)
  end

  def lowest_scoring_visitor
    lowest_away_team = games_by_hoa("away").min_by do |team, stats|
      stats[1] / stats[0].to_f
    end
    team_name_by_team_id(lowest_away_team.first)
  end

  def lowest_scoring_home_team
    lowest_home_team = games_by_hoa("home").min_by do |team, stats|
      stats[1] / stats[0].to_f
    end
    team_name_by_team_id(lowest_home_team.first)
  end
end
