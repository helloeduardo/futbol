require 'csv'
require './lib/team'

class TeamManager
  attr_reader :teams, :tracker

  def initialize(data, tracker)
    @teams = []
    @tracker = tracker
    create_teams(data)
  end

  def create_teams(data)
    @teams = data.map do |data|
      Team.new(data, self)
    end
  end

<<<<<<< HEAD
  def count_of_teams
    @teams.count
=======
  def find_team(team_id)
    teams.find do |team|
      team.team_id == team_id
    end
  end

  def team_info(team_id)
    find_team(team_id).team_info
>>>>>>> be9913e91895bda4538bb526bc83a0eeeaeb00b2
  end

end
