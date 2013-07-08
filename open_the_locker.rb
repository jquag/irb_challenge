module IRBChallenge
  class OpenTheLocker
    attr_reader :complete

    def initialize(game)
      @game = game
      @complete = true #TODO change this back to false
      @combination = [rand(10), rand(10), rand(10), rand(10), rand(10), rand(10)]
    end

    def help_message
      ['Set the correct combination then open the locker.',
      '',
      'set the combination:',
      '> <game>.o[bjective].set_combo(i1, i2, i3, i4, i5, i6)',
      '',
      'open the locker if #set_combo returns true',
      '> <game>.o[bjective].open_locker']
    end

    def to_s
      'Open the locker'
    end

    def set_combo(i1, i2, i3, i4, i5, i6)
      @current_combination = [i1, i2, i3, i4, i5, i6]
      test_combo
    end

    def test_combo
      @current_combination == @combination
    end

    def open_locker
      if test_combo
        IRBChallenge.message('Congratulations! You opened the locker.')
        @complete = true
        @game.level_complete(self)
      else
        IRBChallenge.message('The locker did not open.')
        puts
      end
    end

    def instance_variable_get(_)
      IRBChallenge.message('Sorry, that call is not allowed here.')
    end

    def instance_variable_set(_, _)
      IRBChallenge.message('Sorry, that call is not allowed here.')
    end

  end
end