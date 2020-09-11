require './test/test_helper'
require './lib/game_teams_manager'
require './lib/stat_tracker'

class GameTeamManagerTest < Minitest::Test

  def setup
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'


    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
    @data = @stat_tracker.load_csv(@locations[:game_teams])
    @game_team_manager = GameTeamManager.new(@data, @stat_tracker)

  end

  def test_it_exists
    assert_instance_of GameTeamManager, @game_team_manager
  end

end
