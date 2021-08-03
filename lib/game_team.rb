class GameTeam
  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :tackles,
              :pim,
              :powerplay_opportunities,
              :powerplay_goals,
              :faceoff_win_percentage,
              :giveaways,
              :takeaways

  def initialize(stats)
    @game_id = stats[:game_id]
    @team_id = stats[:team_id]
    @hoa = stats[:hoa]
    @result = stats[:result]
    @settled_in = stats[:settled_in]
    @head_coach = stats[:head_coach]
    @goals = stats[:goals].to_i
    @shots = stats[:shots].to_i
    @tackles = stats[:tackles].to_i
    @pim = stats[:pim].to_i
    @powerplay_opportunities = stats[:powerplayopportunities].to_i
    @powerplay_goals = stats[:powerplaygoals].to_i
    @faceoff_win_percentage = stats[:faceoffwinpercentage].to_f
    @giveaways = stats[:giveaways].to_i
    @takeaways = stats[:takeaways].to_i
  end
end
