require_relative('Tile.rb')

class Board
    def initialize
        @grid = Array.new(9) { Array.new(9) { Tile.new } }
    end
end