require_relative 'Board.rb'

class Minesweeper
    def initialize
        @board = Board.new(6)
        @kaboom = false
        @defused = false
    end

    def play
        
        until @kaboom || @defused do
            @board.render
            input = self.get_input
            if validate_input(input)
                self.make_move(self.process_input(input))
            end
            system 'clear'
        end

    end

    def get_input
        puts "Make a move ('r 1,3' to reveal at 1,3 or 'f' to flag"
        gets.chomp
    end

    def make_move(move)
        type, pos = move
        if type == "r"
            @board[pos].reveal
        elsif type == "f"
            @board[pos].flagged = !@board[pos].flagged
        end
    end

    def process_input(input)
        arr = input.split(" ")
        arr[1] = arr[1].split(',').map(&:to_i)
        arr
    end

    def validate_input(input)
        # debugger
        begin
            arr = input.split(" ")
            raise if !['r','f'].include?(arr[0])
            true
        rescue
            puts "Please enter your move using valid syntax"
            sleep (3)
            false
        end
    end
end

x = Minesweeper.new
x.play