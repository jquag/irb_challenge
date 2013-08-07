load File.join(File.dirname(__FILE__), 'find_the_needle.rb')
load File.join(File.dirname(__FILE__), 'open_the_locker.rb')
load File.join(File.dirname(__FILE__), 'kill_the_infection.rb')
load File.join(File.dirname(__FILE__), 'turn_water_into_wine.rb')
load File.join(File.dirname(__FILE__), 'defend_the_castle.rb')

#TODO play through
#TODO fix any grammar
#TODO better intro message ... show help instead
#TODO maybe rename objective so tab works better
#TODO time for each level

module IRBChallenge

  def IRBChallenge.message(*lines)
    puts
    lines.each {|l| puts "   #{l}"}
    puts
  end

  class Game
    def initialize
      @level = 1
      @objectives = [FindTheNeedle.new(self), DefendTheCastle.new(self), KillTheInfection.new(self), TurnWaterIntoWine.new(self), OpenTheLocker.new(self)]
      @start_time = Time.now
      objective
    end

    def to_s
      "IRB Game {level: #{@level}, objective: #{current_objective}}"
    end

    def help
      if current_objective == nil
        IRBChallenge.message 'This game is over.', 'Play again:', '> g = play'
      else
        IRBChallenge.message('-HELP-', '', 'Show this message:', '> g.help', '', 'View current objective:', '> g.objective', '', 'Skip an objective:', '> g.skip')
      end
    end

    def level_complete(completed)
      if completed == current_objective
        @level += 1
        if @level > @objectives.size
          IRBChallenge.message("You finished the game in #{Time.now - @start_time} seconds\n", '', score, '', *results)
        else
          IRBChallenge.message('Review next objective:', '> g.objective')
        end
      end
    end

    def method_missing(meth, *args)
      if current_objective.respond_to?(meth)
        current_objective.send(meth, *args)
      else
        super
      end
    end

    def objective
      IRBChallenge.message('-OBJECTIVE-', '', *current_objective.help_message)
    end

    def skip
      IRBChallenge.message("Skipping '#{current_objective}'.")
      level_complete(current_objective)
    end

    private

    def score
      score = 0
      @objectives.each { |o| score += 1 if o.complete }
      "score: #{score} / #{@objectives.size}"
    end

    def results
      r = []
      r.tap do
        @objectives.each { |o| r.push("#{o} - #{o.complete ? 'completed' : 'skipped'}") }
      end
    end

    def current_objective
      @objectives[@level - 1]
    end
  end
end

def play
  IRBChallenge::Game.new
end

IRBChallenge.message('-IRB CHALLENGE-', '', 'Get started:', '> g = play', '> g.help')
