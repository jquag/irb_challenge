module IRBChallenge
  #TODO finish this objective
  class DefendTheCastle
    attr_reader :complete

    def initialize(game)
      @game = game
      @complete = false
    end

    def help_message
      ['Defend the castle from the dragon.', '',
       'Employ strategy:',
       '> g.employ {|dragon, castle| <strategic response>}', '',
       'Attack the dragon:',
      '> dragon.attack blah blah blah'
      ]
    end

    def to_s
      'Defend the castle'
    end

    def instance_variable_get(_)
      IRBChallenge.message('Sorry, that call is not allowed here.')
    end

    def instance_variable_set(_, _)
      IRBChallenge.message('Sorry, that call is not allowed here.')
    end
  end
end