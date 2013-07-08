module IRBChallenge
  class KillTheInfection
    attr_reader :complete

    def initialize(game)
      @game = game
      @complete = true #TODO change this back to false
      @cells = [
          {:type => :bacteria, :antigen => 'cell'},
          {:type => :healthy_cell, :antigen => 'cell_0'},
          {:type => :bacteria, :antigen => 'cell_1'},
          {:type => :healthy_cell, :antigen => 'cell_2'},
          {:type => :bacteria, :antigen => 'cell_3'},
          {:type => :healthy_cell, :antigen => 'cell_4'},
          {:type => :bacteria, :antigen => 'cell_5'},
          {:type => :healthy_cell, :antigen => 'cell_6'},
          {:type => :bacteria, :antigen => 'cell_7'},
          {:type => :healthy_cell, :antigen => 'cell_8'},
          {:type => :bacteria, :antigen => 'cell_9'},
          {:type => :healthy_cell, :antigen => 'cell_10'},
          {:type => :bacteria, :antigen => 'cell_11'},
          {:type => :healthy_cell, :antigen => 'cell_12'},
          {:type => :bacteria, :antigen => 'cell_13'},
          {:type => :healthy_cell, :antigen => 'cell_14'},
          {:type => :bacteria, :antigen => 'cell_15'},
          {:type => :healthy_cell, :antigen => 'cell_16'},
          {:type => :bacteria, :antigen => 'cell_17'},
          {:type => :healthy_cell, :antigen => 'cell_18'},
          {:type => :bacteria, :antigen => 'cell_19'},
          {:type => :healthy_cell, :antigen => 'cell_20'},
          {:type => :bacteria, :antigen => 'cell_21'},
          {:type => :healthy_cell, :antigen => 'cell_22'},
          {:type => :bacteria, :antigen => 'cell_23'},
          {:type => :healthy_cell, :antigen => 'cell_24'},
          {:type => :bacteria, :antigen => 'bacteria'},
          {:type => :healthy_cell, :antigen => 'good cell'}
      ]
    end

    def help_message
      ['Construct an antibody (regex) that targets the bacteria while avoiding healthy cells.',
        '',
        'view the infection to see the antigens for all of the cells:',
        '> <game>.o[bjective].view',
        '',
        'deliver an antibody to try and kill the infection:',
        '> <game>.o[bjective].deliver_antibody(/pattern/)']
    end

    def view
      msg = %w(bacteria-)
      @cells.select {|c| c[:type] == :bacteria}.each do |b|
        msg.push("  antigen: #{b[:antigen]}")
      end
      msg.push('', 'healthy cells-')
      @cells.select {|c| c[:type] == :healthy_cell}.each do |b|
        msg.push("  antigen: #{b[:antigen]}")
      end
      IRBChallenge.message(*msg)
    end

    def deliver_antibody(antibiotic)
      if antibiotic.to_s.size > 45
        IRBChallenge.message("\nYour antibody is too complicated. Reduce the length and try again.\n\n")
        return
      end
      @cells.each do |cell|
        if cell[:antigen] =~ antibiotic
          if cell[:type] == :healthy_cell
            IRBChallenge.message('Your antibody killed one or more healthy cells.', '', "#{cell[:antigen]}")
            return
          end
        else
          if cell[:type] == :bacteria
            IRBChallenge.message('Your antibody did not kill all of the bacteria.','', 'e.g.', "antigen: #{cell[:antigen]}")
            return
          end
        end
      end

      IRBChallenge.message('Congratulations! You killed the infection.')
      @game.level_complete(self)
    end

    def to_s
      'Kill the infection'
    end

    def instance_variable_get(_)
      IRBChallenge.message('Sorry, that call is not allowed here.')
    end

    def instance_variable_set(_, _)
      IRBChallenge.message('Sorry, that call is not allowed here.')
    end

  end
end