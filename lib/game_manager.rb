require 'csv'
require './lib/game'

class GameManager

  def initialize(data, tracker)
    @games = []
    @tracker = tracker
    create_games(data)
  end

  def create_games(data)
    @games = data.map do |data|
      Game.new(data, self)
    end
  end

end
