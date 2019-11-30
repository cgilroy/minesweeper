require_relative('Tile.rb')
require('byebug')

class Board
    def initialize
        @grid = Array.new(9) { Array.new(9) { Tile.new } }
    end

    def [](pos)
        row, col = pos
        @grid[row][col]
    end

    def place_bombs(count)
        # debugger
        until count == 0 do
            pos = [rand(9),rand(9)]
            tile = self[pos]
            if !tile.bombed?
                tile.bomb
                count -= 1
            end
        end
    end

    def render
        col_str = " "
        (0..8).each { |col| col_str += " " + col.to_s }
        puts col_str
        (0..8).each do |row|
            row_str = row.to_s
            (0..8).each { |col| row_str += " " + self[[row,col]].display_str }
            puts row_str
        end
    end
end

x = Board.new
x.place_bombs(6)
x.render