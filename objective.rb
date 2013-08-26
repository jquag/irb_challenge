module IRBChallenge
  class Objective
    attr_reader :time
    attr_reader :complete
    attr_reader :game

    def initialize(game)
      @game = game
      @complete = false
    end

    def start
      @start_time = Time.now
    end

    def level_complete(*message)
      IRBChallenge.message(*message) if message
      @complete = true
      @time = (Time.now - @start_time).floor
      @game.level_complete(self)
    end

  end
end