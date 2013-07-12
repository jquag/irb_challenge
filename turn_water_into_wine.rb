module IRBChallenge
  class TurnWaterIntoWine
    attr_reader :beverage
    attr_reader :complete

    def initialize(game)
      @beverage = Water.new
      @game = game
      @complete = false
    end

    def help_message
      ['Turn the water into (red) wine.',
       '',
       'Access the beverage:',
       '> g.beverage',
       '',
       'Taste it:',
       '> g.taste']
    end

    def to_s
      'Turn water into wine'
    end

    def taste
      msg = ["#color => #{@beverage.color}", "#percent_alcohol => #{@beverage.percent_alcohol}", '']
      if @beverage.color != 'red'
        IRBChallenge.message(*msg, "Doesn't look like any wine I would drink.")
      elsif @beverage.percent_alcohol <= 0
        IRBChallenge.message(*msg, "Doesn't taste like wine")
      else
        IRBChallenge.message(*msg, "It's a miracle! You turned the water into wine.")
        @complete = true
        @game.level_complete(self)
      end
    end

    def instance_variable_get(_)
      IRBChallenge.message('Sorry, that call is not allowed here.')
    end

    def instance_variable_set(_, _)
      IRBChallenge.message('Sorry, that call is not allowed here.')
    end
  end

  class Water
    def color
      'clear'
    end

    def percent_alcohol
      0
    end
  end
end