load File.join(File.dirname(__FILE__), 'objective.rb')

module IRBChallenge
  class FindTheNeedle < Objective
    HAYSTACK_SIZE = 10000
    attr_reader :haystack

    def initialize(game)
      super
      @needle = Needle.new
      @haystack = []
      build_haystack(@haystack, rand(HAYSTACK_SIZE))
    end

    def help_message
      ['Find the needle in the haystack', '',
       'Access the haystack:',
       '> g.haystack',
       '',
       'Present the needle:',
       '> g.present(needle)']
    end

    def to_s
      'Find the needle'
    end

    def present(obj)
      if obj == @needle
        level_complete('Congratulations! You found it.')
      else
        IRBChallenge.message('You call that a needle?')
      end
    end

    def instance_variable_get(_)
      IRBChallenge.message('Sorry, that call is not allowed here.')
    end

    def instance_variable_set(_, _)
      IRBChallenge.message('Sorry, that call is not allowed here.')
    end

    private

    def build_haystack(haystack, needle_index, size=0, depth=0)
      while size < HAYSTACK_SIZE
        type = rand(3)
        item = size == needle_index ? @needle : 'hay'

        case type
          when 0 #go up one level
            if depth == 0
              haystack.push(item)
              size = size + 1
            else
              return size
            end
          when 1 #add to current level
            haystack.push(item)
            size = size + 1
          else #create a new level
            new_stack = [item]
            haystack.push(new_stack)
            size = size + 1
            size = build_haystack(new_stack, needle_index, size, depth + 1)
        end
      end
      size
    end
  end

  class Needle
    def to_s
      'needle'
    end
  end
end