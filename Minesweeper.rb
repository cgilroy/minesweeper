require_relative 'Board.rb'
require 'yaml'
class Minesweeper
    def initialize
        @board = Board.new(6,9)
        @kaboom = false
        @defused = false
    end

    def play
        
        until @kaboom || @defused do
            # debugger
            @board.render
            input = self.get_input
            if input == 'save'
                self.save_game
            elsif input == 'load'
                self.load_game
            else 
                validate_input(input)
                self.make_move(self.process_input(input))
            end
            system 'clear'
            self.game_over?
        end

    end

    def save_game
        # debugger
        begin
            File.open("last_save.yml","w") { |file| file.write(@board.to_yaml) }
        rescue
            system('clear')
            "SAVE FAILED"
            sleep(2)
        end
    end

    def load_game
        begin
            @board = YAML.load(File.read("last_save.yml"))
        rescue
            system('clear')
            puts 'LOAD FAILED'
            sleep (2)
        end
    end

    def game_over?
        if @kaboom
            @board.render(true)
            puts 'GAME OVER'
        elsif @board.all_defused?
            @board.render
            puts "YOU WIN :)"
            @defused = true
        end
    end

    def get_input
        puts "Make a move ('r 1,3' to reveal at 1,3 or 'f' to flag)"
        puts "Type 'save' at any time to save your game, or 'load' to restore your last game"
        gets.chomp
    end

    def make_move(move)
        type, pos = move
        if type == "r"
            @board[pos].reveal
            @kaboom = true if @board[pos].bombed?
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
            arr[1] = arr[1].split(',').map(&:to_i)
            raise if !['r','f'].include?(arr[0])
            raise if arr[1].length != 2
            raise if !arr[1].is_a?(Array)
            raise if arr[1].any? { |el| el > @board.size || el < 0 }
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