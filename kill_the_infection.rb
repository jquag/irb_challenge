load File.join(File.dirname(__FILE__), 'objective.rb')

module IRBChallenge
  class KillTheInfection < Objective

    def initialize(game)
      super
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
        '> g.view',
        '',
        'deliver an antibody to try and kill the infection:',
        '> g.deliver_antibody(/pattern/)']
    end

    def view
      msg = ["bacteria\t\thealthy cells", "--------\t\t-------------"]
      bacteria = @cells.select {|c| c[:type] == :bacteria}
      good_cells = @cells.select {|c| c[:type] == :healthy_cell}

      bacteria.each_with_index do |b, i|
        msg.push("antigen: #{b[:antigen]}\tantigen: #{good_cells[i][:antigen]}")
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
            IRBChallenge.message('Your antibody killed one or more healthy cells.', '', 'e.g.', "#{cell[:antigen]}")
            return
          end
        else
          if cell[:type] == :bacteria
            IRBChallenge.message('Your antibody did not kill all of the bacteria.','', 'e.g.', "#{cell[:antigen]}")
            return
          end
        end
      end

      level_complete('Congratulations! You killed the infection.')
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