
class Tile
    attr_reader :bombed, :revealed
    attr_accessor :pos, :flagged
    def initialize(board)
        @bombed = false
        @revealed = false
        @flagged = false
        @board = board
        @pos = nil
    end

    def inspect
        { 'bombed' => @bombed, 'revealed' => @revealed, 'flagged' => @flagged, 'pos' => @pos }
    end

    def bombed?
        @bombed
    end

    def bomb
        @bombed = true
    end

    def reveal
        @revealed = true
    end

    def value
        return "X" if @bombed
        neighbours = self.neighbours(@board)
        bomb_count = neighbour_bomb_count(neighbours)
        return bomb_count.to_s if bomb_count != 0
        "_"
    end

    def neighbours(board)
        # debugger
        grid = board.grid
        center_row, center_col = @pos
        neighbours = []
        (center_row-1..center_row+1).each do |tgt_row|
            (center_col-1..center_col+1).each do |tgt_col|
                neighbours << board[[tgt_row,tgt_col]] unless !valid_pos?([tgt_row,tgt_col]) || [tgt_row,tgt_col] == @pos
            end
        end
        neighbours
        # debugger
    end

    def neighbour_bomb_count(neighbours)
        bomb_count = 0
        neighbours.each { |tile| bomb_count += 1 if tile.bombed? }
        bomb_count
    end

    def valid_pos?(pos)
        row,col = pos
        return false unless row.between?(0,@board.size-1) && col.between?(0,@board.size-1)
        true
    end

    def display_str(reveal_all = false)
        # debugger
        return self.value if @revealed || reveal_all
        return "F" if @flagged
        "*"
    end

end
