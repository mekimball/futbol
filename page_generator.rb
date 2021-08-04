require "./lib/stat_tracker"
require 'erb'

class PageGenerator
  attr_reader :stat_tracker, :template
  def initialize(locations)
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def render(template_name)
    ERB.new(template_name).result(binding)
  end
end
