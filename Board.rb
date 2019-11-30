require_relative('Tile.rb')
require('byebug')

class Board
    attr_reader :grid
    def initialize(bomb_count)
        @grid = Array.new(9) { Array.new(9) { Tile.new(self) } }
        self.set_positions
        self.place_bombs(bomb_count)
    end

    def set_positions
        @grid.each_with_index do |row,row_idx|
            row.each_with_index do |tile,col_idx|
                tile.pos = [row_idx,col_idx]
            end
        end
    end

    def [](pos)
        row, col = pos
        @grid[row][col]
    end

    def place_bombs(count)
        
        until count == 0 do
            pos = [rand(9),rand(9)]
            tile = self[pos]
            if !tile.bombed?
                tile.bomb
                count -= 1
            end
        end
        # debugger
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