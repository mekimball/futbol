class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link

  def initialize(stats)
    @team_id = stats[:team_id]
    @franchise_id = stats[:franchiseid]
    @team_name = stats[:teamname]
    @abbreviation = stats[:abbreviation]
    @stadium = stats[:stadium]
    @link = stats[:link]
  end
end
