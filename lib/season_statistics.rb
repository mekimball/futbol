module SeasonStatistics

  def game_ids_by_season(season)
    @games.map do |game|
      game.game_id if game.season == season
    end.compact
  end

  def game_teams_by_season(season)
    game_ids = game_ids_by_season(season)
    @game_teams.find_all do |game_team|
      game_ids.include?(game_team.game_id)
    end
  end

  def coach_stats_by_season(season)
    game_teams_by_season(season).each_with_object({}) do |game_team, coaches|
      if coaches[game_team.head_coach].nil?
        coaches[game_team.head_coach] = [0, 0] #[game count, win count]
      end
      coaches[game_team.head_coach][0] += 1
      coaches[game_team.head_coach][1] += 1 if game_team.result == "WIN"
    end
  end

  def winningest_coach(season)
    best_coach = coach_stats_by_season(season).max_by do |coach, stats|
      stats[1].to_f / stats[0]
    end
    best_coach.first
  end

  def worst_coach(season)
    baddest_coach = coach_stats_by_season(season).min_by do |coach, stats|
      stats[1].to_f / stats[0]
    end
    baddest_coach.first
  end

  def team_shots_by_season(season)
    game_teams_by_season(season).each_with_object({}) do |game_team, teams_shots|
      if teams_shots[game_team.team_id].nil?
        teams_shots[game_team.team_id]  = [0, 0] #[goals , shots]
      end
      teams_shots[game_team.team_id][0] += game_team.goals
      teams_shots[game_team.team_id][1] += game_team.shots
    end
  end

  def most_accurate_team(season)
    most_accurate = team_shots_by_season(season).max_by do |team, stats|
      stats[0] / stats[1].to_f
    end
    team_name_by_team_id(most_accurate.first)
  end

  def least_accurate_team(season)
    least_accurate = team_shots_by_season(season).min_by do |team, stats|
      stats[0] / stats[1].to_f
    end
    team_name_by_team_id(least_accurate.first)
  end

  def tackles_by_season(season)
    game_teams_by_season(season).each_with_object({}) do |game_team, tackles|
      if tackles[game_team.team_id].nil?
        tackles[game_team.team_id]  = 0
      end
      tackles[game_team.team_id] += game_team.tackles
    end
  end

  def most_tackles(season)
    most_tackles = tackles_by_season(season).max_by do |team, tackles|
      tackles
    end
    team_name_by_team_id(most_tackles.first)
  end

  def fewest_tackles(season)
    fewest_tackles = tackles_by_season(season).min_by do |team, tackles|
      tackles
    end
    team_name_by_team_id(fewest_tackles.first)
  end
end
