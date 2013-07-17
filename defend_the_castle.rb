module IRBChallenge
  #TODO finish this objective
  class DefendTheCastle
    attr_reader :complete

    def initialize(game)
      @game = game
      @complete = false
      @dragon = Dragon.new
    end

    def help_message
      ['Defend the castle from the dragon.', '',
       'Setup your defenses (the defense must respond to all dragon attacks):',
       '> g.defend_with(defense)', '',
       "Thwart the dragon's attack (the dragon will be passed to the defense method when attacking):",
       '> dragon.thwart', '',
       "If the dragon's state is :weakened, then fire the catapult:",
       '> dragon.state',
       '> g.fire_catapult'
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

    def fire_catapult
      if @dragon.state == :weakened
        IRBChallenge.message('Direct hit! The dragon was too weak to dodge the projectile.', 'Congratulations, you have successfully defended the castle.')
        @complete = true
        @game.level_complete(self)
      else
        IRBChallenge.message('Missed! The dragon had too much energy and easily dodged the projectile.')
      end
    end

    private

    class Dragon
      attr_reader :state

      def initialize
        @state = :fierce
      end

      def thwart
        @thwarted_count += 1
      end

      private

      attr_accessor :attacking
    end
  end
end