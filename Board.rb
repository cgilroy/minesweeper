require_relative('Tile.rb')
require('byebug')

class Board
    attr_reader :grid, :size
    def initialize(bomb_count, size)
        @size = size
        @grid = Array.new(size) { Array.new(size) { Tile.new(self) } }
        self.set_positions
        self.place_bombs(bomb_count)
    end

    def all_defused?
        @grid.each_with_index do |row,row_idx|
            row.each_with_index do |tile,col_idx|
                return false if tile.bombed? == false && tile.revealed? == false
                return false if tile.bombed? == true && tile.flagged == false
            end
        end
        true
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
        # debugger
        until count == 0 do
            pos = [rand(@size),rand(@size)]
            tile = self[pos]
            if !tile.bombed?
                tile.bomb
                count -= 1
            end
        end
        # debugger
    end

    def render(reveal_all = false)
        # debugger
        col_str = " "
        (0..@size-1).each { |col| col_str += " " + col.to_s }
        puts col_str
        (0..@size-1).each do |row|
            row_str = row.to_s
            (0..@size-1).each { |col| row_str += " " + self[[row,col]].display_str(reveal_all) }
            puts row_str
        end
    end
end