require 'csv'
require_relative './game'
require_relative './team'
require_relative './game_team'
require_relative './game_statistics'
require_relative './league_statistics'
require_relative './season_statistics'
require_relative './team_statistics'

class StatTracker
  include GameStatistics
  include LeagueStatistics
  include SeasonStatistics
  include TeamStatistics

  attr_reader :games,
              :teams,
              :game_teams
              
  def initialize(stats)
    @games      = stats[:games]
    @teams      = stats[:teams]
    @game_teams = stats[:game_teams]
  end

  def self.from_csv(locations)
    stats               = {}
    stats[:games]       = create_obj_csv(locations[:games], Game)
    stats[:teams]       = create_obj_csv(locations[:teams], Team)
    stats[:game_teams]  = create_obj_csv(locations[:game_teams], GameTeam)

    StatTracker.new(stats)
  end

  def self.create_obj_csv(locations, obj_type)
    objects = []
    CSV.foreach(locations, headers: true, header_converters: :symbol) do |row|
      object = obj_type.new(row)
      objects << object
    end
    objects
  end
end
