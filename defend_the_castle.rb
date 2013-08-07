module IRBChallenge
  #TODO finish this objective
  class DefendTheCastle
    MAX_ATTACKS = 4

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
       'If the dragon is weakened, then fire the catapult:',
       '> dragon.weakened?',
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
      @dragon.fire_catapult_at
      unless @dragon.defeated?
        IRBChallenge.message('Missed! The dragon had too much energy and easily dodged the projectile.')
      end
    end

    def defend_with(defense)
      MAX_ATTACKS.times do
        attack_method = "attack_#{rand(1000)}"
        @dragon.attack(attack_method, defense)

        if @dragon.defeated?
          won; return
        elsif @dragon.thwarted?
          msg = ["Dragon attack (##{attack_method}) thwarted"]
          msg << 'The dragon is weakened!' if @dragon.weakened?
          IRBChallenge.message(*msg)
        else
          failed("The dragon's attack (defense##{attack_method}) was not thwarted")
          return
        end
        sleep(1.5)
      end

      failed('Your defenses wore out. You missed an opportunity to fire the catapult.')
      nil
    end

    private

    def failed(reason)
      IRBChallenge.message(reason, 'The dragon has breached the castle walls.', '', 'Try again:', '> g.defend_with(defense)')
      @dragon = Dragon.new
    end

    def won
      IRBChallenge.message('Direct hit! The dragon was too weak to dodge the projectile.', 'Congratulations, you have successfully defended the castle.')
      @complete = true
      @game.level_complete(self)
    end

    class Dragon
      def initialize
        @thwarted_count = 0
      end

      def thwart
        if attacking?
          @state = :thwarted
          @thwarted_count += 1
        else
          IRBChallenge.message('The dragon was not attacking so there is nothing to thwart at this time.')
        end
      end

      def weakened?
        @thwarted_count >= MAX_ATTACKS
      end

      def attack(meth, defense)
        attacking
        defense.send(meth, self) rescue nil
      end

      def attacking?
        @state == :attacking
      end

      def thwarted?
        @state == :thwarted
      end

      def defeated?
        @state == :defeated
      end

      def fire_catapult_at
        defeat if weakened?
      end

      protected

      def attacking
        @state = :attacking
      end

      def defeat
        @state = :defeated
      end

    end
  end
end