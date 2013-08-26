load File.join(File.dirname(__FILE__), 'objective.rb')

module IRBChallenge
  class TurnWaterIntoWine < Objective
    attr_reader :beverage

    def initialize(game)
      super
      @beverage = Water.new
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
        level_complete(*msg, "It's a miracle! You turned the water into wine.")
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