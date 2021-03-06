require './test/test_helper'
require './lib/game_manager'
require './lib/stat_tracker'

class GameManagerTest < Minitest::Test

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
    @data = @stat_tracker.load_csv(@locations[:games])
    @game_manager = GameManager.new(@data, @stat_tracker)
  end

  def test_it_exists
    assert_instance_of GameManager, @game_manager
  end

  def test_it_has_attributes
    assert_equal 7441, @game_manager.games.length
    assert_equal @stat_tracker, @game_manager.tracker
  end

  def test_get_all_game_by_team
    assert @game_manager.find_games_by_team("1").all? do |game|
      game.away_team_id == "1" || game.home_team_id == "1"
    end
  end

  def test_worst_coach
    assert_equal "Ted Nolan", @game_manager.worst_coach("20142015")
    assert_equal "Peter Laviolette", @game_manager.worst_coach("20132014")
  end

  def test_find_game_ids_of_season

    assert_equal 1319, @game_manager.find_game_ids_of_season("20142015").length
  end

  def test_highest_total_score
    assert_equal 11, @game_manager.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 0, @game_manager.lowest_total_score
  end

  def test_percentage_home_wins
    assert_equal 0.44, @game_manager.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 0.36, @game_manager.percentage_visitor_wins
  end

  def test_percentage_ties
    assert_equal 0.20, @game_manager.percentage_ties
  end

  def test_season_keys
    expected = ["20122013", "20162017", "20142015", "20152016",
      "20132014", "20172018"]
    assert_equal expected, @game_manager.season_keys
  end

  def test_count_of_games_by_season
    expected = {"20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355}
    assert_equal expected, @game_manager.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 4.22, @game_manager.average_goals_per_game
  end

  def test_total_goals_by_season
    expected = {"20122013"=> 3322,
      "20162017"=> 5565,
      "20142015"=> 5461,
      "20152016"=> 5499,
      "20132014"=> 5547,
      "20172018"=> 6019}
    assert_equal expected, @game_manager.total_goals_by_season
  end

  def test_average_goals_by_season
    expected = {"20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44}
    assert_equal expected, @game_manager.average_goals_by_season
  end
end
