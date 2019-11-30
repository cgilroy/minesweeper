
class Tile
    @attr_reader :bombed, :revealed, :flagged
    def initialize
        @bombed = false
        @revealed = false
        @flagged = false
    end

end
