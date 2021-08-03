require './lib/team'

RSpec.describe Team do
  it 'exists' do
    info = {
      team_id:      "1", 
      franchiseid:  "23", 
      teamname:     "Atlanta United", 
      abbreviation: "ATL", 
      stadium:      "Mercedes-Benz Stadium", 
      link:         "/api/v1/teams/1"
      }
    team = Team.new(info)
    expect(team).to be_a(Team)
  end

  it 'game has data' do
    info = {
      team_id:      "1", 
      franchiseid:  "23", 
      teamname:     "Atlanta United", 
      abbreviation: "ATL", 
      stadium:      "Mercedes-Benz Stadium", 
      link:         "/api/v1/teams/1"
      }
    team = Team.new(info)
    expect(team.team_id).to eq("1")
    expect(team.team_name).to eq("Atlanta United")
    expect(team.stadium).to eq("Mercedes-Benz Stadium")
    expect(team.franchise_id).to eq("23")
    expect(team.abbreviation).to eq("ATL")
    expect(team.link).to eq("/api/v1/teams/1")
  end
end
