load File.join(File.dirname(__FILE__), 'find_the_needle.rb')
load File.join(File.dirname(__FILE__), 'open_the_locker.rb')
load File.join(File.dirname(__FILE__), 'kill_the_infection.rb')
load File.join(File.dirname(__FILE__), 'turn_water_into_wine.rb')
load File.join(File.dirname(__FILE__), 'defend_the_castle.rb')
#defend the castle (write a proc/or class to handle various projectiles/dragon maneuvers ... will need to update as you learn ...maybe something like simon)

#TODO make objective private and pass through method calls
#TODO make a skip level function

module IRBChallenge

  def IRBChallenge.message(*lines)
    puts "\n ----------------------------------------"
    lines.each {|l| puts "|  #{l}"}
    puts " ----------------------------------------\n\n"
  end

  class Game
    def initialize
      @level = 1
      @objectives = [DefendTheCastle.new(self), KillTheInfection.new(self), TurnWaterIntoWine.new(self), FindTheNeedle.new(self), OpenTheLocker.new(self)]
      @start_time = Time.now
      help
    end

    def objective
      @objectives[@level - 1]
    end

    alias_method :o, :objective

    def to_s
      "IRB Game {level: #{@level}, objective: #{objective}}"
    end

    def help
      if objective == nil
        IRBChallenge.message 'This game is over.', 'Play again:', '> g = play'
      else
        IRBChallenge.message('-HELP-  ', 'Show this message:', '> g.help', '', 'Skip an objective:', '> g.skip', '', '-OBJECTIVE-', *objective.help_message)
      end
    end

    def level_complete(completed)
      if completed == objective && objective.complete
        @level += 1
        if @level > @objectives.size
          IRBChallenge.message('Great Job.', "You finished the game in #{Time.now - @start_time} seconds\n")
        else
          IRBChallenge.message('-NEXT OBJECTIVE-', *(o.help_message))
        end
      else
        IRBChallenge.message("You ain't got to lie")
      end
    end

  end
end

def play
  IRBChallenge::Game.new
end

IRBChallenge.message('IRB CHALLENGE', '', 'Get started:', '> g = play')