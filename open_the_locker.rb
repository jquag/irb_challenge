load File.join(File.dirname(__FILE__), 'objective.rb')

module IRBChallenge
  class OpenTheLocker < Objective
    def initialize(game)
      super
      @combination = [rand(10), rand(10), rand(10), rand(10), rand(10), rand(10)]
    end

    def help_message
      ['Set the correct combination then open the locker.',
      '',
      'set the combination:',
      '> g.set_combo(i1, i2, i3, i4, i5, i6)',
      '',
      'open the locker if #set_combo returns true',
      '> g.open_locker']
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

    def current_combo_has_strings
      @current_combination.find {|c| c.is_a? String}
    end

    def open_locker
      if test_combo
        level_complete('Congratulations! You opened the locker.')
      else
        msg = ['The locker did not open.']
        msg << '(the combination must integers)' if current_combo_has_strings
        IRBChallenge.message(*msg)
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